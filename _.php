<?php

// Full Credit goes to Santiago Donoso for creating this _db function
// https://github.com/santiagodonoso
function _db(){
	try{
    $user_name = "root";
    $user_password = "";
	  $db_connection = "mysql:host=localhost; dbname=company; charset=utf8mb4";
	
	  $db_options = array(
		PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
		PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
	  );
	  return new PDO( $db_connection, $user_name, $user_password, $db_options );
	}catch( PDOException $e){
	  throw new Exception('ups... system under maintainance', 500);
	  exit();
	}	
}

define('USER_NAME_MIN', 2);
define('USER_NAME_MAX', 20);
function _validate_user_name(){

  $error = 'user_name min '.USER_NAME_MIN.' max '.USER_NAME_MAX;

  if(!isset($_POST['user_name'])){ 
    throw new Exception($error, 400); 
  }
  $_POST['user_name'] = trim($_POST['user_name']);

  if( strlen($_POST['user_name']) < USER_NAME_MIN ){
    throw new Exception($error, 400);
  }

  if( strlen($_POST['user_name']) > USER_NAME_MAX ){
    throw new Exception($error, 400);
  }
}

define('USER_LAST_NAME_MIN', 2);
define('USER_LAST_NAME_MAX', 20);
function _validate_user_last_name(){

  $error = 'user_last_name min '.USER_LAST_NAME_MIN.' max '.USER_LAST_NAME_MAX;

  if(!isset($_POST['user_last_name'])){ 
    throw new Exception($error, 400); 
  }
  $_POST['user_last_name'] = trim($_POST['user_last_name']);

  if( strlen($_POST['user_last_name']) < USER_LAST_NAME_MIN ){
    throw new Exception($error, 400);
  }

  if( strlen($_POST['user_last_name']) > USER_LAST_NAME_MAX ){
    throw new Exception($error, 400);
  }
}

define('USER_USERNAME_MIN', 1);
define('USER_USERNAME_MAX', 25);
function _validate_user_username(){
  $error = 'user_username invalid';
  if(!isset($_POST['user_username'])){ 
    throw new Exception($error, 400); 
  }
  $_POST['user_username'] = trim($_POST['user_username']); 
  if( strlen($_POST['user_username']) < USER_USERNAME_MIN ){
    throw new Exception($error, 400);
  }

  if( strlen($_POST['user_username']) > USER_USERNAME_MAX ){
    throw new Exception($error, 400);
  }
}

function _validate_user_email(){
  $error = 'user_email invalid';
  if(!isset($_POST['user_email'])){ 
    throw new Exception($error, 400); 
  }
  $_POST['user_email'] = trim($_POST['user_email']); 
  if( ! filter_var($_POST['user_email'], FILTER_VALIDATE_EMAIL) ){
    throw new Exception($error, 400); 
  }
}

define('USER_ADDRESS_MIN', 2);
define('USER_ADDRESS_MAX', 255);
function _validate_user_address(){
  
  $error = 'user_address min '.USER_ADDRESS_MIN.' max '.USER_ADDRESS_MAX;

  if(!isset($_POST['user_address'])){ 
    throw new Exception($error, 400); 
  }
  $_POST['user_address'] = trim($_POST['user_address']);

  if( strlen($_POST['user_address']) < USER_ADDRESS_MIN ){
    throw new Exception($error, 400);
  }

  if( strlen($_POST['user_address']) > USER_ADDRESS_MAX ){
    throw new Exception($error, 400);
  }
}

define('USER_ZIP_CODE_MIN', 2);
define('USER_ZIP_CODE_MAX', 10);
function _validate_user_zip_code(){
  
  $error = 'user_zip_code min '.USER_ZIP_CODE_MIN.' max '.USER_ZIP_CODE_MAX;

  if(!isset($_POST['user_zip_code'])){ 
    throw new Exception($error, 400); 
  }
  $_POST['user_zip_code'] = trim($_POST['user_zip_code']);

  if( strlen((string)$_POST['user_zip_code']) < USER_ZIP_CODE_MIN ){
    throw new Exception($error, 400);
  }

  if( strlen((string)$_POST['user_zip_code']) > USER_ZIP_CODE_MAX ){
    throw new Exception($error, 400);
  }
}

define('USER_CITY_MIN', 2);
define('USER_CITY_MAX', 50);
function _validate_user_city(){
  
  $error = 'user_city min '.USER_CITY_MIN.' max '.USER_CITY_MAX;

  if(!isset($_POST['user_city'])){ 
    throw new Exception($error, 400); 
  }
  $_POST['user_city'] = trim($_POST['user_city']);

  if( strlen($_POST['user_city']) < USER_CITY_MIN ){
    throw new Exception($error, 400);
  }

  if( strlen($_POST['user_city']) > USER_CITY_MAX ){
    throw new Exception($error, 400);
  }
}

define('USER_PASSWORD_MIN', 6);
define('USER_PASSWORD_MAX', 50);
function _validate_user_password(){

  $error = 'user_password min '.USER_PASSWORD_MIN.' max '.USER_PASSWORD_MAX;

  if(!isset($_POST['user_password'])){ 
    throw new Exception($error, 400); 
  }
  $_POST['user_password'] = trim($_POST['user_password']);

  if( strlen($_POST['user_password']) < USER_PASSWORD_MIN ){
    throw new Exception($error, 400);
  }

  if( strlen($_POST['user_password']) > USER_PASSWORD_MAX ){
    throw new Exception($error, 400);
  }
}

function _validate_user_confirm_password(){
  $error = 'user_confirm_password must match the user_password';
  if(!isset($_POST['user_confirm_password'])){ 
    throw new Exception($error, 400); 
  }
  $_POST['user_confirm_password'] = trim($_POST['user_confirm_password']);
  if( $_POST['user_password'] != $_POST['user_confirm_password']){
    throw new Exception($error, 400); 
  }
}

function _is_logged_in(){
  if(isset($_SESSION['user'])){
    header('Location: /');
  }
}

function _is_blocked(){
  if(isset($_SESSION['user'])){
    if($_SESSION['user']['user_is_blocked'] === 1){
      header('Location: blocked');
      die();
    }
  }
}

function _is_admin(){
  if($_SESSION['user']['user_role_fk'] !== 3){
    header('Location: /');
    die();
  };
}

function _prevent_XSS($text){
  echo htmlspecialchars($text);
}





