<?php
declare(strict_types=1);
require_once __DIR__ . '/../includes/helpers.php';

$nam    = (int)($_GET['nam_id'] ?? 0);
$lv     = (int)($_GET['linh_vuc_id'] ?? 0);
$q      = trim((string)($_GET['q'] ?? ''));

$sql = "SELECT sk.id, sk.ma, sk.ten, sk.nam_id, sk.linh_vuc_id,
               lv.ten AS ten_linh_vuc, n.nam
        FROM qlsk_sang_kien sk
        LEFT JOIN qlsk_linh_vuc lv ON lv.id = sk.linh_vuc_id
        LEFT JOIN qlsk_nam n ON n.id = sk.nam_id
        WHERE 1=1";
$p = [];
if ($nam) { $sql .= " AND sk.nam_id = ?"; $p[] = $nam; }
if ($lv)  { $sql .= " AND sk.linh_vuc_id = ?"; $p[] = $lv; }
if ($q !== '') { $sql .= " AND (sk.ten LIKE ? OR sk.ma LIKE ?)"; $p[] = "%$q%"; $p[] = "%$q%"; }
$sql .= " ORDER BY sk.id DESC LIMIT 500";

json_ok(DB::all($sql, $p));