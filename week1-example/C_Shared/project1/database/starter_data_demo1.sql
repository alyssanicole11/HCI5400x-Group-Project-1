-- starter_data_demo1.sql - demo user 1 (Alyssa & Mom) from our recovered watch lists
-- Owner: Alyssa
-- Run AFTER schema.sql and starter_data.sql.
--
-- SOURCE: joywatch_recovered_seed_titles.csv (271 titles recovered from old
-- personal watch lists and the combined Alyssa + Mom tracker). Movies only
-- (228); the 42 TV shows wait until TV is added.
--
-- For this class project, Alyssa's and Mom's evidence is combined into ONE
-- demo profile. Rules used (nothing is made up):
--   Watched        if Alyssa or Mom watched it, or the old tracker says Watched
--   Not Interested if Alyssa said Not interested, or the old tracker says Not a Fit
--   Interested     if Alyssa said Yes, or the old tracker says Want to Watch
--   (no record)    if it was only Suggested or mentioned: it is added to the
--                  catalog as an unseen movie, but nothing personal is filled in
--   Rating         Alyssa's rating, else Mom's, else the old reaction
--                  (Loved = 2, Liked = 1, Disliked = -1); only for Watched movies
--   Watch Again    left Not set (no evidence yet; easy to set in the app)
--
-- New movies are added with a title and the most likely release year (for
-- titles with remakes, we picked the version that best fits the lists).
-- tools/tmdb_seed.php looks each one up on TMDb and fills in the id, year,
-- runtime, genres, poster, popularity and services. Until then they appear
-- as titles without details.
-- 220 new movies; 154 personal records.

