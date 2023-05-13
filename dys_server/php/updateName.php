<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("databaseConn.php");
$name = $_POST['name'];
$id = $_POST['id'];
$sqlupdateuser = "UPDATE `tbl_registration` SET `name`='$name' WHERE user_id = '$id'";

if ($conn->query($sqlupdateuser) === TRUE) {
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