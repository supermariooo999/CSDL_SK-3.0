<?php

declare(strict_types=1);

use PhpOffice\PhpWord\IOFactory;


/**
 * Chuẩn hóa text để:
 * - tính hash
 * - so sánh nội dung
 */
function normalizeDocumentText(
    string $text
): string {

    $text = html_entity_decode(
        $text,
        ENT_QUOTES | ENT_HTML5,
        'UTF-8'
    );

    $text = strip_tags($text);

    $text = preg_replace(
        '/[ \t]+/u',
        ' ',
        $text
    );

    $text = preg_replace(
        '/\R+/u',
        "\n",
        $text
    );

    return trim($text);
}


/**
 * Đọc nội dung DOCX.
 *
 * Trả về:
 * - text: nội dung thuần
 * - html: nội dung HTML
 */
function extractDocxDocument(
    string $filePath
): array {

    $phpWord =
        IOFactory::load(
            $filePath
        );

    $html = '';

    $plainText = '';

    foreach (
        $phpWord->getSections()
        as $section
    ) {

        foreach (
            $section->getElements()
            as $element
        ) {

            /*
             * TextRun
             */
            if (
                $element instanceof
                \PhpOffice\PhpWord\Element\TextRun
            ) {

                $paragraphText = '';

                foreach (
                    $element->getElements()
                    as $child
                ) {

                    if (
                        $child instanceof
                        \PhpOffice\PhpWord\Element\Text
                    ) {

                        $paragraphText .=
                            $child->getText();
                    }
                }

                $paragraphText =
                    trim($paragraphText);

                if (
                    $paragraphText !== ''
                ) {

                    $safeText =
                        htmlspecialchars(
                            $paragraphText,
                            ENT_QUOTES,
                            'UTF-8'
                        );

                    $html .=
                        '<p>'
                        . $safeText
                        . '</p>';

                    $plainText .=
                        $paragraphText
                        . "\n";
                }

                continue;
            }

            /*
             * Text đơn
             */
            if (
                $element instanceof
                \PhpOffice\PhpWord\Element\Text
            ) {

                $value =
                    trim(
                        $element->getText()
                    );

                if ($value !== '') {

                    $safeText =
                        htmlspecialchars(
                            $value,
                            ENT_QUOTES,
                            'UTF-8'
                        );

                    $html .=
                        '<p>'
                        . $safeText
                        . '</p>';

                    $plainText .=
                        $value
                        . "\n";
                }
            }
        }
    }

    $plainText =
        normalizeDocumentText(
            $plainText
        );

    return [
        'text' => $plainText,
        'html' => $html
    ];
}

function saveFileContentCache(
    PDO $pdo,
    int $fileId,
    int $initiativeId,
    string $text,
    string $html
): void {

    $text =
        normalizeDocumentText(
            $text
        );

    $hash = null;

    if ($text !== '') {

        $hash =
            hash(
                'sha256',
                $text
            );
    }

    $stmt =
        $pdo->prepare("
            INSERT INTO qlsk_file_noi_dung
            (
                file_id,
                sang_kien_id,
                noi_dung,
                noi_dung_html,
                hash_noi_dung,
                ngay_trich_xuat
            )

            VALUES
            (?, ?, ?, ?, ?, NOW())

            ON DUPLICATE KEY UPDATE

                sang_kien_id =
                    VALUES(sang_kien_id),

                noi_dung =
                    VALUES(noi_dung),

                noi_dung_html =
                    VALUES(noi_dung_html),

                hash_noi_dung =
                    VALUES(hash_noi_dung),

                ngay_trich_xuat =
                    NOW()
        ");

    $stmt->execute([

        $fileId,

        $initiativeId,

        $text !== ''
            ? $text
            : null,

        $html !== ''
            ? $html
            : null,

        $hash
    ]);
}