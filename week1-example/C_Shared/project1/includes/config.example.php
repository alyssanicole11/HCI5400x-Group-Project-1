<?php
// config.example.php - a TEMPLATE for your private database login
//
// HOW TO USE IT (one time):
//   1. In PhpStorm, right-click this file > Copy, then paste it into the same
//      includes folder and name the copy  config.php
//   2. In config.php, replace the three "your_..." values with your own:
//        - username: your Keymaker username (the one you use in PhpStorm)
//        - password: your Keymaker password
//        - dbname:   your username followed by _db (phpMyAdmin shows it on the left)
//   3. Upload config.php to Keymaker like any other file.
//   4. NEVER share config.php: not in Drive, not in a zip, not in a text or AI chat.
//
// Keep "localhost" exactly as it is: the database runs on the same Keymaker
// server as our pages (this is what the class slides use).

$servername = "localhost";
$username = "your_keymaker_username";
$password = "your_keymaker_password";
$dbname = "your_keymaker_username_db";

// Only Alyssa fills this in (for tools/tmdb_seed.php). Everyone else leaves it empty.
$tmdbToken = "";
?>
