

--All Question and Answers

--Q.1 1)Count the Total Number of Teams

select * from teams;
select count(*) as total_teams from teams;


--2)Find the Number of Teams per Country

select country, count(*) as number_of_teams from teams group by country 
order by number_of_teams ASC;


--3)Calculate the Average Team Name Length

select round(avg(length(team_name)), 2) as avg_team_name_length from teams;


--4)Calculate the Average Stadium Capacity in Each Country round it off and sort by the total stadiums in the country.

select country,
round(avg(capacity)) as avg_capacity,
count(*) as total_stadiums
from stadiums
group by country
order by total_stadiums asc;

--5)Calculate the Total Goals Scored.

select count(*) as total_goals from goals;

--6)Find the total teams that have city in their names

select count(*) as teams_with_city from teams
where team_name ilike '%city%';

--7) Use Text Functions to Concatenate the Team's Name and Country

select concat(team_name, ' _ ', country) as team_country from teams;


--8) What is the highest attendance recorded in the dataset, and which match (including home and away teams, and date) does it correspond to?

select match_id, home_team, away_team, date, attendance from matches
where attendance = (select max(attendance) from matches);

--9)What is the lowest attendance recorded in the dataset, and which match (including home and away teams, and date) does it correspond to set the criteria as greater than 1 as some matches had 0 attendance because of covid.

select match_id, home_team, away_team, date, attendance from matches
where attendance > 1 and attendance = (select min(attendance) from matches where attendance > 1);

--10) Identify the match with the highest total score (sum of home and away team scores) in the dataset. Include the match ID, home and away teams, and the total score.

select match_id, home_team, away_team, home_team_score + away_team_score as total_score from matches
order by total_score desc limit 1;

--11)Find the total goals scored by each team, distinguishing between home and away goals. Use a CASE WHEN statement to differentiate home and away goals within the subquery

select team_name,
sum(case when home_team = team_name then home_team_score else 0 end) as home_goals,
sum(case when away_team = team_name then away_team_score else 0 end) as away_goals
from matches join teams on home_team = team_name or away_team = team_name
group by team_name

--12) windows function - Rank teams based on their total scored goals (home and away combined) using a window function.In the stadium Old Trafford.

SELECT team_name, 
       RANK() OVER (ORDER BY total_goals DESC) AS rank,
       total_goals
FROM (
    SELECT team_name, 
           SUM(home_team_score + away_team_score) AS total_goals
    FROM Matches
    JOIN Teams ON (home_team = team_name OR away_team = team_name)
    WHERE stadium = 'Old Trafford'
    GROUP BY team_name
) ranked_teams;


--13) TOP 5 l players who scored the most goals in Old Trafford, ensuring null values are not included in the result (especially pertinent for cases where a player might not have scored any goals).

SELECT p.player_id, p.first_name, p.last_name, COUNT(g.goal_id) AS total_goals
FROM Players p
JOIN Goals g ON p.player_id = g.pid
JOIN Matches m ON g.match_id = m.match_id
WHERE m.stadium = 'Old Trafford'
GROUP BY p.player_id
ORDER BY total_goals DESC
LIMIT 5;


--14)Write a query to list all players along with the total number of goals they have scored. Order the results by the number of goals scored in descending order to easily identify the top 6 scorers.

SELECT p.player_id, p.first_name, p.last_name, COUNT(g.goal_id) AS total_goals
FROM Players p
LEFT JOIN Goals g ON p.player_id = g.pid
GROUP BY p.player_id
ORDER BY total_goals DESC
LIMIT 6;


--15)Identify the Top Scorer for Each Team - Find the player from each team who has scored the most goals in all matches combined. This question requires joining the Players, Goals, and possibly the Matches tables, and then using a subquery to aggregate goals by players and teams.

SELECT team, player_id, first_name, last_name, MAX(goal_count) AS top_goals
FROM (
    SELECT p.player_id, p.first_name, p.last_name, p.team, COUNT(g.goal_id) AS goal_count
    FROM Players p
    JOIN Goals g ON p.player_id = g.pid
    GROUP BY p.player_id, p.first_name, p.last_name, p.team
) AS player_goals
GROUP BY team, player_id, first_name, last_name
ORDER BY top_goals DESC;


--16)Find the Total Number of Goals Scored in the Latest Season - Calculate the total number of goals scored in the latest season available in the dataset. This question involves using a subquery to first identify the latest season from the Matches table, then summing the goals from the Goals table that occurred in matches from that season.

SELECT SUM(home_team_score + away_team_score) AS total_goals
FROM Matches
WHERE season = (SELECT MAX(season) FROM Matches);


--17)Find Matches with Above Average Attendance - Retrieve a list of matches that had an attendance higher than the average attendance across all matches. This question requires a subquery to calculate the average attendance first, then use it to filter matches.

WITH avg_attendance AS (
    SELECT AVG(attendance) AS average_attendance
    FROM Matches
)
SELECT match_id, home_team, away_team, attendance
FROM Matches
WHERE attendance > (SELECT average_attendance FROM avg_attendance);


--18)Find the Number of Matches Played Each Month - Count how many matches were played in each month across all seasons. This question requires extracting the month from the match dates and grouping the results by this value. as January Feb march

SELECT TO_CHAR(TO_DATE(date, 'DD-MM-YYYY'), 'Month') AS month, COUNT(*) AS matches_played
FROM Matches
GROUP BY month
ORDER BY month;
