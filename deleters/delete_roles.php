<?php

require_once __DIR__ . '/../_.php';

$q = 'DELETE FROM roles';

$db = _db();
$sql = $db->prepare($q);
$sql->execute();

$q = 'ALTER TABLE roles AUTO_INCREMENT = 1';
$sql = $db->prepare($q);
$sql->execute();

echo 'roles deleted';