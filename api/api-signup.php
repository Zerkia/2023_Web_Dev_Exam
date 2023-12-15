
<?php

require_once __DIR__.'/../_.php';

try{

  _validate_user_name();
  _validate_user_last_name();
  _validate_user_username();
  _validate_user_email();
  _validate_user_address();
  _validate_user_zip_code();
  _validate_user_city();
  _validate_user_password();
  _validate_user_confirm_password();

  $db = _db();
  $q = $db->prepare('
    INSERT INTO users 
    (user_id, user_name, user_last_name, user_username, user_email, user_address, user_zip_code, user_city, user_password, user_role_fk, user_created_at, user_updated_at, user_deleted_at, user_is_blocked)
    VALUES (
      :user_id, 
      :user_name, 
      :user_last_name,
      :user_username, 
      :user_email, 
      :user_address,
      :user_zip_code,
      :user_city,
      :user_password, 
      :user_role_fk, 
      :user_created_at, 
      :user_updated_at,
      :user_deleted_at,
      :user_is_blocked)'
  );
  $q->bindValue(':user_id', null);
  $q->bindValue(':user_name', $_POST['user_name']);
  $q->bindValue(':user_last_name', $_POST['user_last_name']);
  $q->bindValue(':user_username', $_POST['user_username']);
  $q->bindValue(':user_email', $_POST['user_email']);
  $q->bindValue(':user_address', $_POST['user_address']);
  $q->bindValue(':user_zip_code', $_POST['user_zip_code']);
  $q->bindValue(':user_city', $_POST['user_city']);
  $q->bindValue(':user_password', password_hash($_POST['user_password'], PASSWORD_DEFAULT));              
  $q->bindValue(':user_role_fk', '1');
  $q->bindValue(':user_created_at', time());
  $q->bindValue(':user_updated_at', 0);
  $q->bindValue(':user_deleted_at', 0);
  $q->bindValue(':user_is_blocked', 0);

  $q->execute();
  $counter = $q->rowCount();
  if( $counter != 1 ){
    throw new Exception('ups...', 500);
  }

  echo json_encode(['user_id' => $db->lastInsertId()]);

}catch(Exception $e){
  try{
    if( ! ctype_digit($e->getCode())){
      throw new Exception();
    }
    http_response_code($e->getCode());
    echo json_encode(['info'=>$e->getMessage()]);
  }catch(Exception $ex){
    // echo $ex;
    http_response_code(500);
    echo json_encode(['info'=>json_encode($ex)]);    
  }

}




