<?php
declare(strict_types=1);

require_once __DIR__ . '/../includes/helpers.php';

$action = $_GET['action'] ?? '';

if ($action !== 'fields') {
    json_error('Action không hợp lệ', 400);
}

try {
    $data = DB::all("
        SELECT
            id,
            ma,
            ten
        FROM qlsk_linh_vuc
        ORDER BY ten ASC
    ");

    json_ok($data);

} catch (Throwable $e) {

    json_error(
        $e->getMessage(),
        500
    );
}