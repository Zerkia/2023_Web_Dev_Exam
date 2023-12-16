<?php

require_once __DIR__ . '/../_.php';
require_once __DIR__ . '/Faker/src/autoload.php';

// use the factory to create a Faker\Generator instance
$faker = Faker\Factory::create();

$q = 'INSERT INTO orders VALUES ';

$values = '';

for($i = 0; $i < 10; $i++){
    $user_id = rand(1,10);
    $product_id = rand(1,4);
    $amount_paid = rand(0,1000);
    $status = rand(1,4);
    $values .= "(null,
                '$user_id',
                '$product_id',
                '$amount_paid',
                '$status'),";
}

$values = rtrim($values, ",");
$q .= $values;

echo 'orders seeded';
$db = _db();
$sql = $db->prepare($q);
$sql->execute();