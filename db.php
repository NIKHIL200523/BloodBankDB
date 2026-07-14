<?php
$servername = "localhost";
$username = "root";
$password = "Rakhack123";
$dbname = "BloodBankDB";

$conn = new mysqli('localhost', 'root', 'Rakhack123', 'BloodBankDB');


if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
