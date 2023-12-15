<?php
require_once __DIR__.'/../_.php';
try{

  _validate_user_name();
  _validate_user_last_name();
  _validate_user_address();
  _validate_user_zip_code();
  _validate_user_city();

  $db = _db();
  $q = $db->prepare('
    UPDATE users 
    SET
      user_name = :user_name,
      user_last_name = :user_last_name,
      user_address = :user_address,
      user_zip_code = :user_zip_code,
      user_city = :user_city, 
      user_updated_at = :user_updated_at
    WHERE user_id = :user_id'
  );
  $q->bindValue(':user_id', $_POST['user_id']);
  $q->bindValue(':user_name', $_POST['user_name']);
  $q->bindValue(':user_last_name', $_POST['user_last_name']);
  $q->bindValue(':user_address', $_POST['user_address']);
  $q->bindValue(':user_zip_code', $_POST['user_zip_code']);
  $q->bindValue(':user_city', $_POST['user_city']);
  $q->bindValue(':user_updated_at', time());

  $q->execute();
  $counter = $q->rowCount();
  if( $counter != 1 ){
    throw new Exception('ups...', 500);
  }

  session_start();
  $_SESSION['user']['user_name'] = $_POST['user_name'];
  $_SESSION['user']['user_last_name'] = $_POST['user_last_name'];
  $_SESSION['user']['user_address'] = $_POST['user_address'];
  $_SESSION['user']['user_zip_code'] = $_POST['user_zip_code'];
  $_SESSION['user']['user_city'] = $_POST['user_city'];

  // echo json_encode(['user_id' => $_POST['user_id'], 'message' => 'Update successful']);
  echo json_encode($_SESSION['user']['user_name']);
}catch(Exception $e){
  try{
    if( ! $e->getCode() || ! $e->getMessage()){ throw new Exception(); }
    http_response_code($e->getCode());
    echo json_encode(['info'=>$e->getMessage()]);
  }catch(Exception $ex){
    http_response_code(500);
    echo json_encode($ex); 
  }
}