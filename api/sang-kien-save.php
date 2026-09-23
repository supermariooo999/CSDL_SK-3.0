<?php
declare(strict_types=1);
require_once __DIR__ . '/../vendor/autoload.php';
require_once __DIR__ . '/../includes/helpers.php';
require_once __DIR__ . '/../includes/document_extractor.php';
require_once __DIR__ . '/../includes/utils.php';

header('Content-Type: application/json; charset=utf-8');

// ========== DEBUG ==========
error_log('=== sang-kien-save DEBUG ===');
error_log('POST keys: ' . implode(',', array_keys($_POST)));
error_log('FILES keys: ' . implode(',', array_keys($_FILES)));
error_log('FILES detail: ' . print_r($_FILES, true));
error_log('author_ids: ' . print_r($_POST['author_ids'] ?? 'NOT SET', true));
// ===========================

try {

    if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
        json_error('Phương thức không hợp lệ.', 405);
    }

    $pdo = DB::conn();

    // =====================================================
    // 1. ĐỌC INPUT
    // =====================================================

    $id            = (int)($_POST['id'] ?? 0);
    $yearId        = (int)($_POST['nam_id'] ?? 0);
    $fieldId       = (int)($_POST['linh_vuc_id'] ?? 0) ?: null;
    $loaiSangKien  = trim((string)($_POST['loai_sang_kien'] ?? 'NOI_BO'));
    $tenCoQuanThue = trim((string)($_POST['ten_co_quan_thue'] ?? ''));
    $code          = trim((string)($_POST['ma'] ?? ''));
    $name          = trim((string)($_POST['ten'] ?? ''));
    $content       = trim((string)($_POST['noi_dung'] ?? ''));
    $objective     = trim((string)($_POST['muc_tieu'] ?? ''));
    $expected      = trim((string)($_POST['ket_qua_du_kien'] ?? ''));
    $note          = trim((string)($_POST['ghi_chu'] ?? ''));
    $dateRaw       = trim((string)($_POST['ngay_nop'] ?? ''));
    $trangThai     = trim((string)($_POST['trang_thai'] ?? 'DA_NOP'));

    // =====================================================
    // 2. VALIDATE
    // =====================================================

    if (!in_array($loaiSangKien, ['NOI_BO', 'KHAC_CQT'], true)) {
        json_error('Loại sáng kiến không hợp lệ.', 422);
    }

    if ($yearId <= 0) {
        json_error('Vui lòng chọn năm.', 422);
    }

    if ($code === '') {
        json_error('Vui lòng nhập mã sáng kiến.', 422);
    }

    if (!preg_match('/^[A-Za-z0-9._\/-]{1,50}$/u', $code)) {
        json_error('Mã sáng kiến không hợp lệ.', 422);
    }

    if ($name === '') {
        json_error('Vui lòng nhập tên sáng kiến.', 422);
    }

    // =====================================================
    // 3. CHUẨN HOÁ NGÀY NỘP
    // =====================================================

    $date = null;
    if ($loaiSangKien === 'NOI_BO' && $dateRaw !== '') {
        $date = normalizeDate($dateRaw);
        if ($date === null) {
            json_error('Ngày nộp không hợp lệ.', 422);
        }
    }

    // =====================================================
    // 4. XỬ LÝ TRANSACTION
    // =====================================================

    $pdo->beginTransaction();

    try {

        // ---------- UPDATE ----------

        if ($id > 0) {

            $exists = DB::one(
                "SELECT id FROM qlsk_sang_kien WHERE id = ?",
                [$id]
            );

            if (!$exists) {
                throw new RuntimeException('Không tìm thấy sáng kiến.');
            }

            DB::exec(
                "UPDATE qlsk_sang_kien SET
                    nam_id            = ?,
                    linh_vuc_id       = ?,
                    loai_sang_kien    = ?,
                    ten_co_quan_thue  = ?,
                    ma                = ?,
                    ten               = ?,
                    noi_dung          = ?,
                    muc_tieu          = ?,
                    ket_qua_du_kien   = ?,
                    ngay_nop          = ?,
                    trang_thai        = ?,
                    ghi_chu           = ?,
                    updated_at        = CURRENT_TIMESTAMP
                 WHERE id = ?",
                [
                    $yearId,
                    $fieldId,
                    $loaiSangKien,
                    $tenCoQuanThue,
                    $code,
                    $name,
                    $content,
                    $objective,
                    $expected,
                    $date,
                    $trangThai,
                    $note,
                    $id,
                ]
            );

            $initiativeId = $id;

            // Xoá file cũ trước khi upload file mới
            deleteInitiativeFiles($pdo, $initiativeId);

        }

        // ---------- INSERT ----------

        else {

            DB::exec(
                "INSERT INTO qlsk_sang_kien
                    (nam_id, linh_vuc_id, loai_sang_kien, ten_co_quan_thue,
                     ma, ten, noi_dung, muc_tieu, ket_qua_du_kien,
                     ngay_nop, trang_thai, ghi_chu)
                 VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                [
                    $yearId,
                    $fieldId,
                    $loaiSangKien,
                    $tenCoQuanThue,
                    $code,
                    $name,
                    $content,
                    $objective,
                    $expected,
                    $date,
                    $trangThai,
                    $note,
                ]
            );

            $initiativeId = (int)$pdo->lastInsertId();
        }

        // ---------- TÁC GIẢ ----------

        saveAuthors($pdo, $initiativeId);

        // ---------- FILE ----------

        processUploadedFiles($pdo, $initiativeId);

        // ---------- COMMIT ----------

        $pdo->commit();

        json_ok([
            'id'      => $initiativeId,
            'message' => $id > 0
                ? 'Đã cập nhật sáng kiến.'
                : 'Đã thêm sáng kiến.',
        ]);

    } catch (Throwable $e) {

        if ($pdo->inTransaction()) {
            $pdo->rollBack();
        }

        error_log('[sang-kien-save] ' . $e->getMessage());

        json_error($e->getMessage(), 422);
    }

} catch (Throwable $e) {

    error_log('[sang-kien-save] outer: ' . $e->getMessage());
    json_error($e->getMessage(), 500);
}


