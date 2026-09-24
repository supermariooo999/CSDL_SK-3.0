<?php
declare(strict_types=1);

require_once __DIR__ . '/../includes/helpers.php';
require_once __DIR__ . '/../includes/sections.php';

class SangKienSimilarity
{
    /** Trọng số từng section khi tính điểm NLP tổng hợp. */
    private const WEIGHTS = [
        'ten'      => 1.5,
        'linh_vuc' => 0.5,
        'boi_canh' => 1.0,
        'noi_dung' => 2.0,
        'hieu_qua' => 1.0,
    ];

    /** Tên < ngưỡng này → bỏ qua, không gọi NLP. */
    private const NAME_THRESHOLD = 45.0;

    // ---------- Cache ----------

    /** @var array<int, array> */
    private array $sangKienCache = [];

    /** @var array<int, array> */
    private array $sectionsCache = [];

    /** @var array<string, array> Key: "minId:maxId" */
    private array $nameSimilarityCache = [];

    /** @var array<string, array> Key: "minId:maxId" */
    private array $comparisonCache = [];

    // =====================================================
    // API CÔNG KHAI
    // =====================================================

    /**
     * Kiểm tra 1 sáng kiến với toàn bộ sáng kiến khác trong DB.
     */
    public function checkAll(int $id): array
    {
        $selected   = $this->getSangKienCached($id);
        $candidates = $this->getAllCandidates($id);

        $results = [];

        foreach ($candidates as $candidate) {
            $otherId = (int)$candidate['id'];

            // Tầng 1: lọc tên
            $nameResult = $this->compareNameById($id, $otherId);
            if ($nameResult['skip']) {
                continue;
            }

            // Tầng 2: NLP sâu
            try {
                $results[] = $this->compare($id, $otherId);
            } catch (Throwable $e) {
                error_log("[checkAll] {$id}-{$otherId}: " . $e->getMessage());
            }
        }

        // Sắp xếp điểm cao → thấp
        usort(
            $results,
            static fn(array $a, array $b): int => $b['overall'] <=> $a['overall']
        );

        return [
            'sang_kien'           => $selected,
            'name_threshold'      => self::NAME_THRESHOLD,
            'candidate_count'     => count($candidates),
            'nlp_candidate_count' => count($results),
            'ket_qua'             => $results,
        ];
    }

    /**
     * So sánh 2 sáng kiến: lọc tên trước, nếu qua thì gọi NLP.
     */
    public function compare(int $idA, int $idB): array
    {
        $skA = $this->getSangKienCached($idA);
        $skB = $this->getSangKienCached($idB);

        // Lọc tên
        $nameResult = $this->compareNameById($idA, $idB);

        if ($nameResult['skip']) {
            return $this->buildSkippedResult($skA, $skB, $nameResult);
        }

        // Cache theo cặp (min:max)
        $cacheKey = min($idA, $idB) . ':' . max($idA, $idB);

        if (isset($this->comparisonCache[$cacheKey])) {
            $cached = $this->comparisonCache[$cacheKey];

            // Trùng hướng
            if ((int)$cached['a']['id'] === $idA) {
                return $cached;
            }

            // Đảo hướng → swap
            return $this->swapCachedResult($cached);
        }

        // Gọi NLP
        $secA = $this->getSectionsCached($idA);
        $secB = $this->getSectionsCached($idB);

        $resp = nlp_post('/compare-sections', [
            'sections_a' => $secA,
            'sections_b' => $secB,
        ]);

        $overall = $this->computeOverall($resp);

        $result = [
            'a'              => $skA,
            'b'              => $skB,
            'overall'        => $overall,
            'classification' => $this->classify($overall),
            'skipped'        => false,
            'skip_reason'    => null,
            'name_score'     => $nameResult['score'],
            'sections'       => $resp,
            'sections_a'     => $secA,
            'sections_b'     => $secB,
        ];

        $this->comparisonCache[$cacheKey] = $result;

        return $result;
    }

    // =====================================================
    // SO TÊN
    // =====================================================

