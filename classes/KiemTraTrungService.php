<?php
declare(strict_types=1);

require_once __DIR__ . '/SangKienSimilarity.php';

class KiemTraTrungService
{
    private SangKienSimilarity $sim;

    public function __construct() { $this->sim = new SangKienSimilarity(); }

    /** Check 1 sáng kiến với toàn bộ trong năm */
    public function checkOne(int $id, ?int $linhVucId = null, float $minScore = 30.0): array {
        $sk = DB::one(
            "SELECT 
                sk.id,
                sk.ma,
                sk.ten,
                sk.nam_id,
                sk.linh_vuc_id,
                n.nam           AS nam,
                lv.ten          AS ten_linh_vuc
            FROM qlsk_sang_kien sk
            LEFT JOIN qlsk_nam n        ON n.id = sk.nam_id
            LEFT JOIN qlsk_linh_vuc lv  ON lv.id = sk.linh_vuc_id
            WHERE sk.id = ?",
            [$id]
        );

        if (!$sk) {
            throw new RuntimeException('Sáng kiến không tồn tại');
        }

        /*
        * Lấy TẤT CẢ sáng kiến khác,
        * KHÔNG giới hạn năm.
        */
        $sql = "
            SELECT id
            FROM qlsk_sang_kien
            WHERE id <> ?
        ";

        // CHỈ truyền đúng tham số cho WHERE id <> ?
        $params = [$id];

        /*
        * Nếu muốn giới hạn theo lĩnh vực thì mới thêm điều kiện này.
        *
        * null hoặc 0 = tất cả lĩnh vực.
        */
        if ($linhVucId !== null && $linhVucId > 0) {
            $sql .= " AND linh_vuc_id = ?";
            $params[] = $linhVucId;
        }

        $sql .= " ORDER BY id ASC";

        $list = DB::all($sql, $params);
        
        $results = [];

        foreach ($list as $r) {

            $otherId = (int)$r['id'];

            try {

                $cmp = $this->sim->compare(
                    $id,
                    $otherId
                );

            } catch (Throwable $e) {

                error_log(
                    "[checkOne] {$id}-{$otherId} err=" .
                    $e->getMessage()
                );

                continue;
            }

            /*
            * minScore = 0 => lấy tất cả.
            */
            if (
                ($cmp['classification']['level'] ?? '') === 'THAP'
            ) {
                continue;
            }
            
            if ($cmp['overall'] < $minScore) {
                continue;
            }

            

            $results[] = [
                'sang_kien'      => $cmp['b'],
                'overall'        => $cmp['overall'],
                'classification' => $cmp['classification'],
                'sections'       => $cmp['sections'],
            ];
        }


        /*
        * Tương đồng cao → thấp.
        */
        usort(
            $results,
            fn($a, $b) =>
                $b['overall'] <=> $a['overall']
        );

        return [
            'sang_kien' => $sk,
            'ket_qua'   => $results,
        ];
    }
}