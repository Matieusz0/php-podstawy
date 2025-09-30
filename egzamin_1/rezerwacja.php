<?php
$conn = mysqli_connect("localhost", "root", "", "baza");
if (!$conn) {
	die("Błąd połączenia: " . mysqli_error($conn));
}

$data = $_POST['data'];
$osoby = $_POST['osoby'];
$telefon = $_POST['telefon'];

$sql = "INSERT INTO rezerwacje (nr_stolika, data_rez, liczba_osob, telefon) VALUES (NULL, '$data', '$osoby', '$telefon')";
mysqli_query($conn, $sql);

echo "Dodano rezerwację do bazy";

mysqli_close($conn);
?>
