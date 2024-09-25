<?php
/* Step 1 */

$con = mysqli_connect("db.luddy.indiana.edu", "i308s24_rohtyagi", "my+sql=i308s24_rohtyagi", "i308s24_rohtyagi");
// Check connection
if (!$con) {
  die("Failed to connect to MySQL: " . mysqli_connect_error());
} else {
  echo "Established Database Connection";
}

$x = mysqli_real_escape_string($con, $_POST['Customer_Full_Name']);

$sql = "";

$result = mysqli_query($con, $sql);
$num_rows = mysqli_num_rows($result);
if ($num_rows > 0) {
  echo "<table>";
  echo "<tr>
                      <th></th>
                     
              </tr>";
  while ($row = mysqli_fetch_assoc($result)) {
      echo "<tr>
                      <td>" . $row[""] . "</td>
                      </tr>";
  }
  echo "</table>";
} else {
  echo "NO DATA MESSAGE";
}

echo "<br><br>";

mysqli_close($con);

?>