<?php include 'db.php'; ?>
<!DOCTYPE html>
<html>
<head><title>Blood Banks</title></head>
<body>
<h2>Available Blood Banks</h2>
<?php
$result = $conn->query("SELECT * FROM BloodBank");
echo "<table border='1'><tr><th>ID</th><th>Name</th><th>Location</th><th>Contact</th></tr>";
while($row = $result->fetch_assoc()) {
    echo "<tr><td>{$row['BankID']}</td><td>{$row['Name']}</td>
              <td>{$row['Location']}</td><td>{$row['Contact']}</td></tr>";
}
echo "</table>";
?>
</body>
</html>
