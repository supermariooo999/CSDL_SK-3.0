<?php
declare(strict_types=1);
require_once __DIR__ . '/../includes/helpers.php';

json_ok([
    'nam'     => DB::all("SELECT id, nam FROM qlsk_nam ORDER BY nam DESC"),
    'linh_vuc'=> DB::all("SELECT id, ma, ten FROM qlsk_linh_vuc WHERE trang_thai='HOAT_DONG' ORDER BY thu_tu"),
]);