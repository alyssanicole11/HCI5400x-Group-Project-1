-- schema.sql - creates the 8 MVP tables
-- Owner: Alyssa
-- Run this first in phpMyAdmin (your _db database -> SQL tab -> paste -> Go),
-- then run starter_data.sql.
-- Running it again deletes all tables and data and starts fresh.
-- BEFORE IMPORTING: look at your database's table list in phpMyAdmin. This file
-- deletes tables named users, titles, genres, title_genres, services,
-- title_services, user_titles and user_services if they exist. (The class
-- example tables sales, products and images are not touched.)

DROP TABLE IF EXISTS user_services;
DROP TABLE IF EXISTS user_titles;
DROP TABLE IF EXISTS title_services;
DROP TABLE IF EXISTS title_genres;
DROP TABLE IF EXISTS services;
DROP TABLE IF EXISTS genres;
DROP TABLE IF EXISTS titles;
DROP TABLE IF EXISTS users;

-- One row per demo user
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(30) NOT NULL UNIQUE,
    display_name VARCHAR(50) NOT NULL
);

-- One row per movie (TV later: media_type = 'tv')
-- media_type + tmdb_id is the movie's identity, so the same movie
-- is never stored twice.
CREATE TABLE titles (
    title_id INT AUTO_INCREMENT PRIMARY KEY,
    tmdb_id INT NULL,
    media_type VARCHAR(10) NOT NULL DEFAULT 'movie',
    title VARCHAR(200) NOT NULL,
    release_year INT NULL,
    runtime INT NULL,
    overview TEXT NULL,
    poster_path VARCHAR(100) NULL,
    popularity_score DECIMAL(10,3) NOT NULL DEFAULT 0,
    updated_at DATETIME NULL,
    UNIQUE (media_type, tmdb_id)
);

-- One row per genre
CREATE TABLE genres (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    tmdb_genre_id INT NULL UNIQUE,
    genre_name VARCHAR(40) NOT NULL UNIQUE
);

-- Which genres a movie has (a movie can have several)
CREATE TABLE title_genres (
    title_id INT NOT NULL,
    genre_id INT NOT NULL,
    PRIMARY KEY (title_id, genre_id)
);

-- One row per streaming service
CREATE TABLE services (
    service_id INT AUTO_INCREMENT PRIMARY KEY,
    service_name VARCHAR(40) NOT NULL UNIQUE,
    tmdb_provider_id INT NULL
);

-- Which services carry a movie
CREATE TABLE title_services (
    title_id INT NOT NULL,
    service_id INT NOT NULL,
    PRIMARY KEY (title_id, service_id)
);

-- What one user thinks about one movie (only one row per user + movie)
-- status:      'none', 'interested', 'watched', 'not_interested'
-- rating:      NULL = Unrated, -1 = Dislike, 0 = Neutral, 1 = Like, 2 = Love
-- watch_again: NULL = Not set, 0 = No, 1 = Yes
CREATE TABLE user_titles (
    user_id INT NOT NULL,
    title_id INT NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'none',
    rating TINYINT NULL,
    watch_again TINYINT NULL,
    date_added DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    PRIMARY KEY (user_id, title_id)
);

-- Which services a user has
CREATE TABLE user_services (
    user_id INT NOT NULL,
    service_id INT NOT NULL,
    PRIMARY KEY (user_id, service_id)
);
