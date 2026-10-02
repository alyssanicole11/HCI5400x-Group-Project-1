-- starter_data.sql - lookup lists, demo users, starter movies, and demo user 3
-- Owner: Alyssa (movie list chosen together)
-- Run AFTER schema.sql (phpMyAdmin -> your _db database -> SQL tab -> paste -> Go).
-- Then, when you want the bigger catalog, run starter_data_demo1.sql.
--
-- DEMO USERS
--   1 Alyssa & Mom: real history from our old watch lists (added by starter_data_demo1.sql)
--   2 Doanh:        starts completely blank (no services, no history)
--   3 Jordan:       a made-up demo person with a different taste on purpose:
--                   mysteries, thrillers, sci-fi, action
--                   (HBO Max, Prime Video, Peacock); includes Watch Again examples
--
-- MOVIES: 25 real movies with their real TMDb ids, chosen for variety
-- (genres, runtimes from 81 to 181 minutes). Year, runtime and genres are
-- typed from general knowledge; descriptions are our own one-liners.
-- tools/tmdb_seed.php replaces these with TMDb's official details and adds
-- posters, popularity, and streaming services.

-- Genres (TMDb's official genre ids)
INSERT INTO genres (tmdb_genre_id, genre_name) VALUES
  (28, 'Action'),
  (12, 'Adventure'),
  (16, 'Animation'),
  (35, 'Comedy'),
  (80, 'Crime'),
  (99, 'Documentary'),
  (18, 'Drama'),
  (10751, 'Family'),
  (14, 'Fantasy'),
  (36, 'History'),
  (27, 'Horror'),
  (10402, 'Music'),
  (9648, 'Mystery'),
  (10749, 'Romance'),
  (878, 'Science Fiction'),
  (10770, 'TV Movie'),
  (53, 'Thriller'),
  (10752, 'War'),
  (37, 'Western');

-- Streaming services (TMDb watch-provider ids for the US; tmdb_seed.php lists any it skips so we can double-check)
INSERT INTO services (service_name, tmdb_provider_id) VALUES
  ('Netflix', 8),
  ('Hulu', 15),
  ('Disney+', 337),
  ('HBO Max', 1899),
  ('Prime Video', 9),
  ('Apple TV+', 350),
  ('Peacock', 386),
  ('Paramount+', 531);

-- Demo users (user_id 1, 2, 3 in this order)
INSERT INTO users (username, display_name) VALUES
  ('alyssa', 'Alyssa & Mom (demo)'),
  ('doanh', 'Doanh (demo)'),
  ('jordan', 'Jordan (demo)');

-- Starter movies
INSERT INTO titles (tmdb_id, media_type, title, release_year, runtime, overview, poster_path, popularity_score, updated_at) VALUES
  (6435, 'movie', 'Practical Magic', 1998, 104, 'Two witch sisters try to break a family curse that dooms the men they love.', NULL, 0, NOW()),
  (77, 'movie', 'Memento', 2000, 113, 'A man with no short-term memory hunts his wife''s killer using notes and tattoos.', NULL, 0, NOW()),
  (346648, 'movie', 'Paddington 2', 2017, 104, 'Paddington is framed for stealing a pop-up book and lands in prison.', NULL, 0, NOW()),
  (546554, 'movie', 'Knives Out', 2019, 131, 'A detective untangles a wealthy family''s lies after the patriarch''s death.', NULL, 0, NOW()),
  (76341, 'movie', 'Mad Max: Fury Road', 2015, 121, 'A desperate escape across the desert turns into one long chase.', NULL, 0, NOW()),
  (2493, 'movie', 'The Princess Bride', 1987, 98, 'A grandfather reads a tale of true love, pirates, and swordfights.', NULL, 0, NOW()),
  (419430, 'movie', 'Get Out', 2017, 104, 'A weekend visit to a girlfriend''s family turns deeply unsettling.', NULL, 0, NOW()),
  (27205, 'movie', 'Inception', 2010, 148, 'A thief who steals secrets from dreams is asked to plant an idea instead.', NULL, 0, NOW()),
  (129, 'movie', 'Spirited Away', 2001, 125, 'A girl must work in a spirit bathhouse to save her parents.', NULL, 0, NOW()),
  (120467, 'movie', 'The Grand Budapest Hotel', 2014, 100, 'A legendary concierge and his lobby boy get caught up in a stolen painting.', NULL, 0, NOW()),
  (862, 'movie', 'Toy Story', 1995, 81, 'A cowboy doll feels replaced when a flashy space ranger arrives.', NULL, 0, NOW()),
  (4348, 'movie', 'Pride & Prejudice', 2005, 129, 'Elizabeth Bennet and Mr. Darcy clash, misjudge each other, and fall in love.', NULL, 0, NOW()),
  (361743, 'movie', 'Top Gun: Maverick', 2022, 131, 'A veteran pilot trains young aviators for a nearly impossible mission.', NULL, 0, NOW()),
  (278, 'movie', 'The Shawshank Redemption', 1994, 142, 'A banker sentenced to life in prison holds on to hope over decades.', NULL, 0, NOW()),
  (346698, 'movie', 'Barbie', 2023, 114, 'Barbie leaves her perfect world and discovers the real one.', NULL, 0, NOW()),
  (329865, 'movie', 'Arrival', 2016, 116, 'A linguist tries to communicate with mysterious visitors from space.', NULL, 0, NOW()),
  (354912, 'movie', 'Coco', 2017, 105, 'A young musician journeys into the Land of the Dead to learn his family''s story.', NULL, 0, NOW()),
  (872585, 'movie', 'Oppenheimer', 2023, 181, 'The story of the physicist who led the creation of the atomic bomb.', NULL, 0, NOW()),
  (455207, 'movie', 'Crazy Rich Asians', 2018, 121, 'A professor meets her boyfriend''s super-wealthy family in Singapore.', NULL, 0, NOW()),
  (447332, 'movie', 'A Quiet Place', 2018, 90, 'A family survives in silence from creatures that hunt by sound.', NULL, 0, NOW()),
  (545611, 'movie', 'Everything Everywhere All at Once', 2022, 140, 'A laundromat owner jumps between universes to save her family.', NULL, 0, NOW()),
  (120, 'movie', 'The Lord of the Rings: The Fellowship of the Ring', 2001, 179, 'A hobbit sets out with a fellowship to destroy a dangerous ring.', NULL, 0, NOW()),
  (493922, 'movie', 'Hereditary', 2018, 127, 'After a death in the family, terrifying secrets begin to surface.', NULL, 0, NOW()),
  (9603, 'movie', 'Clueless', 1995, 97, 'A popular Beverly Hills teen plays matchmaker and learns about herself.', NULL, 0, NOW()),
  (10315, 'movie', 'Fantastic Mr. Fox', 2009, 87, 'A fox''s last big heist puts his family and friends in danger.', NULL, 0, NOW());

-- Which genres each movie has
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 6435 AND g.genre_name = 'Romance';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 6435 AND g.genre_name = 'Comedy';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 6435 AND g.genre_name = 'Fantasy';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 77 AND g.genre_name = 'Mystery';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 77 AND g.genre_name = 'Thriller';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 346648 AND g.genre_name = 'Adventure';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 346648 AND g.genre_name = 'Comedy';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 346648 AND g.genre_name = 'Family';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 546554 AND g.genre_name = 'Comedy';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 546554 AND g.genre_name = 'Crime';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 546554 AND g.genre_name = 'Mystery';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 76341 AND g.genre_name = 'Action';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 76341 AND g.genre_name = 'Adventure';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 76341 AND g.genre_name = 'Science Fiction';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 2493 AND g.genre_name = 'Adventure';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 2493 AND g.genre_name = 'Family';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 2493 AND g.genre_name = 'Fantasy';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 2493 AND g.genre_name = 'Comedy';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 2493 AND g.genre_name = 'Romance';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 419430 AND g.genre_name = 'Mystery';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 419430 AND g.genre_name = 'Thriller';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 419430 AND g.genre_name = 'Horror';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 27205 AND g.genre_name = 'Action';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 27205 AND g.genre_name = 'Science Fiction';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 27205 AND g.genre_name = 'Adventure';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 129 AND g.genre_name = 'Animation';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 129 AND g.genre_name = 'Family';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 129 AND g.genre_name = 'Fantasy';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 120467 AND g.genre_name = 'Comedy';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 120467 AND g.genre_name = 'Drama';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 862 AND g.genre_name = 'Animation';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 862 AND g.genre_name = 'Adventure';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 862 AND g.genre_name = 'Family';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 862 AND g.genre_name = 'Comedy';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 4348 AND g.genre_name = 'Drama';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 4348 AND g.genre_name = 'Romance';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 361743 AND g.genre_name = 'Action';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 361743 AND g.genre_name = 'Drama';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 278 AND g.genre_name = 'Drama';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 278 AND g.genre_name = 'Crime';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 346698 AND g.genre_name = 'Comedy';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 346698 AND g.genre_name = 'Adventure';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 329865 AND g.genre_name = 'Drama';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 329865 AND g.genre_name = 'Science Fiction';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 329865 AND g.genre_name = 'Mystery';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 354912 AND g.genre_name = 'Family';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 354912 AND g.genre_name = 'Animation';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 354912 AND g.genre_name = 'Fantasy';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 354912 AND g.genre_name = 'Music';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 354912 AND g.genre_name = 'Comedy';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 354912 AND g.genre_name = 'Adventure';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 872585 AND g.genre_name = 'Drama';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 872585 AND g.genre_name = 'History';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 455207 AND g.genre_name = 'Comedy';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 455207 AND g.genre_name = 'Romance';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 455207 AND g.genre_name = 'Drama';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 447332 AND g.genre_name = 'Horror';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 447332 AND g.genre_name = 'Drama';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 447332 AND g.genre_name = 'Science Fiction';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 545611 AND g.genre_name = 'Action';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 545611 AND g.genre_name = 'Adventure';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 545611 AND g.genre_name = 'Science Fiction';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 120 AND g.genre_name = 'Adventure';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 120 AND g.genre_name = 'Fantasy';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 120 AND g.genre_name = 'Action';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 493922 AND g.genre_name = 'Horror';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 493922 AND g.genre_name = 'Mystery';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 493922 AND g.genre_name = 'Thriller';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 9603 AND g.genre_name = 'Comedy';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 9603 AND g.genre_name = 'Romance';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 10315 AND g.genre_name = 'Adventure';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 10315 AND g.genre_name = 'Animation';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 10315 AND g.genre_name = 'Comedy';
INSERT INTO title_genres (title_id, genre_id) SELECT t.title_id, g.genre_id FROM titles t, genres g WHERE t.tmdb_id = 10315 AND g.genre_name = 'Family';

-- Demo user 3 (Jordan): services
INSERT INTO user_services (user_id, service_id) SELECT u.user_id, s.service_id FROM users u, services s WHERE u.username = 'jordan' AND s.service_name = 'HBO Max';
INSERT INTO user_services (user_id, service_id) SELECT u.user_id, s.service_id FROM users u, services s WHERE u.username = 'jordan' AND s.service_name = 'Prime Video';
INSERT INTO user_services (user_id, service_id) SELECT u.user_id, s.service_id FROM users u, services s WHERE u.username = 'jordan' AND s.service_name = 'Peacock';

-- Demo user 3 (Jordan): history
-- rating: NULL Unrated, -1 Dislike, 0 Neutral, 1 Like, 2 Love | watch_again: NULL Not set, 0 No, 1 Yes
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 2, 1, NOW(), NOW() FROM users u, titles t WHERE u.username = 'jordan' AND t.tmdb_id = 77;
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 2, 1, NOW(), NOW() FROM users u, titles t WHERE u.username = 'jordan' AND t.tmdb_id = 27205;
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 1, 0, NOW(), NOW() FROM users u, titles t WHERE u.username = 'jordan' AND t.tmdb_id = 76341;
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 1, 0, NOW(), NOW() FROM users u, titles t WHERE u.username = 'jordan' AND t.tmdb_id = 419430;
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', -1, 0, NOW(), NOW() FROM users u, titles t WHERE u.username = 'jordan' AND t.tmdb_id = 4348;
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 1, 1, NOW(), NOW() FROM users u, titles t WHERE u.username = 'jordan' AND t.tmdb_id = 361743;
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', 2, 1, NOW(), NOW() FROM users u, titles t WHERE u.username = 'jordan' AND t.tmdb_id = 120;
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'watched', -1, 0, NOW(), NOW() FROM users u, titles t WHERE u.username = 'jordan' AND t.tmdb_id = 9603;
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'jordan' AND t.tmdb_id = 872585;
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'jordan' AND t.tmdb_id = 545611;
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'jordan' AND t.tmdb_id = 493922;
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'not_interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'jordan' AND t.tmdb_id = 346698;
INSERT INTO user_titles (user_id, title_id, status, rating, watch_again, date_added, updated_at) SELECT u.user_id, t.title_id, 'not_interested', NULL, NULL, NOW(), NOW() FROM users u, titles t WHERE u.username = 'jordan' AND t.tmdb_id = 455207;
