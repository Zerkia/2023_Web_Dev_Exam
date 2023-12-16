<?php

require_once __DIR__ . '/../_.php';
require_once __DIR__ . '/Faker/src/autoload.php';

// use the factory to create a Faker\Generator instance
$faker = Faker\Factory::create();

$q = 'INSERT INTO status 
VALUES (null,"In Transit"),(null,"Shipped"),(null,"Delivered"),(null,"Cancelled")';

echo 'status seeded, ';
$db = _db();
$sql = $db->prepare($q);
$sql->execute();