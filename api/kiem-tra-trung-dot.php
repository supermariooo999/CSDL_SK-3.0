<?php
declare(strict_types=1);
require_once __DIR__ . '/../includes/helpers.php';
require_once __DIR__ . '/../classes/KiemTraTrungService.php';

$id = (int)($_GET['id'] ?? 0);
if (!$id) json_error('Thiếu id');
try {
    json_ok((new KiemTraTrungService())->getDot($id));
} catch (Throwable $e) {
    json_error($e->getMessage(), 500);
}