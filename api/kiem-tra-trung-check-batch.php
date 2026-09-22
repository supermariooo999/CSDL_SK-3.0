<?php
declare(strict_types=1);
require_once __DIR__ . '/../includes/helpers.php';
require_once __DIR__ . '/../classes/KiemTraTrungService.php';

set_time_limit(0);
ini_set('memory_limit', '512M');

$in  = body_json();
$nam = (int)($in['nam_id'] ?? 0);
$lv  = isset($in['linh_vuc_id']) ? (int)$in['linh_vuc_id'] : null;
if (!$nam) json_error('Thiếu nam_id');

try {
    $dotId = (new KiemTraTrungService())->checkBatch($nam, $lv);
    json_ok(['dot_id' => $dotId]);
} catch (Throwable $e) {
    json_error($e->getMessage(), 500);
}