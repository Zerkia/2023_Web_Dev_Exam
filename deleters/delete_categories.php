<?php

require_once __DIR__ . '/../_.php';

$q = 'DELETE FROM categories';

$db = _db();
$sql = $db->prepare($q);
$sql->execute();

$q = 'ALTER TABLE categories AUTO_INCREMENT = 1';
$sql = $db->prepare($q);
$sql->execute();

echo 'categories deleted, ';