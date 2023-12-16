<?php

require_once __DIR__.'/../_.php';
require_once __DIR__.'/Faker/src/autoload.php';

// use the factory to create a Faker\Generator instance
$faker = Faker\Factory::create();

  $q = 'INSERT INTO users VALUES ';
  $values = '';
  $created_at = time();
  $custom_password = password_hash('password', PASSWORD_DEFAULT);
  for($i = 0; $i < 10; $i++){
    // For the sake of ease, every password is "password"
    // $password = password_hash($faker->password, PASSWORD_DEFAULT);
    $role = rand(1,2);
    $blocked = rand(0,1);
    
    $values .= "(null,
                '$faker->firstName',
                '$faker->lastName',
                '$faker->username',
                '$faker->email',
                '$faker->streetAddress',
                '$faker->postcode',
                '$faker->city',
                '$custom_password',
                $role,
                $created_at,
                0,
                $blocked
              ),"; 
  }
  // Custom, non random users, one with each role to be able to log in to.
  $values .= "(null,
                'Admin',
                'Admin',
                'Admin',
                'admin@admin.com',
                'Admin Street 12',
                '1234',
                'Admin City',
                '$custom_password',
                3,
                $created_at,
                0,
                0
              ),
              (null,
                'Partner',
                'Partner',
                'Partner',
                'partner@partner.com',
                'Partner Street 12',
                '1234',
                'Partner City',
                '$custom_password',
                2,
                $created_at,
                0,
                0
              ),
              (null,
                'Customer',
                'Customer',
                'Customer',
                'customer@customer.com',
                'Customer Street 12',
                '1234',
                'Customer City',
                '$custom_password',
                1,
                $created_at,
                0,
                0
              )"; 

  $values = rtrim($values, ",");
  $q .= $values;

  echo 'users seeded, ';
  
$db = _db();
$sql = $db->prepare($q);
$sql->execute();