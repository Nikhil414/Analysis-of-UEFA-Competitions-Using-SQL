CREATE TABLE stadiums (
    name VARCHAR(255),
    city VARCHAR(100),
    country VARCHAR(100),
    capacity INTEGER,
    PRIMARY KEY (name)
);


drop table stadiums


ALTER TABLE stadiums DROP CONSTRAINT stadium_pkey;
ALTER TABLE stadiums ADD PRIMARY KEY (name, city);



COPY stadiums(name, city, country, capacity)
FROM 'E:/Cuvette Learning Exercise/Project_Final/SQL/Stadiums.csv'
DELIMITER ','
CSV HEADER;


select * from stadiums

