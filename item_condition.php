<?php
$con = mysqli_connect("db.luddy.indiana.edu", "i308s24_rohtyagi", "my+sql=i308s24_rohtyagi", "i308s24_rohtyagi");


echo "<form method='post'>";
echo "<select name='item_condition'>";
echo "<option>Select Item Condition</option>";

$query = "SELECT DISTINCT item_condition FROM joe_item ORDER BY item_condition";
$result = mysqli_query($con, $query);
while ($row = mysqli_fetch_assoc($result)) {
    echo "<option value='" . $row['item_condition'] . "'>" . $row['item_condition'] . "</option>";
}
echo "</select>";
echo "<input type='submit' value='Search'>";
echo "</form><br>";

if (isset($_POST['item_condition']) && $_POST['item_condition'] != "Select Item Condition") {
    $item_condition = mysqli_real_escape_string($con, $_POST['item_condition']);

    $sql = "SELECT 
                i.name AS Item_Name,
                (SELECT COUNT(*) FROM joe_rent_transaction rt WHERE rt.item_id = i.id) AS Rental_Count,
                (SELECT COUNT(*) FROM joe_purchase_transaction pt WHERE pt.item_id = i.id) AS Purchase_Count
            FROM joe_item as i
            WHERE i.item_condition = '$item_condition'
            ORDER BY i.name";

    $result = mysqli_query($con, $sql);
    $num_rows = mysqli_num_rows($result);

    if ($num_rows > 0) {
        echo "<table border='1'>";
        echo "<tr>
                <th>Item Name</th>
                <th>Rental Count</th>
                <th>Purchase Count</th>
            </tr>";
        while ($row = mysqli_fetch_assoc($result)) {
            echo "<tr>
                    <td>" . $row["Item_Name"] . "</td>
                    <td>" . $row["Rental_Count"] . "</td>
                    <td>" . $row["Purchase_Count"] . "</td>
                </tr>";
        }
        echo "</table>";
    } else {
        echo "No data found for selected condition.";
    }
}

echo "<br><br>";
mysqli_close($con);
?>
