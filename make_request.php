<?php
include 'db.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $bankID = $_POST['bankID'];
    $hospitalID = $_POST['hospitalID'];

    $sql = "INSERT INTO Requests (BankID, HospitalID) VALUES ('$bankID', '$hospitalID')";

    if ($conn->query($sql) === TRUE) {
        echo "Request made successfully. Status is Pending.";
    } else {
        echo "Error: " . $conn->error;
    }
}
?>

<form method="POST">
    <label for="bankID">Select Blood Bank:</label>
    <input type="number" name="bankID" required><br>

    <label for="hospitalID">Enter Your Hospital ID:</label>
    <input type="number" name="hospitalID" required><br>

    <button type="submit">Make Request</button>
</form>
