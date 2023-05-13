<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("databaseConn.php");
$userid = $_POST['user_id'];
$sqlevaluatee = "SELECT * FROM tbl_evaluatee WHERE user_id = '$userid'";
$result = $conn->query($sqlevaluatee);
$number_of_result = $result->num_rows;

if ($result->num_rows > 0) {
    $evaluatee["evaluatee"] = array();
    while ($row = $result->fetch_assoc()) {
        $evaluateelist = array();
        $evaluateelist['evaluatee_id'] = $row['evaluatee_id'];
        $evaluateelist['evaluatee_name'] = $row['evaluatee_name'];
        $evaluateelist['age'] = $row['age'];
        $evaluateelist['Verbal_marks'] = $row['Verbal_marks'];
        $evaluateelist['Social_marks'] = $row['Social_marks'];
        $evaluateelist['Narrative_marks'] = $row['Narrative_marks'];
        $evaluateelist['Spatial_marks'] = $row['Spatial_marks'];
        $evaluateelist['Kinesthetic_marks'] = $row['Kinesthetic_marks'];
        $evaluateelist['Visual_marks'] = $row['Visual_marks'];
        $evaluateelist['MathSci_marks'] = $row['MathSci_marks'];
        $evaluateelist['Musical_marks'] = $row['Musical_marks'];
        array_push($evaluatee["evaluatee"],$evaluateelist);
    }
    $response = array('status' => 'success', 'data' => $evaluatee);
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