-- Movies from the seed list that are not already in starter_data.sql
INSERT INTO titles (tmdb_id, media_type, title, release_year, popularity_score, updated_at) VALUES
  (NULL, 'movie', '10 Things I Hate About You', 1999, 0, NOW()),
  (NULL, 'movie', '12 Monkeys', 1995, 0, NOW()),
  (NULL, 'movie', '27 Dresses', 2008, 0, NOW()),
  (NULL, 'movie', '50 First Dates', 2004, 0, NOW()),
  (NULL, 'movie', 'A Simple Favor', 2018, 0, NOW()),
  (NULL, 'movie', 'A Walk in the Clouds', 1995, 0, NOW()),
  (NULL, 'movie', 'About Time', 2013, 0, NOW()),
  (NULL, 'movie', 'Air', 2023, 0, NOW()),
  (NULL, 'movie', 'Along Came Polly', 2004, 0, NOW()),
  (NULL, 'movie', 'American Psycho', 2000, 0, NOW()),
  (NULL, 'movie', 'An Officer and a Gentleman', 1982, 0, NOW()),
  (NULL, 'movie', 'Anywhere But Here', 1999, 0, NOW()),
  (NULL, 'movie', 'Are You There God? It''s Me, Margaret.', 2023, 0, NOW()),
  (NULL, 'movie', 'Armageddon', 1998, 0, NOW()),
  (NULL, 'movie', 'Big Daddy', 1999, 0, NOW()),
  (NULL, 'movie', 'Blink Twice', 2024, 0, NOW()),
  (NULL, 'movie', 'Blow', 2001, 0, NOW()),
  (NULL, 'movie', 'Blue Crush', 2002, 0, NOW()),
  (NULL, 'movie', 'Booksmart', 2019, 0, NOW()),
  (NULL, 'movie', 'Bridget Jones''s Diary', 2001, 0, NOW()),
  (NULL, 'movie', 'Bring It On', 2000, 0, NOW()),
  (NULL, 'movie', 'Catch Me If You Can', 2002, 0, NOW()),
  (NULL, 'movie', 'Chef', 2014, 0, NOW()),
  (NULL, 'movie', 'Coherence', 2013, 0, NOW()),
  (NULL, 'movie', 'Coyote Ugly', 2000, 0, NOW()),
  (NULL, 'movie', 'Crazy, Stupid, Love', 2011, 0, NOW()),
  (NULL, 'movie', 'Crossroads', 2002, 0, NOW()),
  (NULL, 'movie', 'Dead Poets Society', 1989, 0, NOW()),
  (NULL, 'movie', 'Death Becomes Her', 1992, 0, NOW()),
  (NULL, 'movie', 'Deep Water', 2022, 0, NOW()),
  (NULL, 'movie', 'Definitely, Maybe', 2008, 0, NOW()),
  (NULL, 'movie', 'Destination Wedding', 2018, 0, NOW()),
  (NULL, 'movie', 'Dirty Dancing', 1987, 0, NOW()),
  (NULL, 'movie', 'Divine Secrets of the Ya-Ya Sisterhood', 2002, 0, NOW()),
  (NULL, 'movie', 'Dogma', 1999, 0, NOW()),
  (NULL, 'movie', 'Drop', 2025, 0, NOW()),
  (NULL, 'movie', 'Dumb and Dumber', 1994, 0, NOW()),
  (NULL, 'movie', 'Dune: Part Two', 2024, 0, NOW()),
  (NULL, 'movie', 'Easy A', 2010, 0, NOW()),
  (NULL, 'movie', 'Eat Pray Love', 2010, 0, NOW()),
  (NULL, 'movie', 'Edward Scissorhands', 1990, 0, NOW()),
  (NULL, 'movie', 'Eileen', 2023, 0, NOW()),
  (NULL, 'movie', 'Enough Said', 2013, 0, NOW()),
  (NULL, 'movie', 'Erin Brockovich', 2000, 0, NOW()),
  (NULL, 'movie', 'Eternal Sunshine of the Spotless Mind', 2004, 0, NOW()),
  (NULL, 'movie', 'Ex Machina', 2015, 0, NOW()),
  (NULL, 'movie', 'Face/Off', 1997, 0, NOW()),
  (NULL, 'movie', 'Failure to Launch', 2006, 0, NOW()),
  (NULL, 'movie', 'Fatal Attraction', 1987, 0, NOW()),
  (NULL, 'movie', 'Flightplan', 2005, 0, NOW()),
  (NULL, 'movie', 'Fool''s Gold', 2008, 0, NOW()),
  (NULL, 'movie', 'Footloose', 1984, 0, NOW()),
  (NULL, 'movie', 'Forces of Nature', 1999, 0, NOW()),
  (NULL, 'movie', 'Four Weddings and a Funeral', 1994, 0, NOW()),
  (NULL, 'movie', 'Fracture', 2007, 0, NOW()),
  (NULL, 'movie', 'Freaky Friday', 2003, 0, NOW()),
  (NULL, 'movie', 'Freeway', 1996, 0, NOW()),
  (NULL, 'movie', 'Frequency', 2000, 0, NOW()),
  (NULL, 'movie', 'Friends with Kids', 2012, 0, NOW()),
  (NULL, 'movie', 'Game Night', 2018, 0, NOW()),
  (NULL, 'movie', 'Go', 1999, 0, NOW()),
  (NULL, 'movie', 'Gone Baby Gone', 2007, 0, NOW()),
  (NULL, 'movie', 'Gone Girl', 2014, 0, NOW()),
  (NULL, 'movie', 'Hanging Up', 2000, 0, NOW()),
  (NULL, 'movie', 'He Went That Way', 2023, 0, NOW()),
  (NULL, 'movie', 'His Three Daughters', 2023, 0, NOW()),
  (NULL, 'movie', 'Hope Floats', 1998, 0, NOW()),
  (NULL, 'movie', 'How to Lose a Guy in 10 Days', 2003, 0, NOW()),
  (NULL, 'movie', 'I Want You Back', 2022, 0, NOW()),
  (NULL, 'movie', 'I, Tonya', 2017, 0, NOW()),
  (NULL, 'movie', 'Inside Man', 2006, 0, NOW()),
  (NULL, 'movie', 'It''s Complicated', 2009, 0, NOW()),
  (NULL, 'movie', 'Jawbreaker', 1999, 0, NOW()),
  (NULL, 'movie', 'Jerry Maguire', 1996, 0, NOW()),
  (NULL, 'movie', 'Josie and the Pussycats', 2001, 0, NOW()),
  (NULL, 'movie', 'Just Like Heaven', 2005, 0, NOW()),
  (NULL, 'movie', 'Just Married', 2003, 0, NOW()),
  (NULL, 'movie', 'L.A. Confidential', 1997, 0, NOW()),
  (NULL, 'movie', 'Leap Year', 2010, 0, NOW()),
  (NULL, 'movie', 'Leave the World Behind', 2023, 0, NOW()),
  (NULL, 'movie', 'Legally Blonde', 2001, 0, NOW()),
  (NULL, 'movie', 'Liar Liar', 1997, 0, NOW()),
  (NULL, 'movie', 'Life of Pi', 2012, 0, NOW()),
  (NULL, 'movie', 'Little Black Book', 2004, 0, NOW()),
  (NULL, 'movie', 'Little Women', 2019, 0, NOW()),
  (NULL, 'movie', 'Long Shot', 2019, 0, NOW()),
  (NULL, 'movie', 'Looper', 2012, 0, NOW()),
  (NULL, 'movie', 'Magnolia', 1999, 0, NOW()),
  (NULL, 'movie', 'Maid in Manhattan', 2002, 0, NOW()),
  (NULL, 'movie', 'Man Up', 2015, 0, NOW()),
  (NULL, 'movie', 'Mean Girls', 2004, 0, NOW()),
  (NULL, 'movie', 'Mermaids', 1990, 0, NOW()),
  (NULL, 'movie', 'Michael', 1996, 0, NOW()),
  (NULL, 'movie', 'Miss Congeniality', 2000, 0, NOW()),
  (NULL, 'movie', 'Mona Lisa Smile', 2003, 0, NOW()),
  (NULL, 'movie', 'Monster-in-Law', 2005, 0, NOW()),
  (NULL, 'movie', 'Monte Carlo', 2011, 0, NOW()),
  (NULL, 'movie', 'Moonstruck', 1987, 0, NOW()),
  (NULL, 'movie', 'Morning Glory', 2010, 0, NOW()),
  (NULL, 'movie', 'Mother of the Bride', 2024, 0, NOW()),
  (NULL, 'movie', 'Mr. Deeds', 2002, 0, NOW()),
  (NULL, 'movie', 'Mrs. Doubtfire', 1993, 0, NOW()),
  (NULL, 'movie', 'Mulholland Drive', 2001, 0, NOW()),
  (NULL, 'movie', 'Music and Lyrics', 2007, 0, NOW()),
  (NULL, 'movie', 'My Best Friend''s Wedding', 1997, 0, NOW()),
  (NULL, 'movie', 'My Cousin Vinny', 1992, 0, NOW()),
  (NULL, 'movie', 'Mystic Pizza', 1988, 0, NOW()),
  (NULL, 'movie', 'National Treasure', 2004, 0, NOW()),
  (NULL, 'movie', 'Never Been Kissed', 1999, 0, NOW()),
  (NULL, 'movie', 'Nightcrawler', 2014, 0, NOW()),
  (NULL, 'movie', 'No Hard Feelings', 2023, 0, NOW()),
  (NULL, 'movie', 'Notting Hill', 1999, 0, NOW()),
  (NULL, 'movie', 'Ocean''s Eleven', 2001, 0, NOW()),
  (NULL, 'movie', 'Ocean''s Thirteen', 2007, 0, NOW()),
  (NULL, 'movie', 'Office Space', 1999, 0, NOW()),
  (NULL, 'movie', 'Palm Springs', 2020, 0, NOW()),
  (NULL, 'movie', 'Panic Room', 2002, 0, NOW()),
  (NULL, 'movie', 'Phenomenon', 1996, 0, NOW()),
  (NULL, 'movie', 'Plus One', 2019, 0, NOW()),
  (NULL, 'movie', 'Predestination', 2014, 0, NOW()),
  (NULL, 'movie', 'Presumed Innocent', 1990, 0, NOW()),
  (NULL, 'movie', 'Primal Fear', 1996, 0, NOW()),
  (NULL, 'movie', 'Prisoners', 2013, 0, NOW()),
  (NULL, 'movie', 'Pulp Fiction', 1994, 0, NOW()),
  (NULL, 'movie', 'Punch-Drunk Love', 2002, 0, NOW()),
  (NULL, 'movie', 'Ready Player One', 2018, 0, NOW()),
  (NULL, 'movie', 'Reality', 2023, 0, NOW()),
  (NULL, 'movie', 'Reality Bites', 1994, 0, NOW()),
  (NULL, 'movie', 'Red Eye', 2005, 0, NOW()),
  (NULL, 'movie', 'Risky Business', 1983, 0, NOW()),
  (NULL, 'movie', 'Romy and Michele''s High School Reunion', 1997, 0, NOW()),
  (NULL, 'movie', 'Rumor Has It...', 2005, 0, NOW()),
  (NULL, 'movie', 'Runaway Bride', 1999, 0, NOW()),
  (NULL, 'movie', 'Save the Last Dance', 2001, 0, NOW()),
  (NULL, 'movie', 'Say Anything', 1989, 0, NOW()),
  (NULL, 'movie', 'Scent of a Woman', 1992, 0, NOW()),
  (NULL, 'movie', 'Se7en', 1995, 0, NOW()),
  (NULL, 'movie', 'Serendipity', 2001, 0, NOW()),
  (NULL, 'movie', 'Set It Up', 2018, 0, NOW()),
  (NULL, 'movie', 'She''s All That', 1999, 0, NOW()),
  (NULL, 'movie', 'Shutter Island', 2010, 0, NOW()),
  (NULL, 'movie', 'Sister Act', 1992, 0, NOW()),
  (NULL, 'movie', 'Sleeping with Other People', 2015, 0, NOW()),
  (NULL, 'movie', 'Sleepless in Seattle', 1993, 0, NOW()),
  (NULL, 'movie', 'Sneakers', 1992, 0, NOW()),
  (NULL, 'movie', 'Some Kind of Wonderful', 1987, 0, NOW()),
  (NULL, 'movie', 'Something''s Gotta Give', 2003, 0, NOW()),
  (NULL, 'movie', 'Source Code', 2011, 0, NOW()),
  (NULL, 'movie', 'Spaceman', 2024, 0, NOW()),
  (NULL, 'movie', 'Speed', 1994, 0, NOW()),
  (NULL, 'movie', 'St. Elmo''s Fire', 1985, 0, NOW()),
  (NULL, 'movie', 'Steel Magnolias', 1989, 0, NOW()),
  (NULL, 'movie', 'Stepmom', 1998, 0, NOW()),
  (NULL, 'movie', 'Sweet Home Alabama', 2002, 0, NOW()),
  (NULL, 'movie', 'Terms of Endearment', 1983, 0, NOW()),
  (NULL, 'movie', 'That Thing You Do', 1996, 0, NOW()),
  (NULL, 'movie', 'The Adjustment Bureau', 2011, 0, NOW()),
  (NULL, 'movie', 'The Age of Adaline', 2015, 0, NOW()),
  (NULL, 'movie', 'The American President', 1995, 0, NOW()),
  (NULL, 'movie', 'The Batman', 2022, 0, NOW()),
  (NULL, 'movie', 'The Big Sick', 2017, 0, NOW()),
  (NULL, 'movie', 'The Birdcage', 1996, 0, NOW()),
  (NULL, 'movie', 'The Butterfly Effect', 2004, 0, NOW()),
  (NULL, 'movie', 'The Client', 1994, 0, NOW()),
  (NULL, 'movie', 'The Departed', 2006, 0, NOW()),
  (NULL, 'movie', 'The Descendants', 2011, 0, NOW()),
  (NULL, 'movie', 'The Devil Wears Prada', 2006, 0, NOW()),
  (NULL, 'movie', 'The Family Stone', 2005, 0, NOW()),
  (NULL, 'movie', 'The Firm', 1993, 0, NOW()),
  (NULL, 'movie', 'The First Wives Club', 1996, 0, NOW()),
  (NULL, 'movie', 'The Fugitive', 1993, 0, NOW()),
  (NULL, 'movie', 'The Game', 1997, 0, NOW()),
  (NULL, 'movie', 'The Gift', 2015, 0, NOW()),
  (NULL, 'movie', 'The Girl with the Dragon Tattoo', 2011, 0, NOW()),
  (NULL, 'movie', 'The Good Girl', 2002, 0, NOW()),
  (NULL, 'movie', 'The Guest', 2014, 0, NOW()),
  (NULL, 'movie', 'The Holiday', 2006, 0, NOW()),
  (NULL, 'movie', 'The Housemaid', 2025, 0, NOW()),
  (NULL, 'movie', 'The Hunger Games', 2012, 0, NOW()),
  (NULL, 'movie', 'The Idea of You', 2024, 0, NOW()),
  (NULL, 'movie', 'The Insider', 1999, 0, NOW()),
  (NULL, 'movie', 'The Intern', 2015, 0, NOW()),
  (NULL, 'movie', 'The Invisible Man', 2020, 0, NOW()),
  (NULL, 'movie', 'The Lake House', 2006, 0, NOW()),
  (NULL, 'movie', 'The Lincoln Lawyer', 2011, 0, NOW()),
  (NULL, 'movie', 'The Others', 2001, 0, NOW()),
  (NULL, 'movie', 'The Pelican Brief', 1993, 0, NOW()),
  (NULL, 'movie', 'The Prestige', 2006, 0, NOW()),
  (NULL, 'movie', 'The Proposal', 2009, 0, NOW()),
  (NULL, 'movie', 'The Sisterhood of the Traveling Pants', 2005, 0, NOW()),
  (NULL, 'movie', 'The Talented Mr. Ripley', 1999, 0, NOW()),
  (NULL, 'movie', 'The Terminal', 2004, 0, NOW()),
  (NULL, 'movie', 'The Truman Show', 1998, 0, NOW()),
  (NULL, 'movie', 'The Ugly Truth', 2009, 0, NOW()),
  (NULL, 'movie', 'The Usual Suspects', 1995, 0, NOW()),
  (NULL, 'movie', 'The Vow', 2012, 0, NOW()),
  (NULL, 'movie', 'The Wedding Date', 2005, 0, NOW()),
  (NULL, 'movie', 'The Wedding Planner', 2001, 0, NOW()),
  (NULL, 'movie', 'The Wedding Singer', 1998, 0, NOW()),
  (NULL, 'movie', 'This Is 40', 2012, 0, NOW()),
  (NULL, 'movie', 'This Means War', 2012, 0, NOW()),
  (NULL, 'movie', 'Ticket to Paradise', 2022, 0, NOW()),
  (NULL, 'movie', 'Total Recall', 1990, 0, NOW()),
  (NULL, 'movie', 'Trading Places', 1983, 0, NOW()),
  (NULL, 'movie', 'Twins', 1988, 0, NOW()),
  (NULL, 'movie', 'Two Weeks Notice', 2002, 0, NOW()),
  (NULL, 'movie', 'Uptown Girls', 2003, 0, NOW()),
  (NULL, 'movie', 'What Dreams May Come', 1998, 0, NOW()),
  (NULL, 'movie', 'What Happens in Vegas', 2008, 0, NOW()),
  (NULL, 'movie', 'What If', 2013, 0, NOW()),
  (NULL, 'movie', 'What Lies Beneath', 2000, 0, NOW()),
  (NULL, 'movie', 'What Women Want', 2000, 0, NOW()),
  (NULL, 'movie', 'When Harry Met Sally', 1989, 0, NOW()),
  (NULL, 'movie', 'Where the Crawdads Sing', 2022, 0, NOW()),
  (NULL, 'movie', 'Where the Heart Is', 2000, 0, NOW()),
  (NULL, 'movie', 'While You Were Sleeping', 1995, 0, NOW()),
  (NULL, 'movie', 'Wonder Woman', 2017, 0, NOW()),
  (NULL, 'movie', 'You''ve Got Mail', 1998, 0, NOW()),
  (NULL, 'movie', 'Zodiac', 2007, 0, NOW()),
  (NULL, 'movie', 'Zoolander', 2001, 0, NOW());

