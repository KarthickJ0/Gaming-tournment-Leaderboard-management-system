CREATE DATABASE GamingTournamentDB;
USE GamingTournamentDB;

CREATE TABLE Players (
    player_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    join_date DATE DEFAULT (CURRENT_DATE)
    
);

CREATE TABLE Games (
    game_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    genre VARCHAR(50) NOT NULL
);



CREATE TABLE Matches (
    match_id INT AUTO_INCREMENT PRIMARY KEY,
    game_id INT,
    player1_id INT,
    player2_id INT,
    winner_id INT,
    match_date DATETIME DEFAULT (CURRENT_TIMESTAMP),
    FOREIGN KEY (game_id) REFERENCES Games(game_id),
    FOREIGN KEY (player1_id) REFERENCES Players(player_id),
    FOREIGN KEY (player2_id) REFERENCES Players(player_id),
    FOREIGN KEY (winner_id) REFERENCES Players(player_id)
);


CREATE TABLE Leaderboard (
    leaderboard_id INT AUTO_INCREMENT PRIMARY KEY,
    player_id INT,
    total_wins INT DEFAULT 0,
    total_matches INT DEFAULT 0,
    rank_position INT,
    FOREIGN KEY (player_id) REFERENCES Players(player_id)
);



CREATE TABLE Prizes (
    prize_id INT AUTO_INCREMENT PRIMARY KEY,
    match_id INT,
    player_id INT,
    prize_money DECIMAL(10,2),
    prize_date DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (match_id) REFERENCES Matches(match_id),
    FOREIGN KEY (player_id) REFERENCES Players(player_id)
);



SELECT 
    m.match_id,
    g.title AS game_name,
    p1.name AS player1,
    p2.name AS player2,
    pw.name AS winner,
    m.match_date
FROM Matches m
JOIN Games g ON m.game_id = g.game_id
JOIN Players p1 ON m.player1_id = p1.player_id
JOIN Players p2 ON m.player2_id = p2.player_id
JOIN Players pw ON m.winner_id = pw.player_id;



DELIMITER //

CREATE PROCEDURE online_game(
    IN p_game_id INT,
    IN p_title VARCHAR(100),
    IN p_genre VARCHAR(50)
)
BEGIN                        
    INSERT INTO Games (game_id, title, genre)
    VALUES (p_game_id, p_title, p_genre);
END //

DELIMITER ;

CALL online_game(1080, 'Free Fire', 'Action');

SHOW CREATE PROCEDURE online_game;

SELECT * FROM Games;


SHOW PROCEDURE STATUS WHERE Db = 'GamingTournamentDB';

DELIMITER //

CREATE PROCEDURE GetMatchDetails()
BEGIN
    SELECT 
        m.match_id,
        g.title AS game_name,
        p1.name AS player1,
        p2.name AS player2,
        pw.name AS winner,
        m.match_date
    FROM Matches m
    JOIN Games g ON m.game_id = g.game_id
    JOIN Players p1 ON m.player1_id = p1.player_id
    JOIN Players p2 ON m.player2_id = p2.player_id
    JOIN Players pw ON m.winner_id = pw.player_id;
END //

DELIMITER ; -- Show Matches with Player Names and Winners

call GetMatchDetails();

DELIMITER //

CREATE PROCEDURE leaderboard_ranking()
BEGIN
    SELECT 
        l.rank_position,
        p.name AS player_name,
        l.total_wins,
        l.total_matches
    FROM Leaderboard l
    JOIN Players p ON l.player_id = p.player_id
    ORDER BY l.rank_position ASC;
END //

DELIMITER ; -- shows leaderboard_ranking 



DELIMITER //

CREATE PROCEDURE TOP5players_mostwins()
BEGIN 
    SELECT 
    p.name AS player_name,
    l.total_wins
FROM Leaderboard l
JOIN Players p ON l.player_id = p.player_id
ORDER BY l.total_wins DESC
LIMIT 5;

END //

DELIMITER ; -- shows  TOP5players_mostwins


DELIMITER //

CREATE PROCEDURE Total_matchesplayed()
BEGIN 
    SELECT 
    g.title AS game_name,
    COUNT(m.match_id) AS total_matches
FROM Matches m
JOIN Games g ON m.game_id = g.game_id
GROUP BY g.title
ORDER BY total_matches DESC;

END //

DELIMITER ; -- Total Matches Played for Each Game



DELIMITER //
CREATE PROCEDURE Prize_money_disturbition()
BEGIN 
    SELECT 
    p.name AS player_name,
    SUM(pr.prize_money) AS total_prize_money
FROM Prizes pr
JOIN Players p ON pr.player_id = p.player_id
GROUP BY p.name
ORDER BY total_prize_money DESC;

END//
DELIMITER ;  -- Finds which players won the most prize money



DELIMITER //

CREATE PROCEDURE Match_history_johndoe()
BEGIN
    SELECT 
    m.match_id,
    g.title AS game_name,
    p1.name AS player1,
    p2.name AS player2,
    pw.name AS winner,
    m.match_date