/* =====================================================
   HELPERS
===================================================== */

/**
 * Chuẩn hoá ngày về Y-m-d.
 * Nhận cả dd/mm/yyyy và yyyy-mm-dd.
 */
function normalizeDate(string $raw): ?string
{
    $raw = trim($raw);
    if ($raw === '') return null;

    // yyyy-mm-dd
    if (preg_match('/^\d{4}-\d{2}-\d{2}$/', $raw)) {
        return $raw;
    }

    // dd/mm/yyyy
    if (preg_match('#^(\d{1,2})/(\d{1,2})/(\d{4})$#', $raw, $m)) {
        return sprintf('%04d-%02d-%02d', $m[3], $m[2], $m[1]);
    }

    return null;
}

/**
 * Lưu tác giả / đồng tác giả.
 *
 * Input:
 *   $_POST['author_ids'] = [15, 27, 42]  (đã sắp theo thứ tự)
 *
 * Người đầu tiên = TAC_GIA, còn lại = DONG_TAC_GIA.
 */
function saveAuthors(PDO $pdo, int $initiativeId): void
{
    // Xoá tác giả cũ
    DB::exec(
        "DELETE FROM qlsk_sang_kien_tac_gia WHERE sang_kien_id = ?",
        [$initiativeId]
    );

    $authorIds = $_POST['author_ids'] ?? [];

    if (!is_array($authorIds) || count($authorIds) === 0) {
        return; // Không có tác giả → OK, bỏ qua
    }

    // Lọc ID hợp lệ, giữ nguyên thứ tự
    $authorIds = array_values(array_filter(
        array_map('intval', $authorIds),
        fn($v) => $v > 0
    ));

    if (count($authorIds) === 0) return;

    $stmt = $pdo->prepare(
        "INSERT INTO qlsk_sang_kien_tac_gia
            (sang_kien_id, nhan_vien_id, vai_tro, thu_tu)
         VALUES (?, ?, ?, ?)"
    );

    foreach ($authorIds as $index => $nhanVienId) {
        $stmt->execute([
            $initiativeId,
            $nhanVienId,
            $index === 0 ? 'TAC_GIA' : 'DONG_TAC_GIA',
            $index + 1,
        ]);
    }
}

/**
 * Xử lý upload file.
 *
 * Nhận:
 *   $_FILES['file_mau_01']          (single)
 *   $_FILES['file_mau_05']          (single)
 *   $_FILES['file_mau_06']          (single)
 *   $_FILES['files_minh_chung']     (multiple)
 */
