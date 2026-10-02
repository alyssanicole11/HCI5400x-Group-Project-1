<?php
// loginProcess.php - remembers which demo user was picked
// Owner: Alyssa
// Class topics: $_POST, SELECT. New: sessions (session_start, $_SESSION)
// Receives: user_id (POST) from index.php

include "includes/db_connect.php";
session_start();

// Get the submitted user_id using $_POST (numbers from forms always get (int))
$userId = 0;
if (isset($_POST['user_id'])) {
    $userId = (int) $_POST['user_id'];
}

// Check that this user exists
$sql = "SELECT user_id, display_name FROM users WHERE user_id = $userId";
$result = mysqli_query($conn, $sql);

if ($result && mysqli_num_rows($result) == 1) {
    $row = mysqli_fetch_assoc($result);

    // Save who is watching in the session
    $_SESSION['user_id'] = (int) $row['user_id'];
    $_SESSION['display_name'] = $row['display_name'];

    // A new demo user starts with an empty Not Tonight list
    unset($_SESSION['not_tonight']);

    mysqli_close($conn);
    header("Location: tonight.php");
    exit;
}

// Unknown user (or a database problem): back to the login page with a message
mysqli_close($conn);
header("Location: index.php?error=1");
exit;
?>
