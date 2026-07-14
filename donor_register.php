<?php include 'db.php'; ?>
<!DOCTYPE html>
<html>
<head><title>Register Donor</title></head>
<body>
<h2>Donor Registration</h2>
<form method="post">
    Name: <input type="text" name="name" required><br>
    Address: <input type="text" name="address"><br>
    Age: <input type="number" name="age"><br>
    Blood Type: <input type="text" name="bloodtype"><br>
    Contact: <input type="text" name="contact"><br>
    <input type="submit" name="submit" value="Register">
</form>

<?php
if (isset($_POST['submit'])) {
    $sql = "INSERT INTO Donor (Name, Address, Age, BloodType, LastDonationDate, Contact)
            VALUES ('{$_POST['name']}', '{$_POST['address']}', {$_POST['age']}, 
                    '{$_POST['bloodtype']}', CURDATE(), '{$_POST['contact']}')";
    if ($conn->query($sql)) {
        echo "Donor Registered Successfully!";
    } else {
        echo "Error: " . $conn->error;
    }
}
?>
</body>
</html>