function processUploadedFiles(PDO $pdo, int $initiativeId): void
{
    $baseDir = realpath(__DIR__ . '/..');
    $storageDir = $baseDir . '/storage/sang-kien/' . $initiativeId;

    if (!is_dir($storageDir)) {
        mkdir($storageDir, 0755, true);
    }

    $allowed = [
        'doc'  => 'application/msword',
        'docx' => 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
        'pdf'  => 'application/pdf',
        'jpg'  => 'image/jpeg',
        'jpeg' => 'image/jpeg',
        'png'  => 'image/png',
        'xls'  => 'application/vnd.ms-excel',
        'xlsx' => 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    ];

    $maxSize = 20 * 1024 * 1024; // 20MB

    // Map field → loai_file
    $singleFields = [
        'file_mau_01' => 'MAU_01',
        'file_mau_05' => 'MAU_05',
        'file_mau_06' => 'MAU_06',
    ];

    // ---------- SINGLE FILES ----------

    foreach ($singleFields as $field => $loaiFile) {

        if (!isset($_FILES[$field])) continue;

        $f = $_FILES[$field];
        if ($f['error'] === UPLOAD_ERR_NO_FILE) continue;

        if ($f['error'] !== UPLOAD_ERR_OK) {
            throw new RuntimeException("Lỗi upload file $field (code {$f['error']}).");
        }

        if ($f['size'] > $maxSize) {
            throw new RuntimeException("File $field vượt quá 20MB.");
        }

        $ext = strtolower(pathinfo($f['name'], PATHINFO_EXTENSION));

        if (!in_array($ext, ['doc', 'docx'], true)) {
            throw new RuntimeException("File $field chỉ nhận DOC/DOCX.");
        }

        saveUploadedFile(
            $pdo, $initiativeId, $loaiFile,
            $f, $storageDir, $baseDir,
            $allowed, $ext
        );
    }

    // ---------- MULTIPLE: MINH CHỨNG ----------

    if (isset($_FILES['files_minh_chung'])) {

        $m = $_FILES['files_minh_chung'];

        if (is_array($m['name'])) {

            $count = count($m['name']);

            for ($i = 0; $i < $count; $i++) {

                if ($m['error'][$i] === UPLOAD_ERR_NO_FILE) continue;

                if ($m['error'][$i] !== UPLOAD_ERR_OK) {
                    throw new RuntimeException("Lỗi upload file minh chứng #" . ($i + 1));
                }

                if ($m['size'][$i] > $maxSize) {
                    throw new RuntimeException("File minh chứng #" . ($i + 1) . " vượt quá 20MB.");
                }

                $ext = strtolower(pathinfo($m['name'][$i], PATHINFO_EXTENSION));

                if (!isset($allowed[$ext])) {
                    throw new RuntimeException("Định dạng file minh chứng không hợp lệ: .$ext");
                }

                $single = [
                    'name'     => $m['name'][$i],
                    'type'     => $m['type'][$i],
                    'tmp_name' => $m['tmp_name'][$i],
                    'error'    => $m['error'][$i],
                    'size'     => $m['size'][$i],
                ];

                saveUploadedFile(
                    $pdo, $initiativeId, 'MINH_CHUNG',
                    $single, $storageDir, $baseDir,
                    $allowed, $ext
                );
            }
        }
    }
}

/**
 * Lưu 1 file vật lý + record DB + trích xuất nội dung.
 */
function saveUploadedFile(
    PDO $pdo,
    int $initiativeId,
    string $loaiFile,
    array $file,
    string $storageDir,
    string $baseDir,
    array $allowed,
    string $ext
): void {

    $originalName = $file['name'];
    $unique       = bin2hex(random_bytes(16)) . '.' . $ext;
    $absolutePath = $storageDir . '/' . $unique;
    $relativePath = 'storage/sang-kien/' . $initiativeId . '/' . $unique;

    if (!move_uploaded_file($file['tmp_name'], $absolutePath)) {
        throw new RuntimeException("Không thể lưu file: $originalName");
    }

    $mime = $allowed[$ext] ?? ($file['type'] ?: 'application/octet-stream');

    DB::exec(
        "INSERT INTO qlsk_file
            (sang_kien_id, loai_file, ten_file, ten_file_luu,
             duong_dan, dinh_dang, mime_type, kich_thuoc, ngay_tai_len)
         VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW())",
        [
            $initiativeId,
            $loaiFile,
            $originalName,
            $unique,
            $relativePath,
            $ext,
            $mime,
            (int)$file['size'],
        ]
    );

    $fileId = (int)$pdo->lastInsertId();
    
    // Trích xuất nội dung DOCX (chỉ với MAU_01 / MAU_05 / MAU_06)
    if (in_array($loaiFile, ['MAU_01', 'MAU_05', 'MAU_06'], true)
        && in_array($ext, ['docx', 'doc'], true)) {
        try {
            $data = extractDocxDocument($absolutePath);

            saveFileContentCache(
                $pdo,
                $fileId,
                $initiativeId,
                $data['text'] ?? '',
                $data['html'] ?? ''
            );
        } catch (Throwable $e) {
            // Không chặn save nếu extract lỗi
            error_log("[extract] file=$absolutePath err=" . $e->getMessage());
        }
    }
}