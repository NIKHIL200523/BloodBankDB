<?php
include 'db.php';

$sql = "SELECT R.BankID, B.Name AS BloodBankName, R.HospitalID, H.Name AS HospitalName, R.Availability
        FROM Requests R
        JOIN BloodBank B ON R.BankID = B.BankID
        JOIN Hospital H ON R.HospitalID = H.HospitalID";

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    echo "<h2>Requests Status</h2><table border='1'>";
    echo "<tr><th>Blood Bank</th><th>Hospital</th><th>Status</th></tr>";

    while ($row = $result->fetch_assoc()) {
        echo "<tr>
                <td>{$row['BloodBankName']}</td>
                <td>{$row['HospitalName']}</td>
                <td>{$row['Availability']}</td>
              </tr>";
    }

    echo "</table>";
} else {
    echo "No requests found.";
}
?>
