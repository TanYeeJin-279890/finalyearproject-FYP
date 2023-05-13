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

$sqlsave = "INSERT INTO `tbl_evaluatee`(`user_id`, `evaluatee_name`, `age`) VALUES ('$id','$name','$age')";
try {
	if ($conn->query($sqlsave) === TRUE) {
		$response = array('status' => 'success', 'data' => null);
		sendJsonResponse($response);
	}else{
		$response = array('status' => 'failed', 'data' => null);
		sendJsonResponse($response);
	}
}
catch(Exception $e) {
  $response = array('status' => 'failed', 'data' => null);
  sendJsonResponse($response);
}
$conn->close();

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

?>