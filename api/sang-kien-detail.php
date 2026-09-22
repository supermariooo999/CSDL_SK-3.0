<?php
declare(strict_types=1);
require_once __DIR__ . '/../includes/helpers.php';
require_once __DIR__ . '/../includes/sections.php';

$id = (int)($_GET['id'] ?? 0);
$sk = DB::one("SELECT * FROM qlsk_sang_kien WHERE id = ?", [$id]);
if (!$sk) json_error('Không tìm thấy', 404);

$sk['sections'] = get_sang_kien_sections($id);
json_ok($sk);