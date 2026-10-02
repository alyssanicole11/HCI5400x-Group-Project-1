<?php
// tmdb_seed.php - ONE-TIME helper (not part of the app pages)
// Owner: Alyssa
//
// What it does:
//   Reads our movie list (title, tmdb_id, year) from database/catalog_titles.csv. For each movie it
//   asks TMDb for the official details and US streaming services, then writes
//   SQL UPDATE lines to database/starter_data_tmdb.sql. Movies that have no
//   TMDb id yet are found by searching TMDb for the title first.
//
// How to run it:
//   1. Put your TMDb "API Read Access Token" in includes/config.php ($tmdbToken).
//   2. Visit tools/tmdb_seed.php on Keymaker (or run it locally from PhpStorm).
//      It works in batches of 40 so the page does not time out; click
//      "Next batch" until it says it is finished.
//   3. Read the "SEARCHED" lines: they show which TMDb movie each title
//      matched. Fix any wrong match by typing the right tmdb_id into
//      catalog_titles.csv and running again.
//   4. Import database/starter_data_tmdb.sql in phpMyAdmin.
//
// New (not from class): calling a web API with file_get_contents and
// reading JSON with json_decode.

if (!file_exists("../includes/config.php")) {
    die("Missing includes/config.php. Copy config.example.php to config.php first.");
}
include "../includes/config.php";
if (!isset($tmdbToken) || $tmdbToken == "") {
    die("Put your TMDb API Read Access Token in includes/config.php as \$tmdbToken first.");
}
set_time_limit(300);

// Which part of the list to do this time (?start=0, then 40, then 80...)
$start = 0;
if (isset($_GET["start"])) {
    $start = (int) $_GET["start"];
}
$batchSize = 40;

// Our 8 services, by TMDb provider id (US)
$ourProviderIds = [8, 9, 15, 337, 350, 386, 531, 1899];

// Header that sends our token to TMDb
$options = [
    "http" => [
        "header" => "Authorization: Bearer " . $tmdbToken . "\r\nAccept: application/json\r\n",
        "ignore_errors" => true
    ]
];
$context = stream_context_create($options);

// Quick check that Keymaker can reach TMDb at all (if not, run this file locally instead)
$test = file_get_contents("https://api.themoviedb.org/3/configuration", false, $context);
if ($test === false) {
    die("Could not reach TMDb from this server. Try running tools/tmdb_seed.php locally from PhpStorm.");
}
$test = json_decode($test, true);
if (!isset($test["images"])) {
    die("TMDb did not accept the token. Check \$tmdbToken in config.php (use the long API Read Access Token, not the API Key).");
}

// Read the movie list (title, tmdb_id, release_year) into an array
$movies = [];
$file = fopen("../database/catalog_titles.csv", "r");
fgetcsv($file); // skip the header row
while (($row = fgetcsv($file)) !== false) {
    $movies[] = $row;
}
fclose($file);

// Start a new SQL file on the first batch; add to it on later batches
$outName = "../database/starter_data_tmdb.sql";
if ($start == 0) {
    $out = fopen($outName, "w");
    fwrite($out, "-- starter_data_tmdb.sql - written by tools/tmdb_seed.php on " . date("Y-m-d H:i") . "\n");
    fwrite($out, "-- Movie data from TMDb. Streaming data from JustWatch via TMDb (US).\n\n");
} else {
    $out = fopen($outName, "a");
}
if (!$out) {
    die("Could not write $outName. Make the database folder writable for a moment, or run this file locally.");
}

