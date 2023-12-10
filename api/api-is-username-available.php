<?php

header('Content-Type: application/json');
require_once __DIR__.'/../_.php';
try{
    _validate_user_username();

    $user_username = $_POST['user_username'];

    $db = _db();
    $q = $db->prepare('SELECT * FROM users WHERE user_username = :user_username');
    $q->bindParam(':user_username', $user_username);
    $q->execute();

    $username = $q->fetch();

    if($username){
        http_response_code(400);
        echo json_encode(["info"=>"username is already in use"]);
    } else {
        echo json_encode(["info"=>"username is available"]);
    }
    
}catch(Exception $e){
        $status_code = !ctype_digit($e->getCode()) ? 500 : $e->getCode();
        $message = strlen($e->getMessage()) == 0 ? 'error - '.$e->getLine() : $e->getMessage();
        http_response_code($status_code);
        echo json_encode(['info'=>$message]);
}