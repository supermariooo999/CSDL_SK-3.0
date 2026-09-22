<?php
declare(strict_types=1);

require_once __DIR__ . '/db.php';

function json_response($data, int $code = 200): void
{
    http_response_code($code);
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    exit;
}

function json_error(string $msg, int $code = 400): void
{
    json_response(['success' => false, 'error' => $msg], $code);
}

function json_ok($data): void
{
    json_response(['success' => true, 'data' => $data]);
}

function body_json(): array
{
    $raw = file_get_contents('php://input') ?: '';
    $j = json_decode($raw, true);
    return is_array($j) ? $j : [];
}

/** Auth đơn giản dựa trên personal_access_tokens */
function current_user_id(): ?int
{
    $hdr = $_SERVER['HTTP_AUTHORIZATION'] ?? '';
    if (!preg_match('/^Bearer\s+(.+)$/i', $hdr, $m)) return null;
    $row = DB::one(
        "SELECT tokenable_id FROM personal_access_tokens WHERE token = ? LIMIT 1",
        [hash('sha256', $m[1])]
    );
    return $row ? (int)$row['tokenable_id'] : null;
}

function require_auth(): int
{
    $id = current_user_id();
    if ($id === null) json_error('Unauthorized', 401);
    return $id;
}

/** Gọi NLP service */
function nlp_post(string $path, array $payload): array
{
    $cfg = require __DIR__ . '/../config/config.php';
    $url = rtrim($cfg['nlp']['url'], '/') . $path;

    $ch = curl_init($url);
    curl_setopt_array($ch, [
        CURLOPT_POST           => true,
        CURLOPT_POSTFIELDS     => json_encode($payload, JSON_UNESCAPED_UNICODE),
        CURLOPT_HTTPHEADER     => ['Content-Type: application/json'],
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_TIMEOUT        => $cfg['nlp']['timeout'],
    ]);
    $body = curl_exec($ch);
    $code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $err  = curl_error($ch);
    curl_close($ch);

    if ($body === false) throw new RuntimeException("NLP connect error: {$err}");
    if ($code >= 400) throw new RuntimeException("NLP HTTP {$code}: {$body}");

    $arr = json_decode($body, true);
    if (!is_array($arr)) throw new RuntimeException("NLP bad json: {$body}");
    return $arr;
}