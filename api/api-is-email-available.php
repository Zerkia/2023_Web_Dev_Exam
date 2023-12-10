<?php

header('Content-Type: application/json');
require_once __DIR__.'/../_.php';
try{
    _validate_user_email();

    $user_email = $_POST['user_email'];

    $db = _db();
    $q = $db->prepare('SELECT * FROM users WHERE user_email = :user_email');
    $q->bindParam(':user_email', $user_email);
    $q->execute();

    $email = $q->fetch();

    if($email){
        http_response_code(400);
        echo json_encode(["info"=>"Email is already in use"]);
    } else {
        echo json_encode(["info"=>"Email is available"]);
    }
    
}catch(Exception $e){
        $status_code = !ctype_digit($e->getCode()) ? 500 : $e->getCode();
        $message = strlen($e->getMessage()) == 0 ? 'error - '.$e->getLine() : $e->getMessage();
        http_response_code($status_code);
        echo json_encode(['info'=>$message]);
}