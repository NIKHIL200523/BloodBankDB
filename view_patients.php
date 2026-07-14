<?php
include 'db.php';

$result = $conn->query("SELECT * FROM Patients");
echo "<h2>Patient List</h2>";
echo "<table border='1'>
<tr>
    <th>Patient ID</th>
    <th>Name</th>
    <th>Age</th>
    <th>Blood Type</th>
    <th>Contact</th>
</tr>";

while($row = $result->fetch_assoc()) {
    echo "<tr>
        <td>{$row['PatientID']}</td>
        <td>{$row['Name']}</td>
        <td>{$row['Age']}</td>
        <td>{$row['BloodType']}</td>
        <td>{$row['Contact']}</td>
    </tr>";
}
echo "</table>";
?>
