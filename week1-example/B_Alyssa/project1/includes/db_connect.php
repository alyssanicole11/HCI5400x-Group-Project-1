<?php
// db_connect.php - connects to MySQL (same steps as the class examples)
// Owner: Alyssa
// Pages that need the database include this file and then use $conn.
// Every page lives in project1/, so the path to config.php starts there.

if (!file_exists("includes/config.php")) {
    die("Missing includes/config.php. Copy includes/config.example.php to config.php and fill in your login.");
}
include "includes/config.php";   // gives $servername, $username, $password, $dbname

// Newer PHP versions stop the page with a fatal error when a query fails.
// This line turns that off, so the class checks below (if (!$conn), if ($result))
// work and each page can show its own friendly message.
mysqli_report(MYSQLI_REPORT_OFF);

// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);

// Check to make sure connection is opened, if not stop code
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

// So titles with accents (Amélie, Pokémon) show correctly
mysqli_set_charset($conn, "utf8mb4");
?>
