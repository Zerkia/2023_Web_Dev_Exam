<?php

require_once __DIR__ . '/../_.php';

$q = 'DELETE FROM users';

$db = _db();
$sql = $db->prepare($q);
$sql->execute();

$q = 'ALTER TABLE users AUTO_INCREMENT = 1';
$sql = $db->prepare($q);
$sql->execute();

echo 'users deleted, ';