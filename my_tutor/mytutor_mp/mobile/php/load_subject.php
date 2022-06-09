<?php
include_once("dbconnect.php");
$sqlloadsbj = "SELECT * FROM tbl_subjects";
$result = $conn->query($sqlloadsbj);
if ($result->num_rows > 0) {
    $response["subjects"] = array();
while ($row = $result->fetch_assoc()) {
    $sublist = array();
    $sublist['subid'] = $row['subid'];
    $sublist['subname'] = $row['subname'];
    $sublist['subdesc'] = $row['subdesc'];
    $sublist['subprice'] = $row['prprice'];
    $sublist['tutorid'] = $row['tutorid'];
    $sublist['subsession'] = $row['subsession'];
    $sublist['subrate'] = $row['subrate'];
array_push($response["subjects"],$sublist);
}
echo json_encode($response);
}else{
echo "nodata";
}
