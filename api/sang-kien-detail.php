<?php
declare(strict_types=1);

require_once __DIR__ . '/../includes/helpers.php';

try {
    $id = (int)($_GET['id'] ?? 0);

    if ($id <= 0) {
        json_error('ID không hợp lệ');
    }

    // =====================================================
    // 1. LẤY THÔNG TIN SÁNG KIẾN
    // =====================================================

    $sk = DB::one(
        "SELECT
            sk.id,
            sk.ma,
            sk.ten,
            sk.nam_id,
            sk.linh_vuc_id,
            sk.noi_dung,
            sk.muc_tieu,
            sk.ket_qua_du_kien,
            sk.ghi_chu,
            sk.ngay_nop,
            sk.trang_thai,
            sk.ten_co_quan_thue,
            n.nam       AS nam,
            lv.ten      AS ten_linh_vuc
        FROM qlsk_sang_kien sk
        LEFT JOIN qlsk_nam n        ON n.id = sk.nam_id
        LEFT JOIN qlsk_linh_vuc lv  ON lv.id = sk.linh_vuc_id
        WHERE sk.id = ?",
        [$id]
    );

    if (!$sk) {
        json_error('Không tìm thấy sáng kiến', 404);
    }

    // =====================================================
    // 2. LẤY DANH SÁCH TÁC GIẢ
    // =====================================================

    $authors = DB::all(
        "SELECT nhan_vien_id
         FROM qlsk_sang_kien_tac_gia
         WHERE sang_kien_id = ?
         ORDER BY thu_tu ASC, id ASC",
        [$id]
    );

    $sk['authors'] = array_map(
        static fn($row) => (int)$row['nhan_vien_id'],
        $authors
    );

    // =====================================================
    // 3. LẤY DANH SÁCH FILE ĐÍNH KÈM
    // =====================================================

    $files = DB::all(
        "SELECT
            id,
            loai_file,
            ten_file,
            duong_dan,
            kich_thuoc,
            ngay_tai_len
         FROM qlsk_file
         WHERE sang_kien_id = ?
         ORDER BY id ASC",
        [$id]
    );

    $sk['files'] = $files;

    // =====================================================
    // 4. TRẢ VỀ
    // =====================================================

    json_ok($sk);

} catch (Throwable $e) {
    json_error($e->getMessage(), 500);
}