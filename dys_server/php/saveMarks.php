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
$verbal = $_POST['Verbal_marks'];
$social = $_POST['Social_marks'];
$narrative = $_POST['Narrative_marks'];
$spatial = $_POST['Spatial_marks'];
$kinesthethic = $_POST['Kinesthethic_marks'];
$visual = $_POST['Visual_marks'];
$mathsci = $_POST['MathSci_marks'];
$musical = $_POST['Musical_marks'];

$sqlsaveMarks = "UPDATE `tbl_evaluatee` SET `Verbal_marks`='$verbal',`Social_marks`='$social',
`Narrative_marks`='$narrative',`Spatial_marks`='$spatial',`Kinesthetic_marks`='$kinesthethic',
`Visual_marks`='$visual',`MathSci_marks`='$mathsci',`Musical_marks`='$musical' 
WHERE user_id = '$id' AND evaluatee_name = '$name' AND age = '$age'";

if ($conn->query($sqlsaveMarks) === TRUE) {
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