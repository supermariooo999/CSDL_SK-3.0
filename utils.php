<?php

function normalizeDuplicateText(string $text): string
{
    $text = mb_strtolower($text, 'UTF-8');

    $text = html_entity_decode(
        $text,
        ENT_QUOTES | ENT_HTML5,
        'UTF-8'
    );

    $text = strip_tags($text);

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

function calculateTextSimilarity(
    string $text1,
    string $text2
): float {

    $text1 = normalizeDuplicateText($text1);
    $text2 = normalizeDuplicateText($text2);

    if ($text1 === '' || $text2 === '') {
        return 0;
    }

    $words1 = preg_split('/\s+/u', $text1);
    $words2 = preg_split('/\s+/u', $text2);

    $words1 = array_unique($words1);
    $words2 = array_unique($words2);

    $intersection = count(
        array_intersect($words1, $words2)
    );

    $union = count(
        array_unique(
            array_merge($words1, $words2)
        )
    );

    if ($union === 0) {
        return 0;
    }

    return round(
        ($intersection / $union) * 100,
        2
    );
}

function getInitiativeDocumentHashes(
    PDO $pdo,
    int $sangKienId
): array {
    $stmt = $pdo->prepare("
        SELECT hash_noi_dung
        FROM qlsk_file_noi_dung
        WHERE sang_kien_id = ?
          AND hash_noi_dung IS NOT NULL
          AND hash_noi_dung <> ''
        ORDER BY file_id ASC
    ");

    $stmt->execute([
        $sangKienId
    ]);

    return $stmt->fetchAll(
        PDO::FETCH_COLUMN
    );
}

function calculateInitiativeDuplicateSimilarity(
    array $a,
    array $b,
    PDO $pdo
): array {

    /*
     * =====================================================
     * 1. TÊN
     * =====================================================
     */

    $name = calculateTextSimilarity(
        (string)($a['ten'] ?? ''),
        (string)($b['ten'] ?? '')
    );


    /*
     * =====================================================
     * 2. TÀI LIỆU
     * =====================================================
     */

    $documentA =
        getInitiativeDocumentText(
            $pdo,
            (int)$a['id']
        );

    $documentB =
        getInitiativeDocumentText(
            $pdo,
            (int)$b['id']
        );

    $document = null;

    $documentMatches = [];


    /*
     * =====================================================
     * 3. SO SÁNH TÀI LIỆU
     * =====================================================
     */

    if (
        $documentA !== ''
        &&
        $documentB !== ''
    ) {

        $hashesA =
            getInitiativeDocumentHashes(
                $pdo,
                (int)$a['id']
            );

        $hashesB =
            getInitiativeDocumentHashes(
                $pdo,
                (int)$b['id']
            );

        $sameHash = false;

        if (
            $hashesA
            &&
            $hashesB
        ) {

            $sameHash = !empty(
                array_intersect(
                    $hashesA,
                    $hashesB
                )
            );
        }


        /*
         * Có file giống hoàn toàn.
         */
        if ($sameHash) {

            $document = 100.00;

            /*
             * Nếu hash giống thì không cần
             * tìm từng đoạn nữa.
             */
            $documentMatches = [];

        } else {

            /*
             * Điểm tổng thể của tài liệu.
             */
            $document =
                calculateTextSimilarity(
                    $documentA,
                    $documentB
                );

            /*
             * Tìm các đoạn giống nhau.
             */
            $documentMatches =
                findSimilarDocumentParts(
                    $documentA,
                    $documentB,
                    70
                );
        }
    }


    /*
     * =====================================================
     * 4. ĐIỂM TỔNG HỢP
     * =====================================================
     */

    if ($document !== null) {

        $score =
            ($name * 0.30)
            +
            ($document * 0.70);

    } else {

        $score = $name;
    }


    /*
     * =====================================================
     * 5. MỨC ĐỘ
     * =====================================================
     */

    if ($score >= 80) {

        $level = 'RAT_CAO';

    } elseif ($score >= 60) {

        $level = 'CAO';

    } elseif ($score >= 30) {

        $level = 'TRUNG_BINH';

    } else {

        $level = 'THAP';
    }


    return [

        'name' =>
            round($name, 2),

        'document' =>
            $document !== null
                ? round($document, 2)
                : null,

        'score' =>
            round($score, 2),

        'level' =>
            $level,

        'document_matches' =>
            $documentMatches
    ];
}

function getInitiativeDocumentText(
    PDO $pdo,
    int $sangKienId
): string {
    
    $stmt = $pdo->prepare("
        SELECT noi_dung
        FROM qlsk_file_noi_dung
        WHERE sang_kien_id = ?
          AND noi_dung IS NOT NULL
          AND noi_dung <> ''
        ORDER BY file_id ASC
    ");

    $stmt->execute([
        $sangKienId
    ]);

    $rows = $stmt->fetchAll(
        PDO::FETCH_COLUMN
    );

    if (!$rows) {
        return '';
    }

    return normalizeDocumentText(
        implode("\n", $rows)
    );
}

function deleteInitiativeFiles(
    PDO $pdo,
    int $initiativeId
): void {

    /*
     * Lấy đường dẫn file trước khi xóa record DB.
     *
     * Đổi "duong_dan" thành tên cột thực tế
     * của bảng qlsk_file_noi_dung nếu khác.
     */
    $stmt = $pdo->prepare("
        SELECT duong_dan
        FROM qlsk_file
        WHERE sang_kien_id = ?
    ");

    $stmt->execute([
        $initiativeId
    ]);

    $files = $stmt->fetchAll(
        PDO::FETCH_COLUMN
    );

    /*
     * Xóa file vật lý.
     */
    foreach ($files as $file) {

        if (
            $file !== null
            && $file !== ''
            && is_file($file)
        ) {

            @unlink($file);
        }
    }

    /*
     * Xóa record DB.
     */
    $stmt = $pdo->prepare("
        DELETE FROM qlsk_file
        WHERE sang_kien_id = ?
    ");

    $stmt->execute([
        $initiativeId
    ]);

    $stmt = $pdo->prepare("
        DELETE FROM qlsk_file_noi_dung
        WHERE sang_kien_id = ?
    ");

    $stmt->execute([
        $initiativeId
    ]);
}

/**
 * Chuẩn hóa một đoạn văn để so sánh.
 */
function normalizeDuplicateParagraph(
    string $text
): string {

    $text = mb_strtolower(
        $text,
        'UTF-8'
    );

    $text = html_entity_decode(
        $text,
        ENT_QUOTES | ENT_HTML5,
        'UTF-8'
    );

    $text = strip_tags($text);

    $text = preg_replace(
        '/\s+/u',
        ' ',
        $text
    );

    return trim($text);
}


/**
 * Chia tài liệu thành các đoạn.
 */
function splitDuplicateDocument(
    string $text
): array {

    $text = str_replace(
        ["\r\n", "\r"],
        "\n",
        $text
    );

    /*
     * Ưu tiên chia theo dòng trống.
     */
    $paragraphs = preg_split(
        '/\n\s*\n+/u',
        $text,
        -1,
        PREG_SPLIT_NO_EMPTY
    );

    $result = [];

    foreach ($paragraphs as $paragraph) {

        $paragraph = trim($paragraph);

        if ($paragraph === '') {
            continue;
        }

        /*
         * Nếu đoạn quá dài thì chia tiếp
         * theo câu.
         */
        if (
            mb_strlen(
                $paragraph,
                'UTF-8'
            ) > 1500
        ) {

            $sentences = preg_split(
                '/(?<=[.!?。！？])\s+/u',
                $paragraph,
                -1,
                PREG_SPLIT_NO_EMPTY
            );

            foreach ($sentences as $sentence) {

                $sentence = trim($sentence);

                if (
                    mb_strlen(
                        $sentence,
                        'UTF-8'
                    ) >= 30
                ) {

                    $result[] = $sentence;
                }
            }

        } else {

            if (
                mb_strlen(
                    $paragraph,
                    'UTF-8'
                ) >= 30
            ) {

                $result[] = $paragraph;
            }
        }
    }

    return $result;
}


/**
 * Tính similarity giữa hai đoạn văn
 * bằng Jaccard theo từ.
 */
function calculateParagraphSimilarity(
    string $a,
    string $b
): float {

    $a = normalizeDuplicateParagraph($a);
    $b = normalizeDuplicateParagraph($b);

    if ($a === '' || $b === '') {
        return 0;
    }

    $wordsA = preg_split(
        '/\s+/u',
        $a,
        -1,
        PREG_SPLIT_NO_EMPTY
    );

    $wordsB = preg_split(
        '/\s+/u',
        $b,
        -1,
        PREG_SPLIT_NO_EMPTY
    );

    /*
     * Bỏ dấu câu ở đầu/cuối từ.
     */
    $clean = function ($word) {

        return trim(
            $word,
            " \t\n\r\0\x0B.,;:!?()[]{}\"'“”‘’"
        );
    };

    $wordsA = array_map(
        $clean,
        $wordsA
    );

    $wordsB = array_map(
        $clean,
        $wordsB
    );

    $wordsA = array_filter(
        $wordsA,
        fn($word) =>
            mb_strlen(
                $word,
                'UTF-8'
            ) >= 2
    );

    $wordsB = array_filter(
        $wordsB,
        fn($word) =>
            mb_strlen(
                $word,
                'UTF-8'
            ) >= 2
    );

    $wordsA = array_values(
        array_unique($wordsA)
    );

    $wordsB = array_values(
        array_unique($wordsB)
    );

    if (!$wordsA || !$wordsB) {
        return 0;
    }

    $intersection = array_intersect(
        $wordsA,
        $wordsB
    );

    $union = array_unique(
        array_merge(
            $wordsA,
            $wordsB
        )
    );

    if (!$union) {
        return 0;
    }

    return round(
        count($intersection)
        /
        count($union)
        * 100,
        2
    );
}


/**
 * Tìm các đoạn tài liệu tương đồng.
 */
function findSimilarDocumentParts(
    string $documentA,
    string $documentB,
    float $minimumSimilarity = 70
): array {

    $paragraphsA =
        splitDuplicateDocument(
            $documentA
        );

    $paragraphsB =
        splitDuplicateDocument(
            $documentB
        );

    if (
        !$paragraphsA
        ||
        !$paragraphsB
    ) {
        return [];
    }

    $matches = [];

    /*
     * Mỗi đoạn A tìm đoạn B giống nhất.
     */
    foreach (
        $paragraphsA as $indexA => $textA
    ) {

        $bestSimilarity = 0;
        $bestIndex = null;

        foreach (
            $paragraphsB as $indexB => $textB
        ) {

            $similarity =
                calculateParagraphSimilarity(
                    $textA,
                    $textB
                );

            if (
                $similarity
                >
                $bestSimilarity
            ) {

                $bestSimilarity =
                    $similarity;

                $bestIndex =
                    $indexB;
            }
        }

        if (
            $bestIndex !== null
            &&
            $bestSimilarity >=
            $minimumSimilarity
        ) {

            $matches[] = [

                'index_a' =>
                    $indexA,

                'index_b' =>
                    $bestIndex,

                'text_a' =>
                    $textA,

                'text_b' =>
                    $paragraphsB[$bestIndex],

                'similarity' =>
                    round(
                        $bestSimilarity,
                        2
                    )
            ];
        }
    }

    /*
     * Sắp xếp đoạn có similarity cao nhất trước.
     */
    usort(
        $matches,
        function ($a, $b) {

            return
                $b['similarity']
                <=>
                $a['similarity'];
        }
    );

    /*
     * Giới hạn số đoạn để tránh
     * response quá lớn.
     */
    return array_slice(
        $matches,
        0,
        50
    );
}