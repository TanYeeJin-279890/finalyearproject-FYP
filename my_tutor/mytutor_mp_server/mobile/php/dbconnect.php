<?php
$servername = "localhost";
$username = "moneymon_279890_mytutor_mp";
$password = "#ZW.7_y2YzE]";
$dbname = "moneymon_279890_mytutor_mp";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>