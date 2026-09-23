<?php

declare(strict_types=1);

require_once __DIR__ . '/helpers.php';

/**
 * Chuẩn hóa toàn bộ text đầu vào từ DB/File.
 */
function normalize_sang_kien_text(string $text): string
{
    // Xóa BOM
    $text = preg_replace('/^\xEF\xBB\xBF/u', '', $text);
    // Chuẩn hóa ngắt dòng (Windows/Mac -> Linux)
    $text = str_replace(["\r\n", "\r"], "\n", $text);
    // Chuẩn hóa khoảng trắng đặc biệt (NBSP, Tab, nhiểu space)
    $text = str_replace(["\xC2\xA0", "\t"], ' ', $text);
    
    // Làm sạch từng dòng
    $lines = array_map(static fn($line) => trim(preg_replace('/[ ]+/u', ' ', $line)), explode("\n", $text));

    return trim(implode("\n", $lines));
}

/**
 * Loại bỏ dấu tiếng Việt để so sánh chuỗi linh hoạt.
 */
function remove_vietnamese_accents(string $str): string
{
    // Các dấu Unicode dạng tổ hợp
    $str = preg_replace(
        '/[\x{0300}-\x{036f}]/u',
        '',
        $str
    );

    // Các ký tự tiếng Việt dạng dựng sẵn
    $map = [
        'à'=>'a', 'á'=>'a', 'ạ'=>'a', 'ả'=>'a', 'ã'=>'a',
        'â'=>'a', 'ầ'=>'a', 'ấ'=>'a', 'ậ'=>'a', 'ẩ'=>'a', 'ẫ'=>'a',
        'ă'=>'a', 'ằ'=>'a', 'ắ'=>'a', 'ặ'=>'a', 'ẳ'=>'a', 'ẵ'=>'a',

        'è'=>'e', 'é'=>'e', 'ẹ'=>'e', 'ẻ'=>'e', 'ẽ'=>'e',
        'ê'=>'e', 'ề'=>'e', 'ế'=>'e', 'ệ'=>'e', 'ể'=>'e', 'ễ'=>'e',

        'ì'=>'i', 'í'=>'i', 'ị'=>'i', 'ỉ'=>'i', 'ĩ'=>'i',

        'ò'=>'o', 'ó'=>'o', 'ọ'=>'o', 'ỏ'=>'o', 'õ'=>'o',
        'ô'=>'o', 'ồ'=>'o', 'ố'=>'o', 'ộ'=>'o', 'ổ'=>'o', 'ỗ'=>'o',
        'ơ'=>'o', 'ờ'=>'o', 'ớ'=>'o', 'ợ'=>'o', 'ở'=>'o', 'ỡ'=>'o',

        'ù'=>'u', 'ú'=>'u', 'ụ'=>'u', 'ủ'=>'u', 'ũ'=>'u',
        'ư'=>'u', 'ừ'=>'u', 'ứ'=>'u', 'ự'=>'u', 'ử'=>'u', 'ữ'=>'u',

        'ỳ'=>'y', 'ý'=>'y', 'ỵ'=>'y', 'ỷ'=>'y', 'ỹ'=>'y',

        'đ'=>'d',

        'À'=>'A', 'Á'=>'A', 'Ạ'=>'A', 'Ả'=>'A', 'Ã'=>'A',
        'Â'=>'A', 'Ầ'=>'A', 'Ấ'=>'A', 'Ậ'=>'A', 'Ẩ'=>'A', 'Ẫ'=>'A',
        'Ă'=>'A', 'Ằ'=>'A', 'Ắ'=>'A', 'Ặ'=>'A', 'Ẳ'=>'A', 'Ẵ'=>'A',

        'È'=>'E', 'É'=>'E', 'Ẹ'=>'E', 'Ẻ'=>'E', 'Ẽ'=>'E',
        'Ê'=>'E', 'Ề'=>'E', 'Ế'=>'E', 'Ệ'=>'E', 'Ể'=>'E', 'Ễ'=>'E',

        'Ì'=>'I', 'Í'=>'I', 'Ị'=>'I', 'Ỉ'=>'I', 'Ĩ'=>'I',

        'Ò'=>'O', 'Ó'=>'O', 'Ọ'=>'O', 'Ỏ'=>'O', 'Õ'=>'O',
        'Ô'=>'O', 'Ồ'=>'O', 'Ố'=>'O', 'Ộ'=>'O', 'Ổ'=>'O', 'Ỗ'=>'O',
        'Ơ'=>'O', 'Ờ'=>'O', 'Ớ'=>'O', 'Ợ'=>'O', 'Ở'=>'O', 'Ỡ'=>'O',

        'Ù'=>'U', 'Ú'=>'U', 'Ụ'=>'U', 'Ủ'=>'U', 'Ũ'=>'U',
        'Ư'=>'U', 'Ừ'=>'U', 'Ứ'=>'U', 'Ự'=>'U', 'Ử'=>'U', 'Ữ'=>'U',

        'Ỳ'=>'Y', 'Ý'=>'Y', 'Ỵ'=>'Y', 'Ỷ'=>'Y', 'Ỹ'=>'Y',

        'Đ'=>'D',
    ];

    return strtr($str, $map);
}

