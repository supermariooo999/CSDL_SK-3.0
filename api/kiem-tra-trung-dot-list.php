<?php
declare(strict_types=1);
require_once __DIR__ . '/../includes/helpers.php';
require_once __DIR__ . '/../classes/KiemTraTrungService.php';

$nam = (int)($_GET['nam_id'] ?? 0);
json_ok((new KiemTraTrungService())->listDot($nam));