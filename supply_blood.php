<?php include 'db.php'; ?>
<!DOCTYPE html>
<html>
<head><title>Supply Blood</title></head>
<body>
<h2>Supply Blood to Patient</h2>
<form method="post">
    Hospital ID: <input type="number" name="hospitalid" required><br>
    Patient ID: <input type="number" name="patientid" required><br>
    <input type="submit" name="submit" value="Supply">
</form>

<?php
if (isset($_POST['submit'])) {
    $sql = "INSERT INTO Supplies (HospitalID, PatientID)
            VALUES ({$_POST['hospitalid']}, {$_POST['patientid']})";
    if ($conn->query($sql)) {
        echo "Blood Supplied!";
    } else {
        echo "Error: " . $conn->error;
    }
}
?>
</body>
</html>
