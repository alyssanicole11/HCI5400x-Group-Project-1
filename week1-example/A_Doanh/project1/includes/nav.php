<?php
// nav.php - the header and menu that appears at the top of EVERY page
// Owner: Doanh  |  Week 1
// Every page has the line  include "includes/nav.php";  so whatever you write
// here shows up everywhere. Change the menu once, here, and every page updates.

// STEP 2: the menu links (file name => words people see).
// These five links must stay (the About link is required by the assignment).
$menuLinks = [
    "tonight.php"  => "Tonight",
    "discover.php" => "Discover",
    "library.php"  => "Library",
    "settings.php" => "Settings",
    "about.php"    => "About"
];

// STRETCH: which page are we on? (for example "discover.php")
$currentPage = basename($_SERVER['PHP_SELF']);
?>
<header class="site-header">
    <!-- STEP 1: the app name / logo, plus a small tagline -->
    <a href="tonight.php" class="brand">
        <?php echo $appName; ?>
        <span class="tagline">3 picks for tonight</span>
    </a>

    <nav aria-label="Main menu">
        <ul>
            <?php
            foreach ($menuLinks as $file => $label) {
                if ($file == $currentPage) {
                    echo "<li><a href=\"$file\" class=\"active\" aria-current=\"page\">$label</a></li>";
                } else {
                    echo "<li><a href=\"$file\">$label</a></li>";
                }
            }
            ?>
        </ul>
    </nav>

    <!-- LATER (now done): show who is signed in. Alyssa's login saves the name in
         $_SESSION['display_name']. Pages without a login (About, the login page itself)
         may have no one signed in, so check with isset first. -->
    <div class="who">
        <?php
        if (isset($_SESSION['display_name'])) {
            echo "Watching as <strong>" . htmlspecialchars($_SESSION['display_name']) . "</strong>";
            echo " <a href=\"index.php\">Switch</a> <a href=\"logout.php\">Sign out</a>";
        } else {
            echo "<a href=\"index.php\">Pick a demo user</a>";
        }
        ?>
    </div>
</header>
