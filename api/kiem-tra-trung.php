<?php
declare(strict_types=1);

require_once __DIR__ . '/../includes/helpers.php';
require_once __DIR__ . '/../includes/sections.php';
require_once __DIR__ . '/../classes/SangKienSimilarity.php';
require_once __DIR__ . '/../classes/KiemTraTrungService.php';

header('Content-Type: application/json; charset=utf-8');

try {

    if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
        throw new RuntimeException('Phương thức không hợp lệ.');
    }

    $raw = file_get_contents('php://input');
    $body = json_decode($raw, true);

    if (!is_array($body)) {
        throw new RuntimeException('Dữ liệu JSON không hợp lệ.');
    }

    /*
     * Có thể nhận:
     *
     * {
     *   "sang_kien_ids": [27]
     * }
     *
     * hoặc:
     *
     * {
     *   "sang_kien_ids": [27, 24, 23]
     * }
     */

    $ids = $body['sang_kien_ids'] ?? [];

    if (!is_array($ids)) {
        throw new RuntimeException('sang_kien_ids phải là mảng.');
    }

    // Ép kiểu + loại bỏ ID trùng
    $ids = array_values(array_unique(
        array_filter(
            array_map('intval', $ids),
            fn($id) => $id > 0
        )
    ));

    if (count($ids) < 1) {
        throw new RuntimeException(
            'Vui lòng chọn ít nhất 1 sáng kiến.'
        );
    }

    $service = new KiemTraTrungService();

    $results = [];

    foreach ($ids as $id) {

        try {

            /*
             * 1 sáng kiến được chọn
             * sẽ kiểm tra với TOÀN BỘ sáng kiến khác
             * trong cùng năm.
             */
            $result = $service->checkOne(
                $id,
                null,
                0.0
            );

            $results[] = $result;

        } catch (Throwable $e) {

            error_log(
                "[kiem-tra-trung] id={$id} " .
                $e->getMessage()
            );

            $results[] = [
                'sang_kien' => [
                    'id' => $id
                ],
                'ket_qua' => [],
                'error' => $e->getMessage()
            ];
        }
    }

    echo json_encode([
        'success' => true,
        'data' => [
            'selected_count' => count($ids),
            'selected_ids' => $ids,
            'results' => $results
        ]
    ], JSON_UNESCAPED_UNICODE);

} catch (Throwable $e) {

    http_response_code(400);

    echo json_encode([
        'success' => false,
        'error' => $e->getMessage()
    ], JSON_UNESCAPED_UNICODE);
}