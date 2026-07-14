<?php
include 'db.php';

$result = $conn->query("SELECT * FROM Donor");
echo "<h2>Donor List</h2>";
echo "<table border='1'>
<tr>
    <th>Donor ID</th>
    <th>Name</th>
    <th>Address</th>
    <th>Age</th>
    <th>Blood Type</th>
    <th>Last Donation</th>
    <th>Contact</th>
</tr>";

while($row = $result->fetch_assoc()) {
    echo "<tr>
        <td>{$row['DonorID']}</td>
        <td>{$row['Name']}</td>
        <td>{$row['Address']}</td>
        <td>{$row['Age']}</td>
        <td>{$row['BloodType']}</td>
        <td>{$row['LastDonationDate']}</td>
        <td>{$row['Contact']}</td>
    </tr>";
}
echo "</table>";
?>
