<?php
// libraryProcess.php - saves a user's status, rating, and Watch Again for one movie
// Owner: Alyssa
// Class topics: $_POST, SELECT, INSERT, UPDATE, prepared statements (Lecture 11, imageUploadMysql.php)
// Receives (POST) from discover.php and library.php:
//   title_id, status, rating, watch_again, return_to
//
// Rules from the spec:
//   - Only the fields the form sent are changed; the rest keep their saved values.
//   - "" for rating or watch_again means Unrated / Not set, saved as NULL (not 0).
//   - date_added is set once; updated_at changes on every save.

include "includes/require_login.php";   // gives $userId
include "includes/db_connect.php";      // gives $conn

// The values we allow (MySQL will not check these for us)
$allowedStatus = ["none", "interested", "watched", "not_interested"];
$allowedRating = ["", "-1", "0", "1", "2"];
$allowedWatchAgain = ["", "0", "1"];
$allowedPages = ["discover.php", "library.php"];

// Where to go afterwards. return_to may carry the page's search, like discover.php?q=love,
// so only the part before the ? has to be one of our pages.
$returnTo = "discover.php";
if (isset($_POST['return_to'])) {
    $parts = explode("?", $_POST['return_to']);
    if (in_array($parts[0], $allowedPages)) {
        $returnTo = $_POST['return_to'];
    }
}
if (strpos($returnTo, "?") === false) {
    $returnTo = $returnTo . "?";
} else {
    $returnTo = $returnTo . "&";
}

// Get the submitted title_id and check the movie exists
$titleId = 0;
if (isset($_POST['title_id'])) {
    $titleId = (int) $_POST['title_id'];
}
$result = mysqli_query($conn, "SELECT title_id FROM titles WHERE title_id = $titleId");
if (!$result || mysqli_num_rows($result) == 0) {
    header("Location: " . $returnTo . "error=movie");
    exit;
}

// Start from what is already saved for this user + movie (or the defaults for a new row)
$sql = "SELECT status, rating, watch_again FROM user_titles WHERE user_id = $userId AND title_id = $titleId";
$result = mysqli_query($conn, $sql);
$rowExists = ($result && mysqli_num_rows($result) == 1);

$status = "none";
$rating = null;
$watchAgain = null;
if ($rowExists) {
    $row = mysqli_fetch_assoc($result);
    $status = $row['status'];
    $rating = $row['rating'];
    $watchAgain = $row['watch_again'];
}

// Overwrite with the fields the form sent, after checking each one
$valid = true;

if (isset($_POST['status'])) {
    if (in_array($_POST['status'], $allowedStatus)) {
        $status = $_POST['status'];
    } else {
        $valid = false;
    }
}

if (isset($_POST['rating'])) {
    if (!in_array($_POST['rating'], $allowedRating)) {
        $valid = false;
    } elseif ($_POST['rating'] == "") {
        $rating = null;                     // Unrated
    } else {
        $rating = (int) $_POST['rating'];
    }
}

if (isset($_POST['watch_again'])) {
    if (!in_array($_POST['watch_again'], $allowedWatchAgain)) {
        $valid = false;
    } elseif ($_POST['watch_again'] == "") {
        $watchAgain = null;                 // Not set
    } else {
        $watchAgain = (int) $_POST['watch_again'];
    }
}

if (!$valid) {
    header("Location: " . $returnTo . "error=invalid#title-" . $titleId);
    exit;
}

// Save it: UPDATE the row if this user already has one for this movie, otherwise INSERT.
// The ? placeholders are filled in by mysqli_stmt_bind_param ("s" = text, "i" = number).
// A PHP null is saved as NULL.
if ($rowExists) {
    $stmt = mysqli_prepare($conn, "UPDATE user_titles SET status = ?, rating = ?, watch_again = ?, updated_at = NOW()
                                   WHERE user_id = ? AND title_id = ?");
    if ($stmt) {
        mysqli_stmt_bind_param($stmt, "siiii", $status, $rating, $watchAgain, $userId, $titleId);
    }
} else {
    $stmt = mysqli_prepare($conn, "INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at)
                                   VALUES (?, ?, ?, ?, ?, NOW(), NOW())");
    if ($stmt) {
        mysqli_stmt_bind_param($stmt, "iisii", $userId, $titleId, $status, $rating, $watchAgain);
    }
}

if ($stmt && mysqli_stmt_execute($stmt)) {
    $message = "saved=" . $titleId;
} else {
    $message = "error=save";
}

mysqli_close($conn);

// Send the user back to the return_to page, scrolled to the movie they just saved
header("Location: " . $returnTo . $message . "#title-" . $titleId);
exit;
?>
