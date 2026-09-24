<?php
require_once '../classes/SangKienSimilarity.php';

$sim = new SangKienSimilarity();

$cases = [
    // Viết tắt
    ['Ứng dụng CNTT vào quản lý thuế', 'Ứng dụng công nghệ thông tin vào quản lý thuế'],
    ['Quản lý thuế GTGT', 'Quản lý thuế giá trị gia tăng'],
    ['Quản lý thuế TNCN', 'Quản lý thuế thu nhập cá nhân'],
    ['Ứng dụng AI trong kiểm tra', 'Ứng dụng trí tuệ nhân tạo trong kiểm tra'],

    // Đồng nghĩa
    ['Nâng cao hiệu quả quản lý thuế', 'Cải thiện hiệu quả quản lý thuế'],
    ['Giải pháp nâng cao chất lượng', 'Biện pháp cải thiện chất lượng'],
    ['Xây dựng hệ thống báo cáo', 'Thiết lập hệ thống báo cáo'],
    ['Thực hiện kiểm tra thuế', 'Triển khai thanh tra thuế'],

    // Kết hợp
    ['Nâng cao hiệu quả quản lý thuế GTGT', 'Cải thiện hiệu quả quản lý thuế giá trị gia tăng'],

    // Control — phải thấp
    ['Quản lý thuế doanh nghiệp', 'Quản lý nhân sự nội bộ'],
    ['Nâng cao năng lực cán bộ', 'Nâng cao trách nhiệm công chức'],
];

printf("%-70s %-8s\n", "Cặp", "Score"); echo "<br>";
echo str_repeat('-', 90) . "\n"; echo "<br>";

foreach ($cases as [$a, $b]) {
    $score = $sim->compareNames($a, $b);
    printf(
        "%-70s %-8.2f\n",
        mb_substr($a . ' || ' . $b, 0, 68),
        $score
    ); echo "<br>";
}