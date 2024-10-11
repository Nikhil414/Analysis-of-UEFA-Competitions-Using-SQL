CREATE TABLE players (
    player_id VARCHAR(50) PRIMARY KEY,   -- Unique player identifier
    first_name VARCHAR(100),             -- First name of the player
    last_name VARCHAR(100),              -- Last name of the player
    nationality VARCHAR(50),             -- Player's nationality
    dob DATE,                            -- Date of birth in YYYY-MM-DD format
    team VARCHAR(100),                   -- Team the player currently plays for
    jersey_number FLOAT,                 -- Jersey number (as float due to decimal possibility)
    position VARCHAR(50),                -- Playing position (e.g., Defender, Midfielder)
    height FLOAT,                        -- Height in centimeters
    weight FLOAT,                        -- Weight in kilograms
    foot CHAR(1)                         -- Preferred foot ('R' = Right, 'L' = Left)
);


COPY players(player_id, first_name, last_name, nationality, dob, team, jersey_number, position, height, weight, foot)
FROM 'E:/Cuvette Learning Exercise/Project_Final/SQL/Players.csv'
DELIMITER ',' 
CSV HEADER;


SELECT * from players