    public function compareNameById(int $idA, int $idB): array
    {
        $cacheKey = min($idA, $idB) . ':' . max($idA, $idB);

        if (isset($this->nameSimilarityCache[$cacheKey])) {
            return $this->nameSimilarityCache[$cacheKey];
        }

        $skA = $this->getSangKienCached($idA);
        $skB = $this->getSangKienCached($idB);

        $score = $this->compareNames(
            (string)($skA['ten'] ?? ''),
            (string)($skB['ten'] ?? '')
        );

        $skip = $score < self::NAME_THRESHOLD;

        $result = [
            'score'  => $score,
            'skip'   => $skip,
            'reason' => $skip
                ? 'Tên sáng kiến khác biệt'
                : 'Tên sáng kiến có khả năng tương đồng',
        ];

        $this->nameSimilarityCache[$cacheKey] = $result;

        return $result;
    }

    /**
     * So 2 chuỗi tên: Jaccard 50% + Token coverage 40% + Contains 10%.
     */
    public function compareNames(string $nameA, string $nameB): float
    {
        $tokensA = $this->getNameTokens($nameA);
        $tokensB = $this->getNameTokens($nameB);

        if (!$tokensA || !$tokensB) return 0.0;

        // ✅ Expand viết tắt + đồng nghĩa
        $tokensA = $this->expandTokens($tokensA);
        $tokensB = $this->expandTokens($tokensB);

        // ✅ So khớp với cả 2 tập: raw + expanded
        $setA = array_flip($tokensA);
        $setB = array_flip($tokensB);

        $intersection = count(array_intersect_key($setA, $setB));

        $union = count(array_unique(array_merge($tokensA, $tokensB)));
        $jaccard = $union > 0 ? ($intersection / $union) : 0.0;

        $minCount = min(count($tokensA), count($tokensB));
        $coverage = $minCount > 0 ? ($intersection / $minCount) : 0.0;

        // Contains (giữ nguyên, nhưng normalize sau expand)
        $normA = $this->normalizeName($nameA);
        $normB = $this->normalizeName($nameB);

        $contains = (
            $normA !== '' &&
            $normB !== '' &&
            (str_contains($normA, $normB) || str_contains($normB, $normA))
        );

        $score =
            ($jaccard  * 100 * 0.50) +
            ($coverage * 100 * 0.40) +
            ($contains ? 10.0 : 0.0);

        return round(min(100.0, $score), 2);
    }

    // =====================================================
    // HELPERS NỘI BỘ
    // =====================================================

    private function normalizeName(string $text): string
    {
        $text = trim($text);
        if ($text === '') return '';

        $text = remove_vietnamese_accents($text);
        $text = mb_strtolower($text, 'UTF-8');
        $text = preg_replace('/[^\p{L}\p{N}\s]+/u', ' ', $text);
        $text = preg_replace('/\s+/u', ' ', $text);

        return trim($text);
    }

    private function getNameTokens(string $text): array
    {
        $text = $this->normalizeName($text);
        if ($text === '') return [];

        static $stopWords = [
            'va', 'cua', 'cho', 'cac', 'mot', 'nhung', 'viec',
            'trong', 'tai', 'tu', 'den', 'voi', 'theo', 'nham',
            'de', 'thuc', 'hien', 'ap', 'dung', 'giai', 'phap',
        ];

        $tokens = preg_split('/\s+/u', $text, -1, PREG_SPLIT_NO_EMPTY);
        if (!is_array($tokens)) return [];

        $tokens = array_filter(
            $tokens,
            static fn(string $t): bool =>
                mb_strlen($t, 'UTF-8') > 1
                && !in_array($t, $stopWords, true)
        );

        return array_values(array_unique($tokens));
    }

