<?php
declare(strict_types=1);

require_once __DIR__ . '/../includes/helpers.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    json_error('Phương thức không hợp lệ', 405);
}

$body = body_json();
$id   = (int)($body['id'] ?? 0);

if ($id <= 0) {
    json_error('ID không hợp lệ');
}

$sk = DB::one("SELECT id, ma, ten FROM qlsk_sang_kien WHERE id = ?", [$id]);
if (!$sk) {
    json_error('Không tìm thấy sáng kiến', 404);
}

$pdo = DB::conn();
$pdo->beginTransaction();

try {

    // =====================================================
    // 1. LẤY DANH SÁCH FILE ĐỂ XOÁ VẬT LÝ
    // =====================================================

    $files = DB::all(
        "SELECT id, duong_dan FROM qlsk_file WHERE sang_kien_id = ?",
        [$id]
    );

    // =====================================================
    // 2. XOÁ FILE VẬT LÝ
    // =====================================================

    $baseDir = realpath(__DIR__ . '/..'); // thư mục gốc project

    foreach ($files as $f) {

        $duongDan = (string)($f['duong_dan'] ?? '');
        if ($duongDan === '') continue;

        // Chuẩn hoá: DB lưu "storage/sang-kien/23/xxx.docx"
        $abs = $baseDir . DIRECTORY_SEPARATOR
             . str_replace('/', DIRECTORY_SEPARATOR, $duongDan);

        // Chỉ xoá nếu nằm trong project (chống path traversal)
        $real = realpath($abs);
        if ($real && str_starts_with($real, $baseDir) && is_file($real)) {
            @unlink($real);
        }
    }

    // Xoá thư mục chứa file nếu còn rỗng
    $dir = $baseDir . DIRECTORY_SEPARATOR . 'storage'
         . DIRECTORY_SEPARATOR . 'sang-kien'
         . DIRECTORY_SEPARATOR . $id;

    if (is_dir($dir)) {
        // Xoá file còn sót
        foreach (glob($dir . '/*') ?: [] as $f) {
            @unlink($f);
        }
        @rmdir($dir);
    }

    // =====================================================
    // 3. XOÁ DB (theo thứ tự FK)
    // =====================================================

    // qlsk_file_noi_dung (nếu không có ON DELETE CASCADE)
    DB::exec("DELETE FROM qlsk_file_noi_dung WHERE sang_kien_id = ?", [$id]);

    // qlsk_file
    DB::exec("DELETE FROM qlsk_file WHERE sang_kien_id = ?", [$id]);

    // qlsk_phan_cong_cham (nếu không cascade)
    DB::exec("DELETE FROM qlsk_phan_cong_cham WHERE sang_kien_id = ?", [$id]);

    // qlsk_sang_kien_tac_gia
    DB::exec("DELETE FROM qlsk_sang_kien_tac_gia WHERE sang_kien_id = ?", [$id]);

    // qlsk_kiem_tra_trung_ket_qua (bảng kết quả trùng)
    DB::exec(
        "DELETE FROM qlsk_kiem_tra_trung_ket_qua
         WHERE sang_kien_id = ? OR doi_tuong_sang_kien_id = ?",
        [$id, $id]
    );

    // Cuối cùng: sáng kiến
    DB::exec("DELETE FROM qlsk_sang_kien WHERE id = ?", [$id]);

    $pdo->commit();

    json_ok([
        'id'      => $id,
        'deleted_files' => count($files),
        'message' => 'Đã xoá sáng kiến và toàn bộ file đính kèm.',
    ]);

} catch (Throwable $e) {

    $pdo->rollBack();
    error_log('[sang-kien-delete] id=' . $id . ' err=' . $e->getMessage());
    json_error('Không thể xoá: ' . $e->getMessage(), 500);
}