<?php
declare(strict_types=1);

require_once __DIR__ . '/../includes/helpers.php';
require_once __DIR__ . '/../includes/sections.php';

class SangKienSimilarity
{
    /**
     * Trọng số khi NLP kiểm tra sâu.
     *
     * Parser hiện tại dùng 5 section:
     * - ten
     * - linh_vuc
     * - boi_canh
     * - noi_dung
     * - hieu_qua
     */
    private const WEIGHTS = [
        'ten'       => 1.5,
        'linh_vuc'  => 0.5,
        'boi_canh'  => 1.0,
        'noi_dung'  => 2.0,
        'hieu_qua'  => 1.0,
    ];

    /**
     * Ngưỡng tên.
     *
     * Tên dưới ngưỡng này:
     *     không gọi NLP.
     *
     * Tên từ ngưỡng này trở lên:
     *     mới kiểm tra NLP sâu.
     */
    private const NAME_THRESHOLD = 35.0;

    /**
     * Cache section theo ID.
     */
    private array $sectionsCache = [];

    /**
     * Cache thông tin sáng kiến theo ID.
     */
    private array $sangKienCache = [];

    /**
     * Cache kết quả so tên theo cặp ID.
     */
    private array $nameSimilarityCache = [];

    /**
     * Cache kết quả NLP sâu theo cặp ID.
     *
     * Vì A-B và B-A là cùng một cặp,
     * chỉ NLP một lần.
     */
    private array $comparisonCache = [];


    /**
     * Lấy thông tin sáng kiến và cache.
     */
    private function getSangKienCached(int $id): array
    {
        if (isset($this->sangKienCache[$id])) {
            return $this->sangKienCache[$id];
        }

        $sk = DB::one(
            "SELECT 
                sk.id,
                sk.ma,
                sk.ten,
                sk.nam_id,
                sk.linh_vuc_id,
                n.nam           AS nam,
                lv.ten          AS ten_linh_vuc
            FROM qlsk_sang_kien sk
            LEFT JOIN qlsk_nam n        ON n.id = sk.nam_id
            LEFT JOIN qlsk_linh_vuc lv  ON lv.id = sk.linh_vuc_id
            WHERE sk.id = ?",
            [$id]
        );

        if (!$sk) {
            throw new RuntimeException(
                'Sáng kiến không tồn tại: ' . $id
            );
        }

        $this->sangKienCache[$id] = $sk;

        return $sk;
    }


    /**
     * Lấy section và cache.
     */
    private function getSectionsCached(int $id): array
    {
        if (isset($this->sectionsCache[$id])) {
            return $this->sectionsCache[$id];
        }

        $sections = get_sang_kien_sections($id);

        $this->sectionsCache[$id] = $sections;

        return $sections;
    }


    /**
     * Chuẩn hóa tên để so sánh nhanh.
     *
     * - bỏ khoảng trắng thừa
     * - chuyển thường
     * - bỏ dấu tiếng Việt
     * - bỏ ký tự đặc biệt
     */
    private function normalizeName(string $text): string
    {
        $text = trim($text);

        if ($text === '') {
            return '';
        }

        /*
         * Dùng hàm đã có trong sections.php
         */
        $text = remove_vietnamese_accents($text);

        $text = mb_strtolower($text, 'UTF-8');

        /*
         * Một số tên có ngoặc, dấu :, -, /...
         */
        $text = preg_replace(
            '/[^\p{L}\p{N}\s]+/u',
            ' ',
            $text
        );

        /*
         * Chuẩn hóa khoảng trắng.
         */
        $text = preg_replace(
            '/\s+/u',
            ' ',
            $text
        );

        return trim($text);
    }


