CREATE TABLE goals (
    goal_id VARCHAR(50) PRIMARY KEY,  -- assuming goal IDs are unique and less than 50 characters
    match_id VARCHAR(50),
    pid VARCHAR(50),
    duration INT,                     -- stores the minute in the match the goal was scored
    assist VARCHAR(50),               -- player ID of the assist provider
    goal_desc TEXT                    -- description of the goal
);


COPY goals(goal_id, match_id, pid, duration, assist, goal_desc)
FROM 'E:/Cuvette Learning Exercise/Project_Final/SQL/goals.csv'
DELIMITER ',' 
CSV HEADER;


SELECT * from goals
