CREATE DATABASE facebook;

USE facebook;

CREATE TABLE user (
user_id INT NOT NULL,
fname CHAR(20) NOT NULL,
lname CHAR(50) NOT NULL,
birthday DATE,
email CHAR(50) NOT NULL,
password CHAR(32) NOT NULL,
PRIMARY KEY (user_id)
);

CREATE TABLE friendship (
sender INT NOT NULL,
receiver INT NOT NULL,
friendship_bday DATE,
INDEX(sender, receiver),
PRIMARY KEY (sender, receiver),
FOREIGN KEY (sender) REFERENCES user (user_id),
FOREIGN KEY (receiver) REFERENCES user (user_id)
);

CREATE TABLE wall_post (
post_id INT NOT NULL,
message CHAR(200) NOT NULL,
creator INT NOT NULL,
wall_owner INT NOT NULL,
PRIMARY KEY (post_id),
FOREIGN KEY (creator) REFERENCES user (user_id),
FOREIGN KEY (wall_owner) REFERENCES user (user_id)
);

CREATE TABLE comment (
comment_id INT NOT NULL,
message CHAR(100) NOT NULL,
user_id INT NOT NULL,
post_id INT NOT NULL,
PRIMARY KEY (comment_id),
FOREIGN KEY (user_id) REFERENCES user (user_id),
FOREIGN KEY (post_id) REFERENCES wall_post (post_id)
);

CREATE TABLE post_like (
user_id INT NOT NULL,
post_id INT NOT NULL,
PRIMARY KEY (user_id, post_id),
FOREIGN KEY (user_id) REFERENCES user (user_id),
FOREIGN KEY (post_id) REFERENCES wall_post (post_id)
);

CREATE TABLE comment_like (
user_id INT NOT NULL,
comment_id INT NOT NULL,
PRIMARY KEY (user_id, comment_id),
FOREIGN KEY (user_id) REFERENCES user (user_id),
FOREIGN KEY (comment_id) REFERENCES comment (comment_id)
);

INSERT INTO user VALUES
(1, 'Simon', 'Hansen', '1997-09-03', 'hansen@mail.dk', MD5('123SHansen')),
(2, 'Line', 'Søndergaard', '2002-11-14', 'lin.soendergaard@mail.dk', MD5('xpfMVP420')),
(3, 'Kim', 'Andersen', '1978-02-27', 'ka78@mail.dk', MD5('987kimKIM')),
(4, 'Josephine', 'Toft Mikkelsen', '1994-05-01', 'jose@mail.dk', MD5('M1kk3153n')),
(5, 'Hanne', 'Linnet', '1982-12-24', 'gomail@live.com', MD5('lin123lin123')),
(6, 'Helge Biver', 'Strande', '1965-10-13', 'Strand@gmail.dk', MD5('rtf65plus94fisk')),
(7, 'Clara', 'Tinglef', NULL, 'ct@yahoo.dk', MD5('claraaralc')),
(8, 'Kasper', 'Holst', '1980-09-20', 'Kapper17@mail.dk', MD5('gosportgo'));

INSERT INTO friendship VALUES
(1, 2, '2018-11-05'),
(4, 7, '2019-04-09'),
(6, 3, '2020-08-11'),
(1, 8, '2019-03-26'),
(7, 2, '2017-10-10'),
(7, 8, NULL),
(5, 3, NULL),
(6, 5, NULL);

INSERT INTO wall_post VALUES
(1, 'Så er det snart søndag, så skal der golfes!', 3, 6),
(2, 'Tillykke med fødselsdagen!', 4, 7),
(3, 'Kom med ind og se mit nye dukketeater.', 5, 5),
(4, 'Tjek lige den her opskrift', 1, 8);

INSERT INTO comment VALUES
(1, 'Jada, glæder mig', 6, 1),
(2, 'Tusind tak, jeg havde en super dag.', 7, 2),
(3, 'Det ser lækkert ud.', 8, 4),
(4, 'Dejligt at høre, tillykke fra mig også.', 2, 2);

INSERT INTO post_like VALUES
(6, 1),
(8, 4),
(7, 2),
(5, 3);

INSERT INTO comment_like VALUES
(3, 1),
(7, 4),
(2, 2);


-- Opgave 1 
-- Find alle kommentar tekster til posts som Kim har lavet
SELECT comment.message
FROM comment
JOIN wall_post ON comment.post_id = wall_post.post_id
JOIN user ON wall_post.creator = user.user_id
WHERE user.fname = 'Kim';

--Opgave 2
--Hvem har liket Josephines posts? Find fname og lname på alle der har liket en post af Josephine.

SELECT u_liked.fname, u_liked.lname 
FROM user u_liked
JOIN post_like ON u_liked.user_id = post_like.user_id
JOIN wall_post ON wall_post.post_id = post_like.post_id
JOIN user u_creator ON wall_post.creator = u_creator.user_id
WHERE u_creator.fname = 'Josephine';


--Opgave 3
--Du ved at én af brugerne har adgangskoden 'gosportgo' men du ved ikke hvem. 
--Skriv et query der kan finde fname og lname for indehaveren af adgangskoden. 

--A MD5 encrypted string cannot be decrypted since it is a one way algorithm

SELECT fname, lname
FROM user
WHERE password = MD5("gosportgo");


--Opgave 4
--Lav en liste over navn på brugerne og tal på hvor mange kommentarer hver bruger har fået på sine posts, sorter listen efter hvem der har fået flest.

SELECT u.fname, u.lname, COUNT(c.comment_id) AS comment_count
FROM user u
JOIN wall_post wp ON u.user_id = wp.creator
LEFT JOIN comment c ON wp.post_id = c.post_id
GROUP BY u.user_id
ORDER BY comment_count DESC;


--Opgave 5
--Du synes ikke det er så kønt med 2 fornavne. Hvis en bruger har 2 fornavne, så opdater brugeren ved at fjerne det sidste fornavn fra fname, 
--og læg det til starten på lname, HINT: For at finde det første ord i en streng brug REGEXP_SUBSTR( <STRING> , '^[a-z]+')


--REGEXP line outputs 1 if there is a second name
--it's selecting the user_id of users whose fname ends with a space and one or more lowercase letters.
CREATE TEMPORARY TABLE temp_user_ids AS (
  SELECT user_id
  FROM user
  WHERE fname REGEXP ' [a-z]+$'
);

--Joins user table with temp_user_ids
--REGEXP_RAPLCE removes the last word of fname if it's a sequence of lowercase letters
--CONCAT concatenating the last word of fname (if it's a sequence of lowercase letters), a space and the current lname.
UPDATE user
JOIN temp_user_ids
ON user.user_id = temp_user_ids.user_id
SET fname = REGEXP_REPLACE(fname, ' [a-z]+$', ''),
    lname = CONCAT(REGEXP_SUBSTR(fname, '[a-z]+$'), ' ', lname);

DROP TABLE temp_user_ids;

