<?php

require_once __DIR__ . '/../_.php';

$q = 'DELETE FROM status';

$db = _db();
$sql = $db->prepare($q);
$sql->execute();

$q = 'ALTER TABLE status AUTO_INCREMENT = 1';
$sql = $db->prepare($q);
$sql->execute();

echo 'status deleted, ';