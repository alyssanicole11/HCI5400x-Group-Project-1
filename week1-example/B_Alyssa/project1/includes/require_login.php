<?php
// require_login.php - every page that needs a demo user includes this
// Owner: Alyssa
// Class topics: none yet. New: sessions (session_start, $_SESSION) and header() redirects.
//
// After this file runs, the page has:
//   $userId       the signed-in demo user (1 = Alyssa & Mom, 2 = Doanh, 3 = Jordan)
//   $displayName  their name, e.g. "Jordan (demo)"
// Include it before any HTML is printed, because header() only works before output.

session_start();

// Nobody picked a demo user yet: go to the demo login page
if (!isset($_SESSION['user_id'])) {
    header("Location: index.php");
    exit;
}

$userId = (int) $_SESSION['user_id'];
$displayName = $_SESSION['display_name'];
?>
