<?php

require_once __DIR__ . '/../_.php';

$q = 'DELETE FROM orders';

$db = _db();
$sql = $db->prepare($q);
$sql->execute();

$q = 'ALTER TABLE orders AUTO_INCREMENT = 1';
$sql = $db->prepare($q);
$sql->execute();

echo 'orders deleted, ';