FROM Matches m
JOIN Games g ON m.game_id = g.game_id
JOIN Players p1 ON m.player1_id = p1.player_id
JOIN Players p2 ON m.player2_id = p2.player_id
JOIN Players pw ON m.winner_id = pw.player_id
WHERE p1.name = 'John Doe' OR p2.name = 'John Doe';
END //

DELIMITER ; --  Finds all matches played by a specific player


DELIMITER //

CREATE PROCEDURE Win_percentage_eachpalyer()

BEGIN
    SELECT 
    p.name AS player_name,
    (l.total_wins / NULLIF(l.total_matches, 0)) * 100 AS win_percentage
FROM Leaderboard l
JOIN Players p ON l.player_id = p.player_id
ORDER BY win_percentage DESC;

END//

DELIMITER ;  --  Calculates and sorts players by their win percentage



DELIMITER //

CREATE PROCEDURE top_3_players()

BEGIN
    SELECT 
    p.name AS player_name,
    COUNT(pr.prize_id) AS total_prizes_won
FROM Prizes pr
JOIN Players p ON pr.player_id = p.player_id
GROUP BY p.name
ORDER BY total_prizes_won DESC
LIMIT 3;

END//

DELIMITER ; -- Finds the top 3 players with the most prizes.
 
 
 DELIMITER //
 CREATE PROCEDURE Retrieve_Match_Details()
 
BEGIN
     SELECT 
    m.match_id, 
    g.title AS game_name, 
    p1.name AS player1, 
    p2.name AS player2, 
    pw.name AS winner, 
    m.match_date
FROM Matches m
JOIN Games g ON m.game_id = g.game_id
JOIN Players p1 ON m.player1_id = p1.player_id
JOIN Players p2 ON m.player2_id = p2.player_id
JOIN Players pw ON m.winner_id = pw.player_id
WHERE g.title = 'Free Fire';

END //
DELIMITER ; -- Retrieve Match Details for a Specific Game

CREATE PROCEDURE GetLatestMatches()
BEGIN
    SELECT 
        m.match_id,
        g.title AS game_name,
        p1.name AS player1,
        p2.name AS player2,
        pw.name AS winner,
        m.match_date
    FROM matches m
    JOIN games g ON m.game_id = g.game_id
    JOIN players p1 ON m.player1_id = p1.player_id
    JOIN players p2 ON m.player2_id = p2.player_id
    JOIN players pw ON m.winner_id = pw.player_id
    ORDER BY m.match_date DESC
    LIMIT 10;
END //

DELIMITER ; -- See the latest match results.


CREATE VIEW GamesWithoutMatches AS
SELECT g.title 
FROM Games g
LEFT JOIN Matches m ON g.game_id = m.game_id
WHERE m.match_id IS NULL; -- View for Games Without Any Matches


CREATE VIEW PlayersMultiplePrizes AS
SELECT 
    p.name AS player_name, 
    COUNT(pr.prize_id) AS total_prizes
FROM Prizes pr
JOIN Players p ON pr.player_id = p.player_id
GROUP BY p.name
HAVING COUNT(pr.prize_id) > 1; -- View for Players With More Than One Tournament Prize

CREATE VIEW PlayersWithoutWins AS
SELECT p.name 
FROM Players p
LEFT JOIN Matches m ON p.player_id = m.winner_id
WHERE m.winner_id IS NULL; -- View for Players Who Never Won a Match

CREATE VIEW PlayerAveragePrize AS
SELECT 
    p.name AS player_name, 
    AVG(pr.prize_money) AS average_prize_money
FROM Prizes pr
JOIN Players p ON pr.player_id = p.player_id
GROUP BY p.name; -- View for Players and Their Average Prize Money

-- procedure 
call GetMatchDetails(); -- Show Matches with Player Names and Winners
call leaderboard_ranking() -- shows leaderboard rankings
call TOP5players_mostwins() -- shows  TOP5players_mostwins
call Total_matchesplayed() -- Total Matches Played for Each Game
call Prize_money_disturbition() -- Finds which players won the most prize money
call Match_history_johndoe() --  Finds all matches played by a specific player
call  Win_percentage_eachpalyer() -- Calculates and sorts players by their win percentage
call top_3_players() -- Finds the top 3 players with the most prizes.
call Retrieve_Match_Details() -- Retrieve Match Details for a Specific Game
call GetLatestMatches() --  See the latest match results.

-- view
SELECT * FROM GamesWithoutMatches; --  View for Games Without Any Matches
SELECT * FROM PlayersWithoutWins;  -- View for Players With More Than One Tournament Prize
SELECT * FROM PlayersWithoutWins;  -- -- View for Players Who Never Won a Match
SELECT * FROM PlayerAveragePrize ORDER BY average_prize_money DESC;   -- View for Players and Their Average Prize Money


 


































































































































































