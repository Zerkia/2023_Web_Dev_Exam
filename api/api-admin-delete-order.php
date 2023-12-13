<?php

header('Content-Type: application/json');
require_once __DIR__.'/../_.php';
try{

    $order_id = $_POST['order_id'];

    $db = _db();
    $q = $db->prepare('DELETE FROM orders WHERE order_id = :order_id');
    $q->bindParam(':order_id', $order_id);
    $q->execute();

    echo json_encode(["info"=>"Order Deleted by admin [id: $order_id]"]);

}catch(Exception $e){
        $status_code = !ctype_digit($e->getCode()) ? 500 : $e->getCode();
        $message = strlen($e->getMessage()) == 0 ? 'error - '.$e->getLine() : $e->getMessage();
        http_response_code($status_code);
        echo json_encode(['info'=>$message]);
}