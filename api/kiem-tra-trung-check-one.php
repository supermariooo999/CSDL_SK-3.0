<?php
declare(strict_types=1);
require_once __DIR__ . '/../includes/helpers.php';
require_once __DIR__ . '/../classes/KiemTraTrungService.php';

$in = body_json();
$id = (int)($in['sang_kien_id'] ?? 0);
$lv = isset($in['linh_vuc_id']) ? (int)$in['linh_vuc_id'] : null;
if (!$id) json_error('Thiếu sang_kien_id');

try {
    json_ok((new KiemTraTrungService())->checkOne($id, $lv));
} catch (Throwable $e) {
    json_error($e->getMessage(), 500);
}