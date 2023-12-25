/* Intialisation des tables */

CREATE TABLE users (
    us_id SERIAL NOT NULL,
    us_email varchar(40) NOT NULL,
    us_password varchar(15) NOT NULL,
    PRIMARY KEY (us_id)
);

CREATE TABLE movies (
    mv_id SERIAL NOT NULL,
    mv_name varchar(40) NOT NULL,
    mv_duration time NOT NULL,
    mv_director varchar(50) NOT NULL,
    mv_release_date date NOT NULL,
    PRIMARY KEY (mv_id)
);

CREATE TABLE directors (
    dir_id SERIAL NOT NULL,
    dir_name varchar(40) NOT NULL,
    dir_first_name varchar(40) NOT NULL,
    PRIMARY KEY (dir_id)
);

CREATE TABLE actors (
    act_id SERIAL NOT NULL,
    act_name varchar(40) NOT NULL,
    act_first_name varchar(40) NOT NULL,
    act_birth_date date NOT NULL,
    PRIMARY KEY (act_id)
);

/* Ajout des contraintes : dates de création et des dates de modifications */

ALTER TABLE users
ADD COLUMN us_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE users
ADD COLUMN us_updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE movies
ADD COLUMN mv_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE movies
ADD COLUMN mv_updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE directors
ADD COLUMN dir_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE directors
ADD COLUMN dir_updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE actors
ADD COLUMN act_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE actors
ADD COLUMN act_updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

/* Ajout des clés etrangères et des tableaux liés */

/* Ajout de la clé etrangère "dir-id" au tableau "movies" */

ALTER TABLE movies
ADD COLUMN fk_mv_director SERIAL;

ALTER TABLE movies
ADD CONSTRAINT fk_movies_directors
FOREIGN KEY (fk_mv_director) REFERENCES directors(dir_id);

/* Création d'un tableau de liaison entre "users" et "movies" */

CREATE TABLE users_fav_movies (
    us_id SERIAL,
    mv_id SERIAL,
    PRIMARY KEY (us_id, mv_id),
    FOREIGN KEY (us_id) REFERENCES users(us_id),
    FOREIGN KEY (mv_id) REFERENCES movies(mv_id)
);

/* Création d'un tableau de liaison entre "movies" et "actors" */

CREATE TABLE movies_actors (
    mv_id SERIAL,
    act_id SERIAL,
    ma_is_lead_role boolean NOT NULL,
    ma_role varchar(40) NOT NULL,
    PRIMARY KEY (mv_id, act_id),
    FOREIGN KEY (mv_id) REFERENCES movies(mv_id),
    FOREIGN KEY (act_id) REFERENCES actors(act_id)
);

/* Ajout de data dans les différents tableaux */

INSERT INTO actors (act_name, act_first_name, act_birth_date) VALUES
('Dern', 'Laura', '1967-02-10'),
('Neill', 'Sam', '1947-09-14'),
('Goldblum', 'Jeff', '1952-10-22'),
('Ford', 'Harrison', '1942-07-13'),
('Kingsley', 'Ben', '1943-12-31'),
('Spielberg', 'Steven', '1946-12-18'),
('Carter', 'Johnny', '1968-07-23'),
('Green', 'Eva', '1980-07-05'),
('Rickman', 'Alan', '1946-02-21'),
('Depp', 'Johnny', '1963-06-09'),
('Ryder', 'Winona', '1971-10-29'),
('Bonham Carter', 'Helena', '1966-05-26'),
('Hanks', 'Tom', '1956-07-09'),
('Keaton', 'Micheal', '1951-09-05'),
('McGregor', 'Ewan', '1971-03-31'),
('Thomas', 'Henry', '1971-03-31'),
('Dreyfuss', 'Richard', '1947-10-29');

INSERT INTO directors (dir_name, dir_first_name) VALUES
('Spielberg', 'Steven'),
('Burton', 'Tim');

INSERT INTO movies (mv_name, mv_duration, fk_mv_director, mv_director, mv_release_date) VALUES
('Jurassic Park', '02:07:00', 1, 'Steven Spielberg', '1993-06-11'),
('E.T. the Extra-Terrestrial', '01:55:00', 1, 'Steven Spielberg', '1982-06-11'),
('Schindler''s List', '03:15:00', 1, 'Steven Spielberg', '1993-12-15'),
('Saving Private Ryan', '02:49:00', 1, 'Steven Spielberg', '1998-07-24'),
('Indiana Jones and the Last Crusade', '02:07:00', 1, 'Steven Spielberg', '1989-05-24'),
('Close Encounters of the Third Kind', '02:15:00', 1, 'Steven Spielberg', '1977-11-16'),
('Edward Scissorhands', '01:45:00', 2, 'Tim Burton', '1990-12-06'),
('Beetlejuice', '01:32:00', 2, 'Tim Burton', '1988-03-30'),
('Alice in Wonderland', '01:48:00', 2, 'Tim Burton', '2010-03-05'),
('Corpse Bride', '01:17:00', 2, 'Tim Burton', '2005-09-12'),
('Batman Returns', '02:06:00', 2, 'Tim Burton', '1992-06-19'),
('Big Fish', '02:05:00', 2, 'Tim Burton', '2003-12-10'),
('Dark shadows', '01:50:00', 2, 'Tim Burton', '2012-07-08');

INSERT INTO users (us_email, us_password) VALUES
('Kuro', '123456'),
('Enguerran', '78910');

INSERT INTO users_fav_movies (us_id, mv_id) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(1, 5),
(1, 6),
(2, 7),
(2, 8),
(2, 9),
(2, 10),
(1, 11),
(1, 12),
(2, 13);

INSERT INTO movies_actors (mv_id, act_id, ma_is_lead_role, ma_role) VALUES
(1, 1, true, 'Pr Ellie Sattler'),
(1, 2, true, 'Pr Allan Grant'),
(1, 3, false, 'Ian Malcolm'),
(2, 16, true, 'Eliott'),
(2, 6, false, 'A doctor when E.T got captured'),
(3, 5, false, 'Itzhak Stern'),
(4, 13, true, 'Captain John H Miller'),
(5, 4, true, 'Pr Indiana Jones'),
(6, 17, true, 'Roy Neary'),
(7, 10, true, 'Edward'),
(8, 11, false, 'Lydia Deetz'),
(9, 12, false, 'The red queen'),
(9, 9, false, 'Absolem'),
(10, 10, true, 'Victor Van Dort'),
(10, 12, true, 'Emily'),
(11, 14, true, 'Batman'),
(12, 15, true, 'Edward Bloom young'),
(13, 8, false, 'Angelique Bouchard');

