<?php
declare(strict_types=1);

return [
    'db' => [
        'host'     => getenv('DB_HOST') ?: '127.0.0.1',
        'port'     => getenv('DB_PORT') ?: '3306',
        'name'     => getenv('DB_NAME') ?: 'qlns',
        'user'     => getenv('DB_USER') ?: 'root',
        'pass'     => getenv('DB_PASS') ?: '',
        'charset'  => 'utf8mb4',
    ],
    'nlp' => [
        'url'     => getenv('NLP_URL') ?: 'http://127.0.0.1:8001',
        'timeout' => 120,
    ],
    'app' => [
        'debug'   => (bool)(getenv('APP_DEBUG') ?: true),
    ],
];