<?php
declare(strict_types=1);

require_once __DIR__ . '/../includes/helpers.php';
require_once __DIR__ . '/../includes/sections.php';

class SangKienSimilarity
{
    /** Trọng số 7 tiêu chí */
    private const WEIGHTS = [
        'ten'       => 1.5,
        'boi_canh'  => 1.0,
        'muc_tieu'  => 1.0,
        'noi_dung'  => 2.0,
        'tinh_moi'  => 1.5,
        'hieu_qua'  => 1.0,
        'pham_vi'   => 0.5,
    ];

    /** So sánh 2 sáng kiến theo id */
    public function compare(int $idA, int $idB): array
    {
        $skA = DB::one("SELECT id, ma, ten, linh_vuc_id, nam_id FROM qlsk_sang_kien WHERE id = ?", [$idA]);
        $skB = DB::one("SELECT id, ma, ten, linh_vuc_id, nam_id FROM qlsk_sang_kien WHERE id = ?", [$idB]);
        if (!$skA || !$skB) throw new RuntimeException('Sáng kiến không tồn tại');

        $secA = get_sang_kien_sections($idA);
        $secB = get_sang_kien_sections($idB);

        $resp = nlp_post('/compare-sections', [
            'sections_a' => $secA,
            'sections_b' => $secB,
        ]);

        // Điểm tổng có trọng số
        $sum = 0.0; $wsum = 0.0;
        foreach ($resp as $k => $v) {
            $w = self::WEIGHTS[$k] ?? 1.0;
            $sum  += (float)($v['score'] ?? 0) * $w;
            $wsum += $w;
        }
        $overall = $wsum > 0 ? round($sum / $wsum, 2) : 0.0;

        return [
            'a'              => $skA,
            'b'              => $skB,
            'overall'        => $overall,
            'classification' => $this->classify($overall),
            'sections'       => $resp,   // bao gồm score + pairs để highlight
            'sections_a'     => $secA,
            'sections_b'     => $secB,
        ];
    }

    public function classify(float $s): array
    {
        if ($s >= 85) return ['level'=>'RAT_CAO',    'label'=>'Trùng / gần như trùng', 'color'=>'#dc2626','emoji'=>'🔴','bg'=>'#fee2e2'];
        if ($s >= 70) return ['level'=>'CAO',        'label'=>'Khả năng trùng cao',    'color'=>'#f97316','emoji'=>'🟠','bg'=>'#ffedd5'];
        if ($s >= 50) return ['level'=>'TRUNG_BINH', 'label'=>'Tương đồng một phần',   'color'=>'#eab308','emoji'=>'🟡','bg'=>'#fef9c3'];
        return         ['level'=>'THAP',             'label'=>'Khác biệt',             'color'=>'#16a34a','emoji'=>'🟢','bg'=>'#dcfce7'];
    }
}