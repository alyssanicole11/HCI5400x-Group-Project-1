<?php
// about.php - required project write-up (1-2 pages)
// Owner: Doanh (both review)  |  Placeholder for week 1, finished in week 3
// Class topics: HTML text formatting (Lecture 2)
// No login needed: the professor can read this page before picking a demo user.
session_start();   // only so the menu can show who is signed in
include "includes/app_settings.php";
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>About - <?php echo $appName; ?></title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
<?php include "includes/nav.php"; ?>

<main class="about">
    <h1>About <?php echo $appName; ?></h1>

    <p class="lead">
        <?php echo $appName; ?> answers one question: <strong>"What should I actually watch tonight?"</strong>
        Instead of an endless list, it gives you three picks, each with a short "Why this?" reason,
        based on what you have watched, liked and saved, the services you have, and tonight's mood.
    </p>

    <!-- Final text comes from "About Page Draft" in Google Drive (week 3). -->
    <h2>How to use it</h2>
    <p>(Coming in week 3.)</p>

    <h2>How we built it</h2>
    <p>(Coming in week 3.)</p>

    <h2>Technologies</h2>
    <p>HTML, CSS, PHP (procedural, MySQLi) and MySQL on Keymaker.</p>

    <h2>Data sources and credits</h2>
    <p>Movie details and posters come from TMDB.
        This product uses the TMDB API but is not endorsed or certified by TMDB.</p>
    <p>Streaming information is provided by JustWatch through TMDB (United States, captured once,
        not live).</p>
    <!-- Week 3: add the TMDB logo from their attribution page and the date the data was captured. -->

    <h2>AI tools used</h2>
    <p>(Summary of the AI Use Log, week 3.)</p>

    <h2>Team</h2>
    <p>Alyssa and Doanh, HCI/ME 5400X.</p>
</main>

</body>
</html>
