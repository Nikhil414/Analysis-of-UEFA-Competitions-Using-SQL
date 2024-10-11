CREATE TABLE matches (
    match_id VARCHAR(50) PRIMARY KEY,  -- Unique match identifier
    season VARCHAR(20),                -- Season in which the match took place
    date VARCHAR(10),                  -- Date in DD-MM-YYYY format
    home_team VARCHAR(100),            -- Home team name
    away_team VARCHAR(100),            -- Away team name
    stadium VARCHAR(100),              -- Stadium where the match was played
    home_team_score INT,               -- Score of the home team
    away_team_score INT,               -- Score of the away team
    penalty_shoot_out INT,             -- 1 if penalty shootout happened, 0 if not
    attendance INT                     -- Number of spectators
);

COPY matches(match_id, season, date, home_team, away_team, stadium, home_team_score, away_team_score, penalty_shoot_out, attendance)
FROM 'E:/Cuvette Learning Exercise/Project_Final/SQL/Matches.csv'
DELIMITER ',' 
CSV HEADER;


SELECT * from Matches