    /**
     * Mở rộng token:
     *
     * 1. Viết tắt → dạng đầy đủ (CNTT → "cong nghe thong tin")
     * 2. Đồng nghĩa → giữ nguyên token gốc + thêm token đồng nghĩa
     *
     * Trả về mảng token đã mở rộng, đã loại trùng.
     */
    private function expandTokens(array $tokens): array
    {
        $abbrMap = self::abbreviationMap();
        $synMap  = self::synonymMap();

        $expanded = [];

        foreach ($tokens as $token) {

            // ---------- 1. Expand viết tắt ----------
            if (isset($abbrMap[$token])) {
                // Viết tắt → thay bằng dạng đầy đủ (tách thành nhiều token)
                $full = explode(' ', $abbrMap[$token]);

                foreach ($full as $w) {
                    if (mb_strlen($w, 'UTF-8') > 1) {
                        $expanded[] = $w;
                    }
                }

                // Vẫn giữ token gốc để nếu 2 tên cùng viết tắt thì khớp nhau
                $expanded[] = $token;

                continue;
            }

            // ---------- 2. Giữ token gốc ----------
            $expanded[] = $token;

            // ---------- 3. Thêm đồng nghĩa ----------
            if (isset($synMap[$token])) {
                foreach ($synMap[$token] as $syn) {
                    $expanded[] = $syn;
                }
            }
        }

        return array_values(array_unique($expanded));
    }

    /**
     * Từ điển viết tắt tiếng Việt thường gặp trong sáng kiến ngành thuế.
     * Key: viết tắt (đã normalize). Value: dạng đầy đủ.
     */
    private static function abbreviationMap(): array
    {
        static $map = [
            // Ngành thuế
            'cntt'      => 'cong nghe thong tin',
            'cqt'       => 'co quan thue',
            'nnt'       => 'nguoi nop thue',
            'dn'        => 'doanh nghiep',
            'hdtt'      => 'hoa don thuong mai',
            'hddt'      => 'hoa don dien tu',
            'tndn'      => 'thu nhap doanh nghiep',
            'tncn'      => 'thu nhap ca nhan',
            'gtgt'      => 'gia tri gia tang',
            'ttdb'      => 'tieu thu dac biet',
            'xntk'      => 'xuat nhap khau',
            'bhxh'      => 'bao hiem xa hoi',
            'bhyt'      => 'bao hiem y te',
            'kbnn'      => 'kho bac nha nuoc',
            'nsnn'      => 'ngan sach nha nuoc',
            'ubnd'      => 'uy ban nhan dan',
            'hđnd'      => 'hoi dong nhan dan',
            'tw'        => 'trung uong',
            'cp'        => 'chinh phu',
            'tt'        => 'thong tu',
            'nđ'        => 'nghi dinh',
            'nq'        => 'nghi quyet',
            'qh'        => 'quoc hoi',
            'ct'        => 'chi thi',
            'bctc'      => 'bao cao tai chinh',
            'hdkd'      => 'hoat dong kinh doanh',
            'sxkd'      => 'san xuat kinh doanh',
            'ccvc'      => 'cong chuc vien chuc',
            'cbcnv'     => 'can bo cong nhan vien',
            'gv'        => 'giao vien',
            'nv'        => 'nhan vien',
            'cv'        => 'cong viec',
            'cq'        => 'co quan',
            'cty'       => 'cong ty',

            // Tổ chức
            'vn'        => 'viet nam',
            'tcs'        => 'thue co so',
            'hcm'       => 'ho chi minh',
            'hn'        => 'ha noi',

            // Kỹ thuật
            'ai'        => 'tri tue nhan tao',
            'ml'        => 'hoc may',
            'api'       => 'giao dien lap trinh',
            'crm'       => 'quan ly khach hang',
            'erp'       => 'quan tri doanh nghiep',
            'kpi'       => 'chi so danh gia',
            'okr'       => 'muc tieu ket qua',
        ];

        return $map;
    }