    /**
     * Tách từ tên.
     *
     * Loại bỏ một số từ quá phổ biến,
     * tránh làm tăng điểm giả.
     */
    private function getNameTokens(string $text): array
    {
        $text = $this->normalizeName($text);

        if ($text === '') {
            return [];
        }

        $stopWords = [
            'va',
            'cua',
            'cho',
            'cac',
            'mot',
            'nhung',
            'viec',
            'trong',
            'tai',
            'tu',
            'den',
            'voi',
            'theo',
            'nham',
            'de',
            'thuc',
            'hien',
            'ap',
            'dung',
            'giai',
            'phap',
        ];

        $tokens = preg_split(
            '/\s+/u',
            $text,
            -1,
            PREG_SPLIT_NO_EMPTY
        );

        if (!is_array($tokens)) {
            return [];
        }

        $tokens = array_filter(
            $tokens,
            function ($token) use ($stopWords) {

                /*
                 * Từ 1 ký tự thường không hữu ích.
                 */
                if (mb_strlen($token, 'UTF-8') <= 1) {
                    return false;
                }

                return !in_array(
                    $token,
                    $stopWords,
                    true
                );
            }
        );

        return array_values(
            array_unique($tokens)
        );
    }


    /**
     * So sánh 2 tên sáng kiến.
     *
     * Kết hợp:
     *
     * 1. Jaccard token
     * 2. Tỷ lệ token chung
     * 3. Chuỗi chứa nhau
     *
     * Không dùng NLP ở bước này.
     */
    public function compareNames(
        string $nameA,
        string $nameB
    ): float {

        $tokensA = $this->getNameTokens($nameA);
        $tokensB = $this->getNameTokens($nameB);

        if (!$tokensA || !$tokensB) {
            return 0.0;
        }

        $setA = array_flip($tokensA);
        $setB = array_flip($tokensB);

        $intersection = count(
            array_intersect_key($setA, $setB)
        );

        $union = count(
            array_unique(
                array_merge(
                    $tokensA,
                    $tokensB
                )
            )
        );

        $jaccard = $union > 0
            ? ($intersection / $union)
            : 0.0;

        /*
         * Tỷ lệ token của tên ngắn hơn
         * xuất hiện trong tên dài hơn.
         */
        $minCount = min(
            count($tokensA),
            count($tokensB)
        );

        $tokenCoverage = $minCount > 0
            ? ($intersection / $minCount)
            : 0.0;

        /*
         * Kiểm tra chuỗi tên sau normalize.
         */
        $normA = $this->normalizeName($nameA);
        $normB = $this->normalizeName($nameB);

        $contains = (
            $normA !== '' &&
            $normB !== '' &&
            (
                str_contains($normA, $normB) ||
                str_contains($normB, $normA)
            )
        );

        /*
         * Công thức:
         *
         * Jaccard       50%
         * Token coverage 40%
         * Contains       10%
         */
        $score =
            ($jaccard * 100 * 0.50) +
            ($tokenCoverage * 100 * 0.40) +
            ($contains ? 10.0 : 0.0);

        return round(
            min(100.0, $score),
            2
        );
    }


    /**
     * So sánh tên theo ID.
     */
    public function compareNameById(
        int $idA,
        int $idB
    ): array {

        $minId = min($idA, $idB);
        $maxId = max($idA, $idB);

        $cacheKey = $minId . ':' . $maxId;

        if (isset($this->nameSimilarityCache[$cacheKey])) {
            return $this->nameSimilarityCache[$cacheKey];
        }

        $skA = $this->getSangKienCached($idA);
        $skB = $this->getSangKienCached($idB);

        $score = $this->compareNames(
            (string)($skA['ten'] ?? ''),
            (string)($skB['ten'] ?? '')
        );

        $result = [
            'score' => $score,
            'skip' => $score < self::NAME_THRESHOLD,
            'reason' => $score < self::NAME_THRESHOLD
                ? 'Tên sáng kiến khác biệt'
                : 'Tên sáng kiến có khả năng tương đồng',
        ];

        $this->nameSimilarityCache[$cacheKey] = $result;

        return $result;
    }


