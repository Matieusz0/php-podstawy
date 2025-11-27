<?php
$conn = mysqli_connect("localhost", "root", "", "baza");
if (!$conn) {
	die("Błąd połączenia: " . mysqli_error($conn));
}

$czas = $_POST["czasInput"]

$sql = "INSERT INTO czas_zaladowania (czas) VALUES ("$czas")";
mysqli_query($conn, $sql);

echo "Dodano czas do bazy";

mysqli_close($conn);

?>
