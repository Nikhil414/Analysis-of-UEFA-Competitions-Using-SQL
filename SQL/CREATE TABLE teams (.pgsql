CREATE TABLE teams (
    team_name VARCHAR(100) PRIMARY KEY,  -- Name of the team (set as primary key assuming it's unique)
    country VARCHAR(50),                -- Country where the team is based
    home_stadium VARCHAR(100)           -- Name of the team's home stadium
);


COPY teams(team_name, country, home_stadium)
FROM 'E:/Cuvette Learning Exercise/Project_Final/SQL/Teams.csv'
DELIMITER ',' 
CSV HEADER;


select * from Teams