    /**
     * Từ điển đồng nghĩa tiếng Việt.
     * Key: từ gốc (đã normalize).
     * Value: mảng các từ đồng nghĩa (đã normalize).
     *
     * Lưu ý: 2 chiều — khi map A, cũng nên map B đối xứng.
     */
    private static function synonymMap(): array
    {
        static $map = [
            // Nâng cao / cải thiện
            'nang'      => ['cai', 'tang', 'cai_thien', 'nang_cao'],
            'cao'       => ['thien', 'tot', 'hieu_qua'],
            'cai'       => ['nang', 'tang'],
            'thien'     => ['cao', 'tot'],
            'tang'      => ['nang', 'cai'],
            'tot'       => ['cao', 'thien', 'hieu_qua'],

            // Giải pháp / biện pháp
            'giai'      => ['bien', 'cach'],
            'phap'      => ['phap'],
            'bien'      => ['giai', 'cach'],
            'cach'      => ['giai', 'bien'],

            // Xây dựng / thiết lập / tạo
            'xay'       => ['thiet', 'tao', 'lap'],
            'dung'      => ['lap', 'dat'],
            'thiet'     => ['xay'],
            'lap'       => ['xay', 'dung', 'thiet'],

            // Quản lý / điều hành
            'quan'      => ['dieu', 'quan_ly'],
            'ly'        => ['hanh', 'quan'],
            'dieu'      => ['quan'],
            'hanh'      => ['ly', 'dieu'],

            // Thực thi / thực hiện / triển khai
            'thuc'      => ['trien', 'lam', 'thuc_hien'],
            'thi'       => ['hien', 'hanh'],
            'trien'     => ['thuc', 'khai'],
            'khai'      => ['trien'],
            'hien'      => ['thi', 'thuc'],

            // Kiểm tra / thanh tra / giám sát
            'kiem'      => ['thanh', 'giam', 'tra'],
            'tra'       => ['kiem', 'thanh', 'soat'],
            'thanh'     => ['kiem', 'tra'],
            'giam'      => ['sat', 'kiem'],
            'sat'       => ['giam'],

            // Công chức / cán bộ / nhân viên
            'cong'      => ['can', 'nhan'],
            'chuc'      => ['bo', 'vien'],
            'can'       => ['cong'],
            'bo'        => ['chuc'],
            'nhan'      => ['cong', 'vien'],
            'vien'      => ['chuc', 'nhan'],

            // Trách nhiệm / nghĩa vụ
            'trach'     => ['nghia', 'nhiem'],
            'nhiem'     => ['vu', 'trach'],
            'nghia'     => ['trach', 'vu'],
            'vu'        => ['nhiem', 'nghia'],

            // Ý thức / tinh thần / thái độ
            'y'         => ['thuc', 'tinh'],
            'tinh'      => ['than', 'y'],
            'than'      => ['tinh'],
            'thai'      => ['do', 'y'],
            'do'        => ['thai'],

            // Hiệu quả / chất lượng / năng suất
            'hieu'      => ['qua', 'nang'],
            'qua'       => ['hieu'],
            'chat'      => ['luong', 'hieu'],
            'luong'     => ['chat', 'hieu'],
            'nang'      => ['suat', 'hieu'],

            // Phát triển / mở rộng / tăng trưởng
            'phat'      => ['trien', 'mo'],
            'trien'     => ['phat', 'mo'],
            'mo'        => ['rong', 'phat'],
            'rong'      => ['mo'],

            // Ứng dụng / áp dụng / sử dụng
            'ung'       => ['dung', 'ap'],
            'dung'      => ['ung', 'ap', 'su'],
            'ap'        => ['dung', 'ung'],
            'su'        => ['dung'],

            // Hướng dẫn / chỉ đạo / điều hành
            'huong'     => ['dan', 'chi'],
            'dan'       => ['huong', 'chi'],
            'chi'       => ['dao', 'dan'],
            'dao'       => ['chi', 'huong'],

            // Kế hoạch / phương án / đề án
            'ke'        => ['hoach', 'phuong'],
            'hoach'     => ['ke', 'phuong'],
            'phuong'    => ['an', 'ke'],
            'an'        => ['phuong', 'ke'],

            // Đào tạo / bồi dưỡng / tập huấn
            'dao'       => ['tao', 'boi'],
            'tao'       => ['dao', 'boi'],
            'boi'       => ['duong', 'dao'],
            'duong'     => ['boi'],
            'tap'       => ['huan', 'dao'],
            'huan'      => ['tap'],

            // Phòng chống / ngăn chặn / đấu tranh
            'phong'     => ['chong', 'ngan'],
            'chong'     => ['phong', 'ngan'],
            'ngan'      => ['chong', 'phong'],
        ];

        return $map;
    }

