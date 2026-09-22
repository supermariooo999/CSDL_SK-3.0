<?php

declare(strict_types=1);

require_once __DIR__ . '/../includes/helpers.php';
require_once __DIR__ . '/../includes/sections.php';

header('Content-Type: application/json; charset=utf-8');

try {

    $id = isset($_GET['id'])
        ? (int)$_GET['id']
        : 28;

    $text = get_sang_kien_full_text($id);
    $sections = get_sang_kien_sections($id);

    echo json_encode([
        'success' => true,
        'id' => $id,

        'full_text' => [
            'chars' => mb_strlen($text, 'UTF-8'),
            'preview' => mb_substr($text, 0, 2000, 'UTF-8'),
        ],

        'sections' => $sections,

        'lengths' => array_map(
            fn($v) => mb_strlen($v, 'UTF-8'),
            $sections
        ),

    ], JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);

} catch (Throwable $e) {

    http_response_code(500);

    echo json_encode([
        'success' => false,
        'error' => $e->getMessage(),
        'file' => $e->getFile(),
        'line' => $e->getLine(),
    ], JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
}