    /**
     * Lấy tất cả sáng kiến khác trong DB.
     *
     * QUAN TRỌNG:
     *
     * Không lọc nam_id.
     * Không lọc năm.
     */
    public function getAllCandidates(
        int $id
    ): array {

        return DB::all(
            "SELECT
                id,
                ma,
                ten,
                linh_vuc_id,
                nam_id
             FROM qlsk_sang_kien
             WHERE id <> ?
             ORDER BY id ASC",
            [$id]
        );
    }


    /**
     * So sánh 2 sáng kiến bằng NLP sâu.
     *
     * Hàm này CHỈ nên được gọi sau khi
     * compareNameById() xác định tên có khả năng trùng.
     */
    public function compare(
        int $idA,
        int $idB
    ): array {

        /*
         * ==========================
         * 1. LẤY THÔNG TIN
         * ==========================
         */

        $skA = $this->getSangKienCached($idA);
        $skB = $this->getSangKienCached($idB);


        /*
         * ==========================
         * 2. SO TÊN TRƯỚC
         * ==========================
         *
         * Đây là tầng lọc nhanh.
         *
         * Nếu tên khác biệt:
         *     KHÔNG gọi NLP.
         */

        $nameResult = $this->compareNameById(
            $idA,
            $idB
        );

        if ($nameResult['skip']) {

            return [
                'a' => $skA,
                'b' => $skB,

                'overall' => 0.0,

                'classification' => $this->classify(0),

                'skipped' => true,

                'skip_reason' => $nameResult['reason'],

                'name_score' => $nameResult['score'],

                'sections' => [],

                'sections_a' => [],
                'sections_b' => [],
            ];
        }


        /*
         * ==========================
         * 3. CACHE NLP DEEP
         * ==========================
         *
         * A-B và B-A chỉ NLP một lần.
         */

        $minId = min($idA, $idB);
        $maxId = max($idA, $idB);

        $cacheKey = $minId . ':' . $maxId;

        if (isset($this->comparisonCache[$cacheKey])) {
            $cached = $this->comparisonCache[$cacheKey];

            // Trùng hướng
            if ($cached['a']['id'] === $idA) {
                return $cached;
            }

            // Đảo hướng → phải swap cả sections lẫn pairs
            $result = $cached;

            $result['a'] = $cached['b'];
            $result['b'] = $cached['a'];

            $result['sections_a'] = $cached['sections_b'];
            $result['sections_b'] = $cached['sections_a'];

            // ✅ Swap từng pair trong sections
            $result['sections'] = [];
            foreach ($cached['sections'] as $key => $section) {
                $pairs = $section['pairs'] ?? [];
                $swapped = array_map(static function ($p) {
                    return [
                        'a'     => $p['b'] ?? '',
                        'b'     => $p['a'] ?? '',
                        'score' => $p['score'] ?? 0,
                    ];
                }, $pairs);

                $result['sections'][$key] = [
                    'score' => $section['score'] ?? 0,
                    'pairs' => $swapped,
                ];
            }

            return $result;
        }


        /*
         * ==========================
         * 4. LẤY SECTION
         * ==========================
         */

        $secA = $this->getSectionsCached($idA);
        $secB = $this->getSectionsCached($idB);
    

        /*
         * ==========================
         * 5. NLP DEEP
         * ==========================
         */

        try {

            $resp = nlp_post(
                '/compare-sections',
                [
                    'sections_a' => $secA,
                    'sections_b' => $secB,
                ]
            );

        } catch (Throwable $e) {

            error_log(
                "[compare-sections] {$idA}-{$idB}: " .
                $e->getMessage()
            );

            throw $e;
        }


        /*
         * ==========================
         * 6. TÍNH ĐIỂM
         * ==========================
         */

        $sum = 0.0;
        $wsum = 0.0;

        foreach ($resp as $key => $value) {

            /*
             * Chỉ tính các section có
             * trọng số đã định nghĩa.
             */
            if (!isset(self::WEIGHTS[$key])) {
                continue;
            }

            $weight = self::WEIGHTS[$key];

            $score = (float)(
                $value['score'] ?? 0
            );

            $sum += $score * $weight;
            $wsum += $weight;
        }

        $overall = $wsum > 0
            ? round($sum / $wsum, 2)
            : 0.0;


        /*
         * ==========================
         * 7. KẾT QUẢ
         * ==========================
         */

        $result = [
            'a' => $skA,

            'b' => $skB,

            'overall' => $overall,

            'classification' =>
                $this->classify($overall),

            'skipped' => false,

            'skip_reason' => null,

            'name_score' =>
                $nameResult['score'],

            'sections' => $resp,

            'sections_a' => $secA,

            'sections_b' => $secB,
        ];


        /*
         * Cache kết quả NLP.
         */
        $this->comparisonCache[$cacheKey] = $result;

        return $result;
    }