    private function computeOverall(array $resp): float
    {
        $sum  = 0.0;
        $wsum = 0.0;

        foreach ($resp as $key => $value) {
            if (!isset(self::WEIGHTS[$key])) continue;

            $weight = self::WEIGHTS[$key];
            $score  = (float)($value['score'] ?? 0);

            $sum  += $score * $weight;
            $wsum += $weight;
        }

        return $wsum > 0 ? round($sum / $wsum, 2) : 0.0;
    }

    private function swapCachedResult(array $cached): array
    {
        $result = $cached;

        $result['a'] = $cached['b'];
        $result['b'] = $cached['a'];

        $result['sections_a'] = $cached['sections_b'];
        $result['sections_b'] = $cached['sections_a'];

        $result['sections'] = [];

        foreach ($cached['sections'] as $key => $section) {
            $pairs = $section['pairs'] ?? [];

            $swapped = array_map(
                static fn(array $p): array => [
                    'a'     => $p['b'] ?? '',
                    'b'     => $p['a'] ?? '',
                    'score' => $p['score'] ?? 0,
                ],
                $pairs
            );

            $result['sections'][$key] = [
                'score' => $section['score'] ?? 0,
                'pairs' => $swapped,
            ];
        }

        return $result;
    }

    private function buildSkippedResult(array $skA, array $skB, array $nameResult): array
    {
        return [
            'a'              => $skA,
            'b'              => $skB,
            'overall'        => 0.0,
            'classification' => $this->classify(0),
            'skipped'        => true,
            'skip_reason'    => $nameResult['reason'],
            'name_score'     => $nameResult['score'],
            'sections'       => [],
            'sections_a'     => [],
            'sections_b'     => [],
        ];
    }

    // =====================================================
    // TRUY VẤN DB (CACHE)
    // =====================================================

    public function getAllCandidates(int $id): array
    {
        return DB::all(
            "SELECT id, ma, ten, linh_vuc_id, nam_id
             FROM qlsk_sang_kien
             WHERE id <> ?
             ORDER BY id ASC",
            [$id]
        );
    }

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
                n.nam      AS nam,
                lv.ten     AS ten_linh_vuc
             FROM qlsk_sang_kien sk
             LEFT JOIN qlsk_nam       n  ON n.id  = sk.nam_id
             LEFT JOIN qlsk_linh_vuc  lv ON lv.id = sk.linh_vuc_id
             WHERE sk.id = ?",
            [$id]
        );

        if (!$sk) {
            throw new RuntimeException('Sáng kiến không tồn tại: ' . $id);
        }

        $this->sangKienCache[$id] = $sk;

        return $sk;
    }

    private function getSectionsCached(int $id): array
    {
        if (isset($this->sectionsCache[$id])) {
            return $this->sectionsCache[$id];
        }

        $sections = get_sang_kien_sections($id);

        $this->sectionsCache[$id] = $sections;

        return $sections;
    }

    // =====================================================
    // PHÂN LOẠI
    // =====================================================

    public function classify(float $score): array
    {
        if ($score >= 85) {
            return ['level' => 'RAT_CAO',    'label' => 'Trùng / gần như trùng', 'color' => '#dc2626', 'emoji' => '🔴', 'bg' => '#fee2e2'];
        }
        if ($score >= 70) {
            return ['level' => 'CAO',        'label' => 'Khả năng trùng cao',   'color' => '#f97316', 'emoji' => '🟠', 'bg' => '#ffedd5'];
        }
        if ($score >= 50) {
            return ['level' => 'TRUNG_BINH', 'label' => 'Tương đồng một phần',  'color' => '#eab308', 'emoji' => '🟡', 'bg' => '#fef9c3'];
        }
        return     ['level' => 'THAP',       'label' => 'Khác biệt',            'color' => '#16a34a', 'emoji' => '🟢', 'bg' => '#dcfce7'];
    }
}