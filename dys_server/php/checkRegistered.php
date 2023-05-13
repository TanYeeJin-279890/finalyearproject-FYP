<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("databaseConn.php");
$email = $_POST['email'];
$sqllogin = "SELECT * FROM tbl_registration WHERE useremail = '$email'";
$result = $conn->query($sqlcheck);
$numrow = $result->num_rows;

if ($numrow > 0) {
    while ($row = $result->fetch_assoc()) {
        $user = array();
        $user['id'] = $row['user_id'];
        $user['name'] = $row['name'];
        $user['email'] = $row['useremail'];
        $user['phone'] = $row['phone'];
        $user['password'] = $row['userpassword'];
        $response = array('status' => 'success', 'data' => $user);
        sendJsonResponse($response);
    }
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
