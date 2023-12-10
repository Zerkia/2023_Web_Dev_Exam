<?php

header('Content-Type: application/json');
require_once __DIR__.'/../_.php';
try{

    $user_id = $_POST['user_id'];

    $db = _db();
    $q = $db->prepare('DELETE FROM users WHERE user_id = :user_id');
    $q->bindParam(':user_id', $user_id);
    $q->execute();

    echo json_encode(["info"=>"User Deleted by admin [id: $user_id]"]);

}catch(Exception $e){
        $status_code = !ctype_digit($e->getCode()) ? 500 : $e->getCode();
        $message = strlen($e->getMessage()) == 0 ? 'error - '.$e->getLine() : $e->getMessage();
        http_response_code($status_code);
        echo json_encode(['info'=>$message]);
}