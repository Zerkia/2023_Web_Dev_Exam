<?php

require_once __DIR__ . '/../_.php';

$q = 'DELETE FROM products';

$db = _db();
$sql = $db->prepare($q);
$sql->execute();

$q = 'ALTER TABLE products AUTO_INCREMENT = 1';
$sql = $db->prepare($q);
$sql->execute();

echo 'products deleted, ';