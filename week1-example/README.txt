WEEK 1 EXAMPLE IMPLEMENTATION - JoyWatch (HCI 5400 Project 1)
=============================================================
One worked example of every week 1 starter file, done the way the Project Spec
and the STEP comments describe. It is a reference to compare against, not
the only right answer. Same layout as the Drive folders:

  A_Doanh/project1/      Doanh's week 1 files
      discover.php         search + popular cards + save form (STEPs 1-5 and both STRETCHes)
      tonight.php          the Tonight form (STEPs 1-6; genre list from the genres table)
      includes/nav.php     menu, current-page highlight, "Watching as ..." + Switch / Sign out
      css/styles.css       one example look (sections 1-7, phone layout included)

  B_Alyssa/project1/     Alyssa's week 1 files
      index.php            demo login: one button per user (with saved-movie counts)
      loginProcess.php     checks the user exists, saves user_id + display_name in the session
      logout.php           clears the session (and the Not Tonight list)
      libraryProcess.php   INSERT or UPDATE user_titles with prepared statements
      includes/db_connect.php     config.php -> mysqli_connect -> $conn
      includes/require_login.php  session check -> $userId / $displayName, else index.php
      tools/tmdb_seed.php  one-time TMDb refresh (already written; small fixes, see below)
      database/catalog_titles.csv  the list tmdb_seed.php reads (unchanged)

  C_Shared/project1/     shared setup files
      includes/app_settings.php   $appName (unchanged)
      includes/config.example.php template (Doanh's packet version + the $tmdbToken line)
      about.php                   placeholder with section headings + TMDb/JustWatch credits
      database/schema.sql         Oct 2 update: every table is utf8mb4 (accented titles)
      images/placeholder-poster.png, database/starter_data*.sql   (unchanged)

  UPLOAD_Doanh/project1/   (zip only) A + B + C merged, without tools/: what Doanh uploads
  UPLOAD_Alyssa/project1/  (zip only) A + B + C merged, with tools/: what Alyssa uploads

  WHO_IMPORTS_WHAT.txt   step-by-step list of uploads and phpMyAdmin imports for each of us

The real require_login.php is in B (Alyssa's file). It replaces the empty
placeholder in Drive's C folder, so every page now needs a demo user.


HOW TO TRY IT
  Follow WHO_IMPORTS_WHAT.txt. In short: upload your UPLOAD_ folder, make config.php,
  import schema.sql, starter_data.sql, starter_data_demo1.sql, open index.php.
  Library, Settings and the Tonight button still say "Not Found": those are week 2.
  Until tmdb_seed.php runs, every movie has popularity 0 and no poster, so
  "Popular right now" is alphabetical and cards show the placeholder.


THE FORM CONTRACT IS KEPT EXACTLY
  index.php -> loginProcess.php (POST): user_id
  discover.php (GET): q
  discover.php -> libraryProcess.php (POST): title_id, status, rating, watch_again, return_to
  tonight.php -> tonightProcess.php (GET): mood, genre, max_runtime, streaming,
                                           include_interested=1, include_rewatches=1


DECISIONS WORTH KNOWING (explain these in the walkthrough)
  - discover.php uses a LEFT JOIN with user_titles so each card's save form shows
    what is already saved. Without it every form starts at "Unrated / Not set",
    and saving just a status would wipe an existing rating.
  - libraryProcess.php reads the saved row first, then changes only the fields the
    form sent. "" is saved as NULL (Unrated stays NULL, never Neutral 0).
    Every value is checked with in_array; title_id with (int) and a SELECT.
  - return_to may carry the search (discover.php?q=toy) so Save returns to the
    same results. Only discover.php / library.php are allowed before the "?".
    libraryProcess adds ?saved=ID#title-ID, so the page says "Saved!" and scrolls
    back to the card.
  - tonight.php reads choices from the address bar, if any, so a future
    "Change my choices" link from tonightProcess.php comes back pre-filled.
    It also links to Settings when the user has no services yet.
  - loginProcess.php clears $_SESSION['not_tonight'] when the user switches
    (spec behavior rule). logout.php clears everything.
  - tools/tmdb_seed.php fixes: an unknown runtime, year or poster is now saved as
    NULL. Before, runtime was saved as 0, which would pass a "90 minutes or less"
    filter. The script now also stops with a clear message when the token is
    missing, when TMDb can't be reached, or when it can't write
    starter_data_tmdb.sql. DELETE ... WHERE title_id IN (...) replaces = (...).

BEYOND CLASS MATERIAL (small, each explained in a comment)
  - Sessions + header("Location: ...") redirects (loginProcess, require_login, logout).
  - mysqli_report(MYSQLI_REPORT_OFF) in db_connect.php: newer PHP stops the page
    on any SQL error. This line keeps the class-style if (!$result) checks working.
  - mysqli_set_charset(..., "utf8mb4") (from Alyssa's notes) for accented titles.
    It matches the Oct 2 schema.sql, where every table is utf8mb4.
  - index.php: LEFT JOIN + COUNT + GROUP BY for the "N saved movies" line.
  - CSS: variables (:root), grid, aspect-ratio, and radio buttons styled as "chips"
    (the real radio stays in the page for keyboard and screen-reader users).


TESTED LOCALLY (PHP 8.3 + MariaDB, the real schema and starter data)
  [x] every .php file passes php -l
  [x] signed out: discover.php / tonight.php redirect to index.php; about.php opens
  [x] index shows 3 users (154 / 0 / 13 saved); bad user_id -> friendly error
  [x] login -> tonight.php, "Watching as Jordan (demo)" in the menu; sign out works
  [x] Discover: 12 popular cards; "the" -> 58 results; "zzzz" -> no-match message;
      typed HTML is escaped
  [x] Save: new row (date_added = updated_at), update (updated_at moves), Unrated = NULL,
      Neutral = 0, sending only status keeps rating / watch_again, invalid values and
      unknown title_id are rejected, an outside return_to is ignored,
      saving as Doanh never changes Jordan's rows
  [x] Tonight: all field names/values above, 19 genres from the table, checkboxes on
  [x] Looks right at desktop width and at phone width (390px)
  [x] Oct 2 schema.sql: all 8 tables utf8mb4; "Amélie" and "WALL·E" save, search and
      display correctly through Discover and libraryProcess
  Not tested: tmdb_seed.php against the live TMDb API (needs Alyssa's token).

AI Use Log line:
  Claude Code: wrote this week 1 example implementation from the Drive packet
  (spec, STEP comments, guides); tested locally with the starter database.
