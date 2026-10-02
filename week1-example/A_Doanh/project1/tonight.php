<?php
// tonight.php - the Tonight form: what does this person want to watch tonight?
// Owner: Doanh  |  Week 1 (we design the choices together)
// Class examples: formSampleInputs.html, formSampleInputsFancy.html (radios, checkboxes, selects)
//
// This page is ONLY the form. When someone presses the button, the answers go to
// tonightProcess.php (Alyssa, week 2), which picks the 3 movies.
// Until week 2, pressing the button shows "Not Found". That is expected.

include "includes/app_settings.php";
include "includes/require_login.php";   // gives $userId
include "includes/db_connect.php";      // gives $conn (for the genre list)

// The choices (value => words people see). The VALUES must stay exactly like this,
// because tonightProcess.php reads them.
$moodOptions = [
    "any" => "Surprise me",
    "funny" => "Funny",
    "suspenseful" => "Suspenseful",
    "emotional" => "Emotional",
    "exciting" => "Exciting",
    "feelgood" => "Feel good"
];
$runtimeOptions = [
    "any" => "Any length",
    "90" => "Up to 1.5 hours",
    "120" => "Up to 2 hours",
    "150" => "Up to 2.5 hours"
];
$streamingOptions = [
    "any" => "Anything",
    "mine" => "Only my services"
];

// Start with the defaults. If we came back here with choices in the address bar
// (for example a "Change my choices" link from the results), pre-select those instead.
$mood = "any";
if (isset($_GET['mood']) && isset($moodOptions[$_GET['mood']])) {
    $mood = $_GET['mood'];
}
$genre = "any";
if (isset($_GET['genre']) && $_GET['genre'] != "any") {
    $genre = (int) $_GET['genre'];
}
$maxRuntime = "any";
if (isset($_GET['max_runtime']) && isset($runtimeOptions[$_GET['max_runtime']])) {
    $maxRuntime = $_GET['max_runtime'];
}
$streaming = "any";
if (isset($_GET['streaming']) && isset($streamingOptions[$_GET['streaming']])) {
    $streaming = $_GET['streaming'];
}
// Checkboxes are checked by default. An unchecked box sends nothing, so once the form
// has been sent (mood is in the address bar), "not there" means "unchecked".
$includeInterested = true;
$includeRewatches = true;
if (isset($_GET['mood'])) {
    $includeInterested = isset($_GET['include_interested']);
    $includeRewatches = isset($_GET['include_rewatches']);
}

// STEP 2 STRETCH: the genre list comes from the genres table
$genreResult = mysqli_query($conn, "SELECT genre_id, genre_name FROM genres ORDER BY genre_name");

// Does this user have any services saved yet? (for a hint next to "Only my services")
$serviceResult = mysqli_query($conn, "SELECT COUNT(*) AS how_many FROM user_services WHERE user_id = $userId");
$serviceCount = 0;
if ($serviceResult) {
    $serviceRow = mysqli_fetch_assoc($serviceResult);
    $serviceCount = (int) $serviceRow['how_many'];
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Tonight - <?php echo $appName; ?></title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
<?php include "includes/nav.php"; ?>

<main>
    <h1>What should I watch tonight?</h1>
    <p>Answer a few quick questions and we'll pick 3 movies for you.</p>

    <form action="tonightProcess.php" method="GET" class="tonight-form">

        <!-- STEP 1: Mood (radio buttons with the same name, so you can pick only one) -->
        <fieldset>
            <legend>What's the mood?</legend>
            <div class="chips">
                <?php
                foreach ($moodOptions as $value => $label) {
                    $checked = "";
                    if ($value == $mood) {
                        $checked = " checked";
                    }
                    echo "<label class=\"chip\"><input type=\"radio\" name=\"mood\" value=\"$value\"$checked>"
                        . "<span>$label</span></label>";
                }
                ?>
            </div>
        </fieldset>

        <!-- STEP 2: Genre (a dropdown; each option's value is its genre_id) -->
        <fieldset>
            <legend>Any genre in mind?</legend>
            <label for="genre">Genre</label>
            <select name="genre" id="genre">
                <option value="any">Any genre</option>
                <?php
                if ($genreResult) {
                    while ($row = mysqli_fetch_assoc($genreResult)) {
                        $selected = "";
                        if ($row['genre_id'] == $genre) {
                            $selected = " selected";
                        }
                        echo "<option value=\"" . (int) $row['genre_id'] . "\"$selected>"
                            . htmlspecialchars($row['genre_name']) . "</option>";
                    }
                }
                ?>
            </select>
        </fieldset>

        <!-- STEP 3: How much time? -->
        <fieldset>
            <legend>How much time do you have?</legend>
            <div class="chips">
                <?php
                foreach ($runtimeOptions as $value => $label) {
                    $checked = "";
                    if ((string) $value === (string) $maxRuntime) {
                        $checked = " checked";
                    }
                    echo "<label class=\"chip\"><input type=\"radio\" name=\"max_runtime\" value=\"$value\"$checked>"
                        . "<span>$label</span></label>";
                }
                ?>
            </div>
        </fieldset>

        <!-- STEP 4: Streaming -->
        <fieldset>
            <legend>Where can it stream?</legend>
            <div class="chips">
                <?php
                foreach ($streamingOptions as $value => $label) {
                    $checked = "";
                    if ($value == $streaming) {
                        $checked = " checked";
                    }
                    echo "<label class=\"chip\"><input type=\"radio\" name=\"streaming\" value=\"$value\"$checked>"
                        . "<span>$label</span></label>";
                }
                ?>
            </div>
            <?php
            if ($serviceCount == 0) {
                echo "<p class=\"small\">You haven't picked your services yet. "
                    . "<a href=\"settings.php\">Choose them in Settings</a> to use \"Only my services\".</p>";
            }
            ?>
        </fieldset>

        <!-- STEP 5: Watch history (two checkboxes, both checked by default;
             both unchecked = only movies you have never marked) -->
        <fieldset>
            <legend>Include movies you already know?</legend>
            <label class="check">
                <input type="checkbox" name="include_interested" value="1"<?php if ($includeInterested) { echo " checked"; } ?>>
                Include movies I marked Interested
            </label>
            <label class="check">
                <input type="checkbox" name="include_rewatches" value="1"<?php if ($includeRewatches) { echo " checked"; } ?>>
                Include favorites I'd watch again
            </label>
        </fieldset>

        <!-- STEP 6: the submit button -->
        <button type="submit" class="big-button">Show me 3 picks</button>
    </form>
    <?php mysqli_close($conn); ?>
</main>

</body>
</html>
