<?php
ob_start();
session_start();
require_once __DIR__.'/../_.php';

ob_end_flush();
try {
    $data = json_decode(file_get_contents('php://input'), true);

    if (empty($data['user_id'])) {
        throw new Exception('User ID not provided.', 400);
    }

    $user_id = $data['user_id'];

    //Extra security to prevent a user from deleting another user by changing html inspect values
    if((int)$_SESSION['user']['user_id'] === (int)$user_id){
        var_dump($user_id);
        var_dump($_SESSION['user']['user_id']);

        $db = _db();
        $q = $db->prepare('DELETE FROM users WHERE user_id = :user_id');
        $q->bindParam(':user_id', $user_id);
        $q->execute();

        echo json_encode(["info" => "User Deleted by user [id: $user_id]"]);
    } else {
        echo json_encode(["info" => "User ID did not match Session ID"]);
    }

} catch (Exception $e) {
    $status_code = !ctype_digit($e->getCode()) ? 500 : $e->getCode();
    $message = strlen($e->getMessage()) == 0 ? 'error - '.$e->getLine() : $e->getMessage();

    http_response_code($status_code);
    echo json_encode(['error' => $message]);
}
