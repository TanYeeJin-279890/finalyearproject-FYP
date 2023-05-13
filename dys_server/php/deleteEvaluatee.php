<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}
include_once("databaseConn.php");
$id = $_POST['id'];
$name = $_POST['name'];
$age = $_POST['age'];

$sqldelete = "DELETE FROM tbl_evaluatee WHERE user_id = '$id' AND evaluatee_name = '$name' AND age = '$age'";
if ($conn->query($sqldelete) === TRUE) {
    $response = array('status' => 'success', 'data' => null);
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>