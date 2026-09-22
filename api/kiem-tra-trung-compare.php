<?php
declare(strict_types=1);
require_once __DIR__ . '/../includes/helpers.php';
require_once __DIR__ . '/../classes/SangKienSimilarity.php';

$in = body_json();
$idA = (int)($in['sang_kien_a'] ?? 0);
$idB = (int)($in['sang_kien_b'] ?? 0);
if (!$idA || !$idB || $idA === $idB) json_error('Thiếu tham số hoặc 2 sáng kiến trùng nhau');

try {
    $sim = new SangKienSimilarity();
    json_ok($sim->compare($idA, $idB));
} catch (Throwable $e) {
    json_error($e->getMessage(), 500);
}