<?php
declare(strict_types=1);

/**
 * Tách 7 phần theo mẫu "BÁO CÁO MÔ TẢ SÁNG KIẾN".
 * Chịu được các biến thể dấu câu, ký tự đặc biệt.
 */
function split_sang_kien_sections(string $content): array
{
    $keys = ['ten','boi_canh','muc_tieu','noi_dung','tinh_moi','hieu_qua','pham_vi'];
    $out = array_fill_keys($keys, '');

    // Chuẩn hóa
    $c = str_replace(["\r\n", "\r"], "\n", $content);
    $c = preg_replace("/[ \t]+/", ' ', $c);

    $rules = [
        'ten'      => '/1\.\s*T[êe]n\s*s[áa]ng\s*ki[ếe]n[^:\n]*[:\-]\s*(.+?)(?=\n\s*\d+\.|\z)/isu',
        'boi_canh' => '/(?:a\.\s*Kh[áa]i\s*qu[áa]t|Kh[áa]i\s*qu[áa]t\s*đ[ặa]c\s*đi[ểe]m|Đ[ặa]c\s*đi[ểe]m[^\n]*t[ìi]nh\s*h[ìi]nh|T[ìi]nh\s*h[ìi]nh\s*tr[ưu][ớo]c)[^\n]*\n(.+?)(?=\n\s*(?:b\.|\*\s*S[ựu]\s*c[ầa]n|S[ựu]\s*c[ầa]n\s*thi[ếe]t|M[ụu]c\s*đ[íi]ch|\*\s*N[ộo]i\s*dung|b\.\s*N[ộo]i\s*dung|\d+\.\s*H[ộo]i))/isu',
        'muc_tieu' => '/(?:\*\s*S[ựu]\s*c[ầa]n\s*thi[ếe]t|S[ựu]\s*c[ầa]n\s*thi[ếe]t|M[ụu]c\s*đ[íi]ch)[^\n]*[:\n](.+?)(?=\n\s*(?:b\.|\*\s*N[ộo]i|\d+\.\s*Qu|Qu[áa]n\s*tri[ệe]t|T[íi]nh\s*m[ớo]i))/isu',
        'noi_dung' => '/(?:b\.|\*\s*)N[ộo]i\s*dung\s*(?:s[áa]ng\s*ki[ếe]n|ch[íi]nh)?[^\n]*[:\n](.+?)(?=\n\s*\*?\s*T[íi]nh\s*m[ớo]i|\n\s*c\.\s*Hi[ệe]u|\n\s*\d+\.\s*H[ộo]i)/isu',
        'tinh_moi' => '/(?:\*\s*)?T[íi]nh\s*m[ớo]i(?:\s*c[ủu]a\s*s[áa]ng\s*ki[ếe]n)?[^\n]*[:\n](.+?)(?=\n\s*c\.\s*Hi[ệe]u|\n\s*Hi[ệe]u\s*qu[ảa]|\n\s*\d+\.\s*H[ộo]i)/isu',
        'hieu_qua' => '/c\.\s*Hi[ệe]u\s*qu[ảa][^\n]*[:\n](.+?)(?=\n\s*(?:Ph[ạa]m\s*vi|\-\s*Đ[ốo]i\s*t[ưu][ợo]ng|\d+\.\s*H[ộo]i))/isu',
        'pham_vi'  => '/(?:Ph[ạa]m\s*vi[^\n]*?(?:[ảa]nh\s*h[ưửu][ởơ]ng|nh[âa]n\s*r[ộo]ng|[áa]p\s*d[ụu]ng))[^\n]*[:\n](.+?)(?=\n\s*(?:\d+\.\s*H[ộo]i|6\.\s*Th[ờo]i|C[àa]\s*Mau|TRƯ[ỞO]NG))/isu',
    ];

    foreach ($rules as $k => $re) {
        if (preg_match($re, $c, $m)) {
            $out[$k] = trim($m[1]);
        }
    }
    return $out;
}

/** Lấy text đầy đủ của 1 sáng kiến (ưu tiên file_noi_dung) */
function get_sang_kien_full_text(int $id): string
{
    $row = DB::one(
        "SELECT noi_dung FROM qlsk_file_noi_dung
         WHERE sang_kien_id = ? ORDER BY ngay_trich_xuat DESC LIMIT 1", [$id]
    );
    if ($row && trim((string)$row['noi_dung']) !== '') return (string)$row['noi_dung'];

    $sk = DB::one(
        "SELECT ten, noi_dung, muc_tieu, ket_qua_du_kien
         FROM qlsk_sang_kien WHERE id = ? LIMIT 1", [$id]
    );
    if (!$sk) return '';
    return trim(implode("\n", array_filter([
        $sk['ten'], $sk['noi_dung'], $sk['muc_tieu'], $sk['ket_qua_du_kien'],
    ])));
}

function get_sang_kien_sections(int $id): array
{
    $text = get_sang_kien_full_text($id);
    $sec  = split_sang_kien_sections($text);

    // fallback tên nếu regex miss
    if (trim($sec['ten']) === '') {
        $row = DB::one("SELECT ten FROM qlsk_sang_kien WHERE id = ?", [$id]);
        if ($row) $sec['ten'] = (string)$row['ten'];
    }
    return $sec;
}