<?php
declare(strict_types=1);

require_once __DIR__ . '/../includes/helpers.php';

$action = $_GET['action'] ?? '';

if ($action !== 'years') {
    json_error('Action không hợp lệ', 400);
}

try {
    $data = DB::all("
        SELECT
            id,
            nam
        FROM qlsk_nam
        ORDER BY nam DESC
    ");

    json_ok($data);

} catch (Throwable $e) {
    
    json_error(
        $e->getMessage(),
        500
    );
}