<?php

require_once __DIR__ . '/../_.php';
require_once __DIR__ . '/Faker/src/autoload.php';

// use the factory to create a Faker\Generator instance
$faker = Faker\Factory::create();

$q = 'INSERT INTO products 
VALUES (null,"Thomas the Tank Engine",250,1),(null,"Banana",4,2),(null,"Frozen Chicken",30,3),(null,"Monster Energy",12,4)';

echo 'products seeded, ';
$db = _db();
$sql = $db->prepare($q);
$sql->execute();