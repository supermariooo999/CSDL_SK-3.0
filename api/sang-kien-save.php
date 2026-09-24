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
    // 4. KIỂM TRA TRÙNG MÃ TRONG CÙNG NĂM
    // =====================================================

    $duplicate = DB::one(
        "SELECT id
         FROM qlsk_sang_kien
         WHERE nam_id = ?
           AND ma = ?
           AND id <> ?
         LIMIT 1",
        [$yearId, $code, $id]
    );

    if ($duplicate) {
        json_error(
            'Mã sáng kiến "' . $code . '" đã tồn tại trong năm được chọn.',
            422
        );
    }

    // =====================================================
    // 5. XỬ LÝ TRANSACTION
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

            /*
             * ✅ KHÔNG xoá file cũ ở đây.
             *
             * Việc xoá file được xử lý riêng trong processUploadedFiles():
             * chỉ xoá file cũ của ĐÚNG LOẠI khi user upload file mới
             * thay thế (Mẫu 01/05/06).
             *
             * File minh chứng: append thêm, không xoá.
             */

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
    $stmt = $pdo->prepare(
        "DELETE FROM qlsk_sang_kien_tac_gia WHERE sang_kien_id = ?"
    );
    $stmt->execute([$initiativeId]);

    $authorIds = $_POST['author_ids'] ?? [];

    if (!is_array($authorIds) || count($authorIds) === 0) {
        return;
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
 * QUY TẮC:
 * - File Mẫu 01/05/06: mỗi loại chỉ giữ 1 file.
 *   Nếu user upload file mới → xoá file cũ CÙNG LOẠI trước khi lưu file mới.
 *   Nếu user KHÔNG upload → giữ nguyên file cũ.
 *
 * - File minh chứng: append thêm, không xoá file cũ.
 */
function processUploadedFiles(PDO $pdo, int $initiativeId): void
{
    $baseDir    = realpath(__DIR__ . '/..');
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

    $maxSize = 20 * 1024 * 1024;

    $singleFields = [
        'file_mau_01' => 'MAU_01',
        'file_mau_05' => 'MAU_05',
        'file_mau_06' => 'MAU_06',
    ];

    $mapFileName = [
        'file_mau_01' => 'Mẫu số 01/SK',
        'file_mau_05' => 'Mẫu số 05/SK',
        'file_mau_06' => 'Mẫu số 06/SK',
    ];

    // ---------- SINGLE FILES ----------

    foreach ($singleFields as $field => $loaiFile) {

        if (!isset($_FILES[$field])) continue;

        $f = $_FILES[$field];

        // Không upload file mới → giữ file cũ
        if ($f['error'] === UPLOAD_ERR_NO_FILE) continue;

        if ($f['error'] !== UPLOAD_ERR_OK) {
            throw new RuntimeException(
                "Lỗi upload file {$mapFileName[$field]} (code {$f['error']})."
            );
        }

        if ($f['size'] > $maxSize) {
            throw new RuntimeException(
                "File {$mapFileName[$field]} vượt quá 20MB."
            );
        }

        $ext = strtolower(pathinfo($f['name'], PATHINFO_EXTENSION));

        if ($ext !== 'docx') {
            throw new RuntimeException(
                "File {$mapFileName[$field]} chỉ nhận DOCX."
            );
        }

        // Xoá file cũ CÙNG LOẠI trước khi lưu file mới
        deleteFilesByType($pdo, $initiativeId, $loaiFile, $baseDir);

        saveUploadedFile(
            $pdo,
            $initiativeId,
            $loaiFile,
            $f,
            $storageDir,
            $baseDir,
            $allowed,
            $ext
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
                    throw new RuntimeException(
                        "Lỗi upload file minh chứng #" . ($i + 1)
                    );
                }

                if ($m['size'][$i] > $maxSize) {
                    throw new RuntimeException(
                        "File minh chứng #" . ($i + 1) . " vượt quá 20MB."
                    );
                }

                $ext = strtolower(pathinfo($m['name'][$i], PATHINFO_EXTENSION));

                if (!isset($allowed[$ext])) {
                    throw new RuntimeException(
                        "Định dạng file minh chứng không hợp lệ: .$ext"
                    );
                }

                $single = [
                    'name'     => $m['name'][$i],
                    'type'     => $m['type'][$i],
                    'tmp_name' => $m['tmp_name'][$i],
                    'error'    => $m['error'][$i],
                    'size'     => $m['size'][$i],
                ];

                // Minh chứng: append thêm, không xoá file cũ
                saveUploadedFile(
                    $pdo,
                    $initiativeId,
                    'MINH_CHUNG',
                    $single,
                    $storageDir,
                    $baseDir,
                    $allowed,
                    $ext
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

    // Trích xuất nội dung DOCX cho Mẫu 01/05/06
    if (
        in_array($loaiFile, ['MAU_01', 'MAU_05', 'MAU_06'], true)
        && $ext === 'docx'
    ) {
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


/**
 * Xoá file cũ của 1 loại cụ thể (MAU_01, MAU_05, MAU_06, MINH_CHUNG).
 *
 * - Xoá file vật lý (dùng absolute path)
 * - Xoá content cache (qlsk_file_noi_dung)
 * - Xoá record DB (qlsk_file)
 */
function deleteFilesByType(
    PDO $pdo,
    int $initiativeId,
    string $loaiFile,
    string $baseDir
): void {

    // Lấy danh sách file cần xoá
    $rows = DB::all(
        "SELECT id, duong_dan
         FROM qlsk_file
         WHERE sang_kien_id = ?
           AND loai_file = ?",
        [$initiativeId, $loaiFile]
    );

    if (!$rows) return;

    $fileIds = [];

    foreach ($rows as $row) {

        $fileIds[] = (int)$row['id'];

        if (empty($row['duong_dan'])) continue;

        // Chuyển relative path → absolute path
        $absPath = $baseDir . '/' . ltrim($row['duong_dan'], '/');

        if (is_file($absPath)) {
            @unlink($absPath);
        }
    }

    // Xoá content cache
    if ($fileIds) {
        $placeholders = implode(',', array_fill(0, count($fileIds), '?'));

        $stmt = $pdo->prepare(
            "DELETE FROM qlsk_file_noi_dung WHERE file_id IN ($placeholders)"
        );
        $stmt->execute($fileIds);
    }

    // Xoá record file
    $stmt = $pdo->prepare(
        "DELETE FROM qlsk_file
         WHERE sang_kien_id = ?
           AND loai_file = ?"
    );
    $stmt->execute([$initiativeId, $loaiFile]);
}