    /**
     * Kiểm tra 1 sáng kiến với toàn bộ DB.
     *
     * Không lọc theo năm.
     *
     * Luồng:
     *
     *     tên
     *       ↓
     *     tên tương đồng?
     *       ↓ có
     *     NLP sâu
     */
    public function checkAll(
        int $id
    ): array {

        $selected = $this->getSangKienCached($id);

        $candidates = $this->getAllCandidates($id);

        $results = [];

        foreach ($candidates as $candidate) {

            $otherId = (int)$candidate['id'];

            /*
             * ==========================
             * TẦNG 1: SO TÊN
             * ==========================
             */

            $nameResult = $this->compareNameById(
                $id,
                $otherId
            );

            /*
             * Tên khác → bỏ qua hoàn toàn.
             *
             * KHÔNG gọi NLP.
             */
            if ($nameResult['skip']) {
                continue;
            }


            /*
             * ==========================
             * TẦNG 2: NLP
             * ==========================
             */

            try {

                $cmp = $this->compare(
                    $id,
                    $otherId
                );

            } catch (Throwable $e) {

                error_log(
                    "[checkAll] {$id}-{$otherId}: " .
                    $e->getMessage()
                );

                continue;
            }


            /*
             * Chỉ thêm những trường hợp
             * thực sự đã được NLP kiểm tra.
             */
            $results[] = $cmp;
        }


        /*
         * Sắp xếp giảm dần.
         */
        usort(
            $results,
            static function (
                array $a,
                array $b
            ): int {

                return
                    $b['overall']
                    <=>
                    $a['overall'];
            }
        );


        return [
            'sang_kien' => $selected,

            'name_threshold' =>
                self::NAME_THRESHOLD,

            'candidate_count' =>
                count($candidates),

            'nlp_candidate_count' =>
                count($results),

            'ket_qua' =>
                $results,
        ];
    }


    /**
     * Phân loại điểm.
     */
    public function classify(
        float $score
    ): array {

        if ($score >= 85) {

            return [
                'level' => 'RAT_CAO',
                'label' => 'Trùng / gần như trùng',
                'color' => '#dc2626',
                'emoji' => '🔴',
                'bg' => '#fee2e2',
            ];
        }

        if ($score >= 70) {

            return [
                'level' => 'CAO',
                'label' => 'Khả năng trùng cao',
                'color' => '#f97316',
                'emoji' => '🟠',
                'bg' => '#ffedd5',
            ];
        }

        if ($score >= 50) {

            return [
                'level' => 'TRUNG_BINH',
                'label' => 'Tương đồng một phần',
                'color' => '#eab308',
                'emoji' => '🟡',
                'bg' => '#fef9c3',
            ];
        }

        return [
            'level' => 'THAP',
            'label' => 'Khác biệt',
            'color' => '#16a34a',
            'emoji' => '🟢',
            'bg' => '#dcfce7',
        ];
    }
}