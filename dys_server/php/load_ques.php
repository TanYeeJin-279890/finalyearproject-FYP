<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("databaseConn.php");
$category = $_POST['category'];
$sqlquestion = "SELECT * FROM tbl_question WHERE CATEGORY = '$category'";
$result = $conn->query($sqlquestion);
$number_of_result = $result->num_rows;

if ($result->num_rows > 0) {
    $question["question"] = array();
    while ($row = $result->fetch_assoc()) {
        $questionlist = array();
        $questionlist['ID'] = $row['ID'];
        $questionlist['SECTION'] = $row['SECTION'];
        $questionlist['TITLE'] = $row['TITLE'];
        array_push($question["question"],$questionlist);
    }
    $response = array('status' => 'success', 'data' => $question);
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