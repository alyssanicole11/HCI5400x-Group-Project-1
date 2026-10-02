<?php
// discover.php - Discover: search box, popular movie cards, a save form on each card
// Owner: Doanh  |  Week 1
// Class examples: formSampleInputs.html (forms) and mysqlReadSales.php (read rows + loop)

include "includes/app_settings.php";
include "includes/require_login.php";   // gives $userId
include "includes/db_connect.php";      // gives $conn

// The choices for the save form (value => words people see).
// The values must match what Alyssa's libraryProcess.php allows.
$statusOptions = [
    "none" => "No status",
    "interested" => "Interested",
    "watched" => "Watched",
    "not_interested" => "Not Interested"
];
$ratingOptions = [
    "" => "Unrated",
    "-1" => "Dislike",
    "0" => "Neutral",
    "1" => "Like",
    "2" => "Love"
];
$watchAgainOptions = [
    "" => "Not set",
    "0" => "No",
    "1" => "Yes"
];

// What was typed in the search box (empty if nothing)
$search = "";
if (isset($_GET['q'])) {
    $search = trim($_GET['q']);
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Discover - <?php echo $appName; ?></title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
<?php include "includes/nav.php"; ?>

<main>
    <h1>Discover</h1>

    <!-- STEP 1: the search form. GET puts the word in the address bar (discover.php?q=love).
         STRETCH: the typed word stays in the box (htmlspecialchars keeps it safe). -->
    <form action="discover.php" method="GET" class="search-form">
        <label for="q">Search movies</label>
        <input type="text" id="q" name="q" value="<?php echo htmlspecialchars($search); ?>"
               placeholder="Try love, the, or Toy Story">
        <button type="submit">Search</button>
        <?php
        if ($search != "") {
            echo "<a href=\"discover.php\">Clear</a>";
        }
        ?>
    </form>

    <?php
    // Messages from libraryProcess.php after pressing Save
    if (isset($_GET['saved'])) {
        echo "<p class='message success'>Saved! It's in your Library now.</p>";
    }
    if (isset($_GET['error'])) {
        echo "<p class='message error'>Sorry, that choice could not be saved. Please try again.</p>";
    }

    // STEP 2: decide which movies to show.
    // The LEFT JOIN also brings back this user's saved choice for each movie (or NULL if none),
    // so the save form can show what is already saved (the STRETCH in STEP 5).
    $sql = "SELECT titles.title_id, titles.title, titles.release_year, titles.runtime, titles.poster_path,
                   user_titles.status, user_titles.rating, user_titles.watch_again
            FROM titles
            LEFT JOIN user_titles ON titles.title_id = user_titles.title_id
                                 AND user_titles.user_id = $userId";

    if ($search != "") {
        // a) clean the word before it touches SQL, b) search titles that contain it
        $q = mysqli_real_escape_string($conn, $search);
        $sql = $sql . " WHERE titles.title LIKE '%$q%' ORDER BY titles.title";
        echo "<h2>Results for \"" . htmlspecialchars($search) . "\"</h2>";
    } else {
        // nobody searched yet: show the 12 most popular movies
        $sql = $sql . " ORDER BY titles.popularity_score DESC, titles.title LIMIT 12";
        echo "<h2>Popular right now</h2>";
    }

    // STEP 3: run the SQL and loop through the rows (same idea as mysqlReadSales.php)
    $result = mysqli_query($conn, $sql);

    if (!$result) {
        echo "<p class='message error'>Something went wrong reading the movies: "
            . htmlspecialchars(mysqli_error($conn)) . "</p>";
    } elseif (mysqli_num_rows($result) == 0 && $search != "") {
        echo "<p class='message'>No movies match \"" . htmlspecialchars($search) . "\". "
            . "Try a shorter word, or <a href=\"discover.php\">see popular movies</a>.</p>";
    } elseif (mysqli_num_rows($result) == 0) {
        echo "<p class='message'>There are no movies in the catalog yet. "
            . "Import database/starter_data.sql in phpMyAdmin.</p>";
    } else {
        // return_to keeps the search, so Save brings you back to the same results
        $returnTo = "discover.php";
        if ($search != "") {
            $returnTo = "discover.php?q=" . urlencode($search);
        }

        echo "<section class=\"cards\">";

        while ($row = mysqli_fetch_assoc($result)) {
            // STEP 4: one movie card
            $titleId = (int) $row['title_id'];

            // Poster from TMDb, or our placeholder if there is none yet
            $poster = "images/placeholder-poster.png";
            if ($row['poster_path'] != "") {
                $poster = "https://image.tmdb.org/t/p/w342" . $row['poster_path'];
            }

            // Small line under the title: year and runtime, when we know them
            $details = "";
            if ($row['release_year'] != "") {
                $details = $row['release_year'];
            }
            if ($row['runtime'] != "") {
                if ($details != "") {
                    $details = $details . " &middot; ";
                }
                $details = $details . $row['runtime'] . " min";
            }

            // Highlight the card that was just saved
            $cardClass = "card";
            if (isset($_GET['saved']) && $_GET['saved'] == $titleId) {
                $cardClass = "card just-saved";
            }

            // This user's saved choice ("" = nothing saved yet)
            $currentStatus = "none";
            if ($row['status'] != "") {
                $currentStatus = $row['status'];
            }
            $currentRating = "";
            if ($row['rating'] !== null) {
                $currentRating = $row['rating'];
            }
            $currentWatchAgain = "";
            if ($row['watch_again'] !== null) {
                $currentWatchAgain = $row['watch_again'];
            }
    ?>
            <article class="<?php echo $cardClass; ?>" id="title-<?php echo $titleId; ?>">
                <img src="<?php echo htmlspecialchars($poster); ?>"
                     alt="Poster for <?php echo htmlspecialchars($row['title']); ?>">
                <div class="card-body">
                    <h3><?php echo htmlspecialchars($row['title']); ?></h3>
                    <p class="small"><?php echo $details; ?></p>

                    <!-- STEP 5: the save form. Field names must match libraryProcess.php exactly. -->
                    <form action="libraryProcess.php" method="POST" class="save-form">
                        <input type="hidden" name="title_id" value="<?php echo $titleId; ?>">
                        <input type="hidden" name="return_to" value="<?php echo htmlspecialchars($returnTo); ?>">

                        <label for="status-<?php echo $titleId; ?>">Status</label>
                        <select name="status" id="status-<?php echo $titleId; ?>">
                            <?php
                            foreach ($statusOptions as $value => $label) {
                                $selected = "";
                                if ($value == $currentStatus) {
                                    $selected = " selected";
                                }
                                echo "<option value=\"$value\"$selected>$label</option>";
                            }
                            ?>
                        </select>

                        <label for="rating-<?php echo $titleId; ?>">Rating</label>
                        <select name="rating" id="rating-<?php echo $titleId; ?>">
                            <?php
                            foreach ($ratingOptions as $value => $label) {
                                // (string) because PHP turns keys like "2" into the number 2
                                $selected = "";
                                if ((string) $value === (string) $currentRating) {
                                    $selected = " selected";
                                }
                                echo "<option value=\"$value\"$selected>$label</option>";
                            }
                            ?>
                        </select>

                        <label for="again-<?php echo $titleId; ?>">Watch again?</label>
                        <select name="watch_again" id="again-<?php echo $titleId; ?>">
                            <?php
                            foreach ($watchAgainOptions as $value => $label) {
                                $selected = "";
                                if ((string) $value === (string) $currentWatchAgain) {
                                    $selected = " selected";
                                }
                                echo "<option value=\"$value\"$selected>$label</option>";
                            }
                            ?>
                        </select>

                        <button type="submit">Save</button>
                    </form>
                </div>
            </article>
    <?php
        }
        echo "</section>";
    }

    mysqli_close($conn);

    // DONE WITH WEEK 1 WHEN:
    //   [x] searching changes the address bar to ?q=...
    //   [x] popular movies show when nothing is searched
    //   [x] a search with no match shows a friendly message
    //   [x] each card shows a poster or the placeholder, title and year
    //   [x] each card has the save form with the exact field names above
    ?>
</main>

</body>
</html>
