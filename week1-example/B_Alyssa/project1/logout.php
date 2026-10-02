<?php
// logout.php - signs the demo user out
// Owner: Alyssa
// Clearing the session also clears the Not Tonight list. Nothing in MySQL changes.

session_start();
$_SESSION = [];
session_destroy();

header("Location: index.php?signed_out=1");
exit;
?>
