<?php
// index.php - demo login: pick one of the demo users (the start page)
// Owner: Alyssa
// Class topics: forms + POST (Lecture 3), SELECT + JOIN + while loop (Lectures 10-11)
// This is DEMO authentication only: no passwords, just "who's watching?"

session_start();   // so the nav can say who is signed in, if anyone
include "includes/app_settings.php";
include "includes/db_connect.php";

// A short line about each demo user, so a first-time visitor knows whom to pick
$userNotes = [
    1 => "Real watch history from our old watch lists: 61 watched and 92 interested.",
    2 => "Starts blank, like a brand-new visitor. Picks are popular movies until you save some.",
    3 => "Made-up demo person who loves thrillers, sci-fi and action. Has HBO Max, Prime Video and Peacock."
];

// Each demo user plus how many movies they have saved
// (LEFT JOIN keeps users with nothing saved; COUNT counts their user_titles rows)
$sql = "SELECT users.user_id, users.display_name, COUNT(user_titles.title_id) AS saved_count
        FROM users
        LEFT JOIN user_titles ON users.user_id = user_titles.user_id
        GROUP BY users.user_id, users.display_name
        ORDER BY users.user_id";
$result = mysqli_query($conn, $sql);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Choose a demo user - <?php echo $appName; ?></title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
<?php include "includes/nav.php"; ?>

<main>
    <h1>Who's watching tonight?</h1>
    <p>This is a demo login. Pick a demo user to see their personalized picks.
       Try two different users with the same Tonight choices to see how the picks change.</p>

    <?php
    if (isset($_GET['error'])) {
        echo "<p class='message error'>That demo user could not be found. Please pick one below.</p>";
    }
    if (isset($_GET['signed_out'])) {
        echo "<p class='message'>You are signed out.</p>";
    }

    if (!$result) {
        echo "<p class='message error'>Could not read the demo users from the database: "
            . htmlspecialchars(mysqli_error($conn)) . "</p>";
    } elseif (mysqli_num_rows($result) == 0) {
        echo "<p class='message'>No demo users yet. Import database/starter_data.sql in phpMyAdmin.</p>";
    } else {
        echo "<div class='user-list'>";
        while ($row = mysqli_fetch_assoc($result)) {
            $id = (int) $row['user_id'];
    ?>
            <form action="loginProcess.php" method="POST" class="user-card">
                <input type="hidden" name="user_id" value="<?php echo $id; ?>">
                <h2><?php echo htmlspecialchars($row['display_name']); ?></h2>
                <?php
                if (isset($userNotes[$id])) {
                    echo "<p>" . $userNotes[$id] . "</p>";
                }
                ?>
                <p class="small"><?php echo (int) $row['saved_count']; ?> saved movies</p>
                <button type="submit">Watch as <?php echo htmlspecialchars($row['display_name']); ?></button>
            </form>
    <?php
        }
        echo "</div>";
    }
    mysqli_close($conn);
    ?>
</main>

</body>
</html>
