<?php
require_once __DIR__.'/../_.php';
require_once __DIR__.'/Faker/src/autoload.php';

// use the factory to create a Faker\Generator instance
$faker = Faker\Factory::create();

$db = _db();
$q = $db->prepare('SELECT user_id from users order by rand() limit 2;');
$q->execute();
$ids = $q->fetchAll(PDO::FETCH_COLUMN);

$q = 'INSERT INTO partners VALUES ';
$values = '';
$array_length = count($ids);
for ($i = 0; $i < $array_length; $i++) {
  $geo_lat = $faker->latitude($min = -90, $max = 90);
  $geo_long = $faker->longitude($min = -180, $max = 180) ;
  $index = array_rand($ids);
  $user_partner_fk = $ids[$index];
  $partner_geo = $geo_lat . ',' . $geo_long;
  unset($ids[$index]);
  $values .= "($user_partner_fk, '$partner_geo'),";
}
$values = rtrim($values, ",");
$q .= $values;

echo $q;
$db = _db();
$sql = $db->prepare($q);
$sql->execute();
