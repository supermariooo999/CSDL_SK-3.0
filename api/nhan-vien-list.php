<?php
declare(strict_types=1);

require_once __DIR__ . '/../includes/helpers.php';

try {

    /*
     * Chỉ lấy nhân viên:
     * - Chưa xoá (deleted_at IS NULL)
     * - Đang làm việc (id_trang_thai = 1)
     * - JOIN phòng ban + chức vụ để FE hiển thị đẹp
     *
     * Không filter theo phòng ban ở đây — FE tự filter client-side.
     * Vì danh sách thường nhỏ (< vài trăm), load 1 lần là đủ.
     */

    $rows = DB::all("
        SELECT
            nv.id,
            nv.ma_nhan_vien,
            nv.ho_ten,
            nv.gioi_tinh,
            nv.email,
            nv.anh_dai_dien,
            nv.id_phong_ban,
            nv.id_chuc_vu,
            nv.ngay_vao_lam,

            pb.ten_phong,
            pb.ten_tat AS ten_tat_phong,

            cv.ten_chuc_vu,
            cv.ten_tat  AS ten_tat_chuc_vu

        FROM nhan_vien nv

        LEFT JOIN phong_ban pb ON pb.id = nv.id_phong_ban
        LEFT JOIN chuc_vu   cv ON cv.id = nv.id_chuc_vu

        WHERE nv.deleted_at IS NULL
          AND nv.id_trang_thai = 1

        ORDER BY
            pb.thu_tu_cap ASC,
            cv.thu_tu_cap ASC,
            nv.ho_ten ASC
    ");

    // Chuẩn hoá output — chỉ giữ field FE cần, gọn payload
    $data = array_map(static function (array $r): array {
        return [
            'id'             => (int)$r['id'],
            'ma_nhan_vien'   => (string)($r['ma_nhan_vien'] ?? ''),
            'ho_ten'         => (string)($r['ho_ten'] ?? ''),
            'gioi_tinh'      => (string)($r['gioi_tinh'] ?? ''),
            'email'          => (string)($r['email'] ?? ''),
            'anh_dai_dien'   => (string)($r['anh_dai_dien'] ?? ''),

            'id_phong_ban'   => $r['id_phong_ban'] !== null
                                    ? (int)$r['id_phong_ban']
                                    : null,
            'ten_phong'      => (string)($r['ten_phong'] ?? ''),
            'ten_tat_phong'  => (string)($r['ten_tat_phong'] ?? ''),

            'id_chuc_vu'     => $r['id_chuc_vu'] !== null
                                    ? (int)$r['id_chuc_vu']
                                    : null,
            'ten_chuc_vu'    => (string)($r['ten_chuc_vu'] ?? ''),
            'ten_tat_chuc_vu'=> (string)($r['ten_tat_chuc_vu'] ?? ''),

            'ngay_vao_lam'   => $r['ngay_vao_lam'] ?? null,
        ];
    }, $rows);

    json_ok($data);

} catch (Throwable $e) {

    error_log('[nhan-vien-list] ' . $e->getMessage());

    json_error(
        'Không thể tải danh sách nhân viên: ' . $e->getMessage(),
        500
    );
}