<?php
declare(strict_types=1);

require_once __DIR__ . '/SangKienSimilarity.php';

class KiemTraTrungService
{
    private SangKienSimilarity $sim;

    public function __construct() { $this->sim = new SangKienSimilarity(); }

    /** Check 1 sáng kiến với toàn bộ trong năm */
    public function checkOne(int $id, ?int $linhVucId = null, float $minScore = 40.0): array
    {
        $sk = DB::one("SELECT id, ma, ten, nam_id FROM qlsk_sang_kien WHERE id = ?", [$id]);
        if (!$sk) throw new RuntimeException('Sáng kiến không tồn tại');

        $sql = "SELECT id FROM qlsk_sang_kien WHERE nam_id = ? AND id <> ?";
        $p   = [$sk['nam_id'], $id];
        if ($linhVucId) { $sql .= " AND linh_vuc_id = ?"; $p[] = $linhVucId; }

        $list = DB::all($sql, $p);
        $results = [];
        foreach ($list as $r) {
            try {
                $cmp = $this->sim->compare($id, (int)$r['id']);
            } catch (Throwable $e) {
                error_log("[checkOne] id={$r['id']} err=" . $e->getMessage());
                continue;
            }
            if ($cmp['overall'] < $minScore) continue;

            // Rút gọn sections
            $secScore = [];
            foreach ($cmp['sections'] as $k => $v) $secScore[$k] = $v['score'] ?? 0;

            $results[] = [
                'sang_kien'      => $cmp['b'],
                'overall'        => $cmp['overall'],
                'classification' => $cmp['classification'],
                'sections'       => $secScore,
            ];
        }
        usort($results, fn($x, $y) => $y['overall'] <=> $x['overall']);

        return ['sang_kien' => $sk, 'ket_qua' => $results];
    }

    /**
     * Batch kiểm tra cả năm. Ghi vào qlsk_kiem_tra_trung_dot + _ket_qua
     * Trả về id đợt để FE gọi xem tiến độ.
     */
    public function checkBatch(int $namId, ?int $linhVucId = null): int
    {
        $sql = "SELECT id FROM qlsk_sang_kien WHERE nam_id = ?";
        $p   = [$namId];
        if ($linhVucId) { $sql .= " AND linh_vuc_id = ?"; $p[] = $linhVucId; }
        $list = DB::all($sql, $p);

        $n     = count($list);
        $total = $n * ($n - 1) / 2;

        DB::exec(
            "INSERT INTO qlsk_kiem_tra_trung_dot
                (nam_id, trang_thai, tong_so, da_xu_ly, so_phat_hien, created_at, started_at)
             VALUES (?, 'DANG_XU_LY', ?, 0, 0, NOW(), NOW())",
            [$namId, $total]
        );
        $dotId = (int)DB::lastId();

        $phatHien = 0;
        for ($i = 0; $i < $n; $i++) {
            for ($j = $i + 1; $j < $n; $j++) {
                try {
                    $cmp = $this->sim->compare((int)$list[$i]['id'], (int)$list[$j]['id']);
                } catch (Throwable $e) {
                    error_log("[batch] {$list[$i]['id']}-{$list[$j]['id']} err: " . $e->getMessage());
                    DB::exec("UPDATE qlsk_kiem_tra_trung_dot SET da_xu_ly = da_xu_ly + 1 WHERE id = ?", [$dotId]);
                    continue;
                }

                if (in_array($cmp['classification']['level'], ['CAO','RAT_CAO'], true)) $phatHien++;

                $tyLeTen = (float)($cmp['sections']['ten']['score'] ?? 0);
                DB::exec(
                    "INSERT INTO qlsk_kiem_tra_trung_ket_qua
                        (dot_id, sang_kien_id, doi_tuong_sang_kien_id,
                         ty_le_ten, ty_le_tai_lieu, ket_qua, created_at)
                     VALUES (?, ?, ?, ?, ?, ?, NOW())",
                    [
                        $dotId,
                        (int)$list[$i]['id'],
                        (int)$list[$j]['id'],
                        $tyLeTen,
                        $cmp['overall'],
                        $cmp['classification']['level'],
                    ]
                );
                DB::exec("UPDATE qlsk_kiem_tra_trung_dot SET da_xu_ly = da_xu_ly + 1 WHERE id = ?", [$dotId]);
            }
        }

        DB::exec(
            "UPDATE qlsk_kiem_tra_trung_dot
             SET trang_thai='HOAN_TAT', so_phat_hien=?, completed_at=NOW()
             WHERE id=?",
            [$phatHien, $dotId]
        );
        return $dotId;
    }

    public function getDot(int $dotId): array
    {
        $dot = DB::one("SELECT * FROM qlsk_kiem_tra_trung_dot WHERE id = ?", [$dotId]);
        if (!$dot) throw new RuntimeException('Đợt không tồn tại');

        $ketQua = DB::all(
            "SELECT kq.*, sa.ma AS ma_a, sa.ten AS ten_a,
                    sb.ma AS ma_b, sb.ten AS ten_b
             FROM qlsk_kiem_tra_trung_ket_qua kq
             JOIN qlsk_sang_kien sa ON sa.id = kq.sang_kien_id
             JOIN qlsk_sang_kien sb ON sb.id = kq.doi_tuong_sang_kien_id
             WHERE kq.dot_id = ?
             ORDER BY kq.ty_le_tai_lieu DESC",
            [$dotId]
        );
        foreach ($ketQua as &$r) $r['classification'] = (new SangKienSimilarity())->classify((float)$r['ty_le_tai_lieu']);
        unset($r);

        return ['dot' => $dot, 'ket_qua' => $ketQua];
    }

    public function listDot(int $namId = 0): array
    {
        if ($namId > 0) {
            return DB::all("SELECT * FROM qlsk_kiem_tra_trung_dot WHERE nam_id = ? ORDER BY id DESC", [$namId]);
        }
        return DB::all("SELECT * FROM qlsk_kiem_tra_trung_dot ORDER BY id DESC LIMIT 100");
    }
}