-- Demo user 1's records
-- rating: NULL Unrated, -1 Dislike, 0 Neutral, 1 Like, 2 Love | watch_again: NULL Not set
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 1, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = '10 Things I Hate About You';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = '12 Monkeys';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = '50 First Dates';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 1, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'A Simple Favor';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Air';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'American Psycho';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 2, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'An Officer and a Gentleman';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Anywhere But Here';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Are You There God? It''s Me, Margaret.';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Armageddon';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Big Daddy';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Blow';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Blue Crush';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Booksmart';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Bridget Jones''s Diary';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 1, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Bring It On';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 2, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Clueless';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Coyote Ugly';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Crazy Rich Asians';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 1, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Crazy, Stupid, Love';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Crossroads';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 1, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Dead Poets Society';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Death Becomes Her';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Deep Water';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Dirty Dancing';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Dogma';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Dumb and Dumber';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 1, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Dune: Part Two';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 1, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Easy A';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 2, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Eat Pray Love';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Edward Scissorhands';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Eileen';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Enough Said';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Eternal Sunshine of the Spotless Mind';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Face/Off';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Fatal Attraction';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Fool''s Gold';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Footloose';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Forces of Nature';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Four Weddings and a Funeral';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Freaky Friday';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Freeway';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 1, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Game Night';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Go';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Hanging Up';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'He Went That Way';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'His Three Daughters';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Hope Floats';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 2, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'How to Lose a Guy in 10 Days';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 1, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'I, Tonya';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Jawbreaker';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Jerry Maguire';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Josie and the Pussycats';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Just Like Heaven';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 2, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Just Married';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'not_interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Knives Out';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'L.A. Confidential';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Leave the World Behind';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 1, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Legally Blonde';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Liar Liar';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Life of Pi';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 2, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Little Black Book';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Little Women';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Magnolia';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Mean Girls';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Memento';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Mermaids';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Michael';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 1, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Miss Congeniality';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Monte Carlo';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Moonstruck';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Mother of the Bride';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 2, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Mr. Deeds';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Mrs. Doubtfire';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Mulholland Drive';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 1, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'My Best Friend''s Wedding';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Mystic Pizza';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Never Been Kissed';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'No Hard Feelings';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Notting Hill';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Ocean''s Eleven';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Office Space';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Oppenheimer';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Phenomenon';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 2, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Plus One';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 2, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Practical Magic';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 2, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Presumed Innocent';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Pulp Fiction';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Punch-Drunk Love';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Ready Player One';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Reality';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Reality Bites';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Risky Business';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 2, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Runaway Bride';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 2, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Save the Last Dance';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Say Anything';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Scent of a Woman';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Serendipity';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Set It Up';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'She''s All That';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Shutter Island';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Sister Act';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 1, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Sleepless in Seattle';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Some Kind of Wonderful';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Spaceman';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Speed';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'St. Elmo''s Fire';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Steel Magnolias';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 1, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Stepmom';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Sweet Home Alabama';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 2, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Terms of Endearment';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'That Thing You Do';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'The Batman';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'The Big Sick';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 1, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'The Butterfly Effect';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'The Departed';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 1, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'The Firm';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 1, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'The First Wives Club';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'The Fugitive';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'The Good Girl';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'The Guest';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'The Hunger Games';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'The Idea of You';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'The Insider';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 1, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'The Others';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'The Pelican Brief';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'The Sisterhood of the Traveling Pants';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'The Talented Mr. Ripley';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'The Terminal';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 2, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'The Truman Show';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'The Ugly Truth';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'The Usual Suspects';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'The Vow';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 2, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'The Wedding Date';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'The Wedding Planner';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 2, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'The Wedding Singer';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'This Is 40';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'This Means War';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Ticket to Paradise';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Top Gun: Maverick';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Total Recall';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Trading Places';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Twins';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Uptown Girls';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'What Dreams May Come';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 1, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'What Lies Beneath';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 2, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'What Women Want';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'When Harry Met Sally';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Where the Crawdads Sing';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Where the Heart Is';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'While You Were Sleeping';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Wonder Woman';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'You''ve Got Mail';
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'alyssa' AND t.media_type = 'movie' AND t.title = 'Zoolander';