/**
 * Lấy toàn bộ nội dung thô của sáng kiến.
 */
function get_sang_kien_full_text(int $sangKienId): string
{
    $rows = DB::all(
        "SELECT noi_dung FROM qlsk_file_noi_dung WHERE sang_kien_id = ? ORDER BY id ASC",
        [$sangKienId]
    );

    $parts = array_filter(array_map(static fn($r) => trim((string)($r['noi_dung'] ?? '')), $rows));

    if (!empty($parts)) {
        return normalize_sang_kien_text(implode("\n\n", $parts));
    }

    // Fallback nếu không có trong qlsk_file_noi_dung
    $sk = DB::one("SELECT ten, noi_dung FROM qlsk_sang_kien WHERE id = ?", [$sangKienId]);
    if (!$sk) {
        return '';
    }

    return normalize_sang_kien_text(implode("\n\n", array_filter([$sk['ten'] ?? '', $sk['noi_dung'] ?? ''])));
}

function split_sang_kien_sections(string $text): array
{
    $result = [
        'ten'      => '',
        'linh_vuc' => '',
        'boi_canh' => '',
        'noi_dung' => '',
        'hieu_qua' => '',
    ];

    $text = normalize_sang_kien_text($text);

    if ($text === '') {
        return $result;
    }

    $lines = explode("\n", $text);

    $current = null;
    $buffer = [];

    /**
     * Flush buffer vào section hiện tại.
     */
    $flush = static function () use (&$result, &$current, &$buffer): void {
        if ($current === null) {
            $buffer = [];
            return;
        }

        $value = trim(implode("\n", $buffer));

        if ($value !== '') {
            $result[$current] = $value;
        }

        $buffer = [];
    };

    /**
     * Lấy nội dung sau dấu :
     */
    $extractInlineContent = static function (string $line): string {
        $pos = mb_strpos($line, ':');

        return $pos !== false
            ? trim(mb_substr($line, $pos + 1))
            : '';
    };

    foreach ($lines as $line) {
        $line = trim($line);

        if ($line === '') {
            if ($current !== null) {
                $buffer[] = '';
            }

            continue;
        }

        // Chuỗi không dấu để kiểm tra
        $asciiLine = strtolower(
            remove_vietnamese_accents($line)
        );

        /*
         * =====================================================
         * 1. TÊN SÁNG KIẾN
         * =====================================================
         */
        if (
            str_starts_with($asciiLine, '1.') &&
            str_contains($asciiLine, 'ten sang kien')
        ) {
            $flush();

            $result['ten'] = $extractInlineContent($line);

            $current = null;

            continue;
        }

        /*
         * =====================================================
         * 2/3. LĨNH VỰC ÁP DỤNG
         * =====================================================
         */
        if (
            str_contains($asciiLine, 'linh vuc ap dung')
        ) {
            $flush();

            $result['linh_vuc'] = $extractInlineContent($line);

            $current = null;

            continue;
        }

        /*
         * =====================================================
         * 4. MÔ TẢ SÁNG KIẾN
         *
         * Chỉ là heading, không tạo key mo_ta.
         * =====================================================
         */
        if (
            str_starts_with($asciiLine, '4.') &&
            str_contains($asciiLine, 'mo ta sang kien')
        ) {
            $flush();

            $current = null;

            continue;
        }

        /*
         * =====================================================
         * a. BỐI CẢNH
         * =====================================================
         */
        if (
            preg_match('/^a[.)]\s*/i', $asciiLine) &&
            str_contains($asciiLine, 'khai quat dac diem') &&
            str_contains($asciiLine, 'truoc khi co sang kien')
        ) {
            $flush();

            $current = 'boi_canh';

            // Giữ luôn tiêu đề a.
            $buffer[] = $line;

            continue;
        }

        /*
         * =====================================================
         * b. NỘI DUNG SÁNG KIẾN
         * =====================================================
         */
        if (
            preg_match('/^b[.)]\s*/i', $asciiLine) &&
            str_contains($asciiLine, 'noi dung sang kien')
        ) {
            $flush();

            $current = 'noi_dung';

            $inline = $extractInlineContent($line);

            if ($inline !== '') {
                $buffer[] = $inline;
            }

            continue;
        }

        /*
         * =====================================================
         * c. HIỆU QUẢ / PHẠM VI
         * =====================================================
         */
        if (
            preg_match('/^c[.)]\s*/i', $asciiLine) &&
            (
                str_contains($asciiLine, 'hieu qua') ||
                str_contains($asciiLine, 'pham vi')
            )
        ) {
            $flush();

            $current = 'hieu_qua';

            $inline = $extractInlineContent($line);

            if ($inline !== '') {
                $buffer[] = $inline;
            }

            continue;
        }

        /*
         * =====================================================
         * 5. HỘI ĐỒNG
         * 6. THỜI GIAN
         *
         * Kết thúc phần cần lấy.
         * =====================================================
         */
        if (
            (
                preg_match('/^5[.)]\s*/i', $asciiLine) &&
                str_contains($asciiLine, 'hoi dong')
            )
            ||
            (
                preg_match('/^6[.)]\s*/i', $asciiLine) &&
                str_contains($asciiLine, 'thoi gian')
            )
        ) {
            $flush();

            $current = null;

            continue;
        }

        /*
         * =====================================================
         * Nội dung bình thường
         * =====================================================
         */
        if ($current !== null) {
            $buffer[] = $line;
        }
    }

    /*
     * Flush section cuối.
     */
    $flush();

    /*
     * Dọn xuống dòng dư.
     */
    foreach ($result as $key => $value) {
        $result[$key] = trim(
            preg_replace("/\n{3,}/u", "\n\n", $value)
        );
    }

    return $result;
}

/**
 * Lấy danh sách section hoàn chỉnh (Có fallback từ DB nếu thiếu).
 */
function get_sang_kien_sections(int $sangKienId): array
{
    $text = get_sang_kien_full_text($sangKienId);
    $sections = split_sang_kien_sections($text);

    // Fallback tên nếu parse thất bại
    if (($sections['ten'] ?? '') === '') {
        $sk = DB::one("SELECT ten FROM qlsk_sang_kien WHERE id = ?", [$sangKienId]);
        if ($sk) {
            $sections['ten'] = trim((string)$sk['ten']);
        }
    }

    // Fallback lĩnh vực nếu parse thất bại
    if (($sections['linh_vuc'] ?? '') === '') {
        $sk = DB::one(
            "SELECT lv.ten AS linh_vuc 
             FROM qlsk_sang_kien sk 
             LEFT JOIN qlsk_linh_vuc lv ON lv.id = sk.linh_vuc_id 
             WHERE sk.id = ?",
            [$sangKienId]
        );
        if ($sk) {
            $sections['linh_vuc'] = trim((string)($sk['linh_vuc'] ?? ''));
        }
    }

    return $sections;
}