$end = min($start + $batchSize, count($movies));
$seenIds = [];
for ($i = $start; $i < $end; $i++) {
    $ourTitle = $movies[$i][0];
    $id = (int) $movies[$i][1];
    $year = $movies[$i][2];
    $safeTitle = addslashes($ourTitle);

    // 1. No TMDb id yet? Search TMDb by title and take the top result.
    if ($id == 0) {
        $url = "https://api.themoviedb.org/3/search/movie?query=" . urlencode($ourTitle);
        if ($year != "") {
            $url .= "&year=" . $year;
        }
        $search = json_decode(file_get_contents($url, false, $context), true);

        // If nothing matched with the year, try again without it
        if (empty($search["results"]) && $year != "") {
            $url = "https://api.themoviedb.org/3/search/movie?query=" . urlencode($ourTitle);
            $search = json_decode(file_get_contents($url, false, $context), true);
            echo "&nbsp;&nbsp;(no match for " . htmlspecialchars($ourTitle) . " in $year, searched without the year)<br>";
        }
        if (empty($search["results"])) {
            echo "NOT FOUND: " . htmlspecialchars($ourTitle) . "<br>";
            continue;
        }
        $id = $search["results"][0]["id"];
        echo "SEARCHED: " . htmlspecialchars($ourTitle) . " &rarr; " . htmlspecialchars($search["results"][0]["title"])
            . " (" . substr($search["results"][0]["release_date"], 0, 4) . "), TMDb id $id<br>";
    }

    // 2. Ask TMDb for the details plus watch providers in one request
    $url = "https://api.themoviedb.org/3/movie/" . $id . "?append_to_response=watch/providers";
    $movie = json_decode(file_get_contents($url, false, $context), true);
    if (!isset($movie["id"])) {
        echo "TMDb did not return details for " . htmlspecialchars($ourTitle) . "<br>";
        continue;
    }

    // 3. Pull out the fields we store (addslashes keeps quotes from breaking the SQL)
    //    Unknown year, runtime or poster is saved as NULL (not 0 or ''), so a runtime
    //    limit on Tonight leaves those movies out instead of treating them as 0 minutes.
    $releaseYear = "NULL";
    if (!empty($movie["release_date"])) {
        $releaseYear = (int) substr($movie["release_date"], 0, 4);
    }
    $runtime = "NULL";
    if (!empty($movie["runtime"])) {
        $runtime = (int) $movie["runtime"];
    }
    $overview = addslashes((string) $movie["overview"]);
    $poster = "NULL";
    if (!empty($movie["poster_path"])) {
        $poster = "'" . addslashes($movie["poster_path"]) . "'";
    }
    $popularity = round($movie["popularity"], 3);

    // 4. Update our row for this movie (we keep our own title text so the match stays stable).
    //    UPDATE IGNORE skips the row (instead of stopping the import) if another
    //    title already has this TMDb id.
    if (in_array($id, $seenIds)) {
        echo "&nbsp;&nbsp;WARNING: " . htmlspecialchars($ourTitle) . " matched a TMDb id already used in this batch ($id). Check it.<br>";
    }
    $seenIds[] = $id;
    $sql = "UPDATE IGNORE titles SET tmdb_id = $id, release_year = $releaseYear, runtime = $runtime, overview = '$overview', "
         . "poster_path = $poster, popularity_score = $popularity, updated_at = NOW() "
         . "WHERE media_type = 'movie' AND title = '$safeTitle';\n";

    // 5. Replace its genres with TMDb's
    $sql .= "DELETE FROM title_genres WHERE title_id IN (SELECT title_id FROM titles WHERE media_type = 'movie' AND title = '$safeTitle');\n";
    foreach ($movie["genres"] as $genre) {
        $sql .= "INSERT IGNORE INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g "
              . "WHERE t.media_type = 'movie' AND t.title = '$safeTitle' AND g.tmdb_genre_id = " . $genre["id"] . ";\n";
    }

    // 6. Replace its US subscription streaming services with TMDb's
    $sql .= "DELETE FROM title_services WHERE title_id IN (SELECT title_id FROM titles WHERE media_type = 'movie' AND title = '$safeTitle');\n";
    if (isset($movie["watch/providers"]["results"]["US"]["flatrate"])) {
        foreach ($movie["watch/providers"]["results"]["US"]["flatrate"] as $provider) {
            if (in_array($provider["provider_id"], $ourProviderIds)) {
                $sql .= "INSERT IGNORE INTO title_services (title_id, service_id) SELECT t.title_id, s.service_id FROM titles t, services s "
                      . "WHERE t.media_type = 'movie' AND t.title = '$safeTitle' AND s.tmdb_provider_id = " . $provider["provider_id"] . ";\n";
            } else {
                // Shows providers we skipped, so we can check our provider ids are right
                echo "&nbsp;&nbsp;(skipped provider: " . htmlspecialchars($provider["provider_name"]) . ", id " . $provider["provider_id"] . ")<br>";
            }
        }
    }

    fwrite($out, $sql . "\n");
    echo "OK: " . htmlspecialchars($ourTitle) . "<br>";
}
fclose($out);

// 7. Link to the next batch, or say we are done
if ($end < count($movies)) {
    echo "<p>Done with movies " . ($start + 1) . " to $end of " . count($movies) . ". "
       . "<a href=\"tmdb_seed.php?start=$end\">Next batch</a></p>";
} else {
    echo "<p>Finished all " . count($movies) . " movies. Import database/starter_data_tmdb.sql in phpMyAdmin.</p>";
}
?>
