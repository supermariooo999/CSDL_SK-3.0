<?php
declare(strict_types=1);

final class DB
{
    private static ?PDO $pdo = null;

    public static function conn(): PDO
    {
        if (self::$pdo instanceof PDO) return self::$pdo;

        $cfg = require __DIR__ . '/../config/config.php';
        $c = $cfg['db'];
        $dsn = "mysql:host={$c['host']};port={$c['port']};dbname={$c['name']};charset={$c['charset']}";

        self::$pdo = new PDO($dsn, $c['user'], $c['pass'], [
            PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES   => false,
        ]);
        return self::$pdo;
    }

    public static function one(string $sql, array $p = []): ?array
    {
        $st = self::conn()->prepare($sql); $st->execute($p);
        $r = $st->fetch(); return $r === false ? null : $r;
    }

    public static function all(string $sql, array $p = []): array
    {
        $st = self::conn()->prepare($sql); $st->execute($p);
        return $st->fetchAll();
    }

    public static function exec(string $sql, array $p = []): int
    {
        $st = self::conn()->prepare($sql); $st->execute($p);
        return $st->rowCount();
    }

    public static function lastId(): string
    {
        return self::conn()->lastInsertId();
    }
}