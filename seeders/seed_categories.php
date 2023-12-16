<?php

require_once __DIR__ . '/../_.php';
require_once __DIR__ . '/Faker/src/autoload.php';

// use the factory to create a Faker\Generator instance
$faker = Faker\Factory::create();

$q = 'INSERT INTO categories 
VALUES (null,"Toys"),(null,"Fruits & Vegetables"),(null,"Frozen"),(null,"Drinks")';

echo 'categories seeded, ';
$db = _db();
$sql = $db->prepare($q);
$sql->execute();