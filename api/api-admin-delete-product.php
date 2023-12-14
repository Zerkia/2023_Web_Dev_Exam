<?php

header('Content-Type: application/json');
require_once __DIR__.'/../_.php';
try{

    $product_id = $_POST['product_id'];

    $db = _db();
    $q = $db->prepare('DELETE FROM products WHERE product_id = :product_id');
    $q->bindParam(':product_id', $product_id);
    $q->execute();

    echo json_encode(["info"=>"Product Deleted by admin [id: $product_id]"]);

}catch(Exception $e){
        $status_code = !ctype_digit($e->getCode()) ? 500 : $e->getCode();
        $message = strlen($e->getMessage()) == 0 ? 'error - '.$e->getLine() : $e->getMessage();
        http_response_code($status_code);
        echo json_encode(['info'=>$message]);
}