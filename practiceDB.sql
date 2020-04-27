/*Access*/
psql -U username -p Password

/*Create a new DB*/
CREATE DATABASE myDB

/*List all databases*/
\l

/*Delete DB*/
DROP DATABASE myDB

/*Creating table without constraints*/
CREATE TABLE person (
	Id int,
	First_name VARCHAR (50),
	Last_name VARCHAR (50),
	DoB DATE
)

/*Creating tables with constraints*/
CREATE TABLE person (
    Id BIGSERIAL NOT NULL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(5) NOT NULL,
    date_of_birth DATE NOT NULL
)

/*Creating table with constraints*/
CREATE TABLE person(
 id BIGSERIAL NOT NULL PRIMARY KEY,
 first_name VARCHAR(50) NOT NULL,
 last_name VARCHAR(50) NOT NULL,
 gender VARCHAR(7) NOT NULL,
 DoB DATE NOT NULL,
 email VARCHAR(150) );

/*Insert into table*/
INSERT INTO person (
    first_name,
    last_name,
    gender,
    DoB,
    email
)
VALUES ('DOOM', 'Slayer', 'Male', DATE '1988-01-09','doom_slayer@gmail.com');

/*Execute Commands from a file*/
\i path_to_file 
For path, use forward slashes.

/*SELECT Commands*/
SELECT * FROM person;

SELECT first_name, last_name FROM person;

/*ORDER BY*/
/*Sorts in ascending order*/
SELECT * FROM person ORDER BY country_of_birth ASC;
SELECT * FROM person ORDER BY country_of_birth, id, email DESC;

/*Distinct*/
/*Removes all duplicate entries from column country_of_birth, displays each entry once.*/
SELECT DISTINCT country_of_birth FROM person ORDER BY country_of_birth;

/*Where clause*/
/*Find particular entries in the table with the where clause*/
SELECT * FROM person WHERE gender = 'Female';
SELECT * FROM person WHERE gender = 'Male' AND country_of_birth = 'Poland';
SELECT * FROM person WHERE gender = 'Male' AND (country_of_birth = 'Poland' OR country_of_birth = 'China');
SELECT * FROM person WHERE gender = 'Male' AND (country_of_birth = 'Poland' OR country_of_birth = 'China') AND last_name = 'Pietersma';

/*Comparison Operators*/
SELECT 1 = 1;
    /*returns true*/
 SELECT 'string Comparison' <> 'string';
    /*returns false*/

/*Limit, Offset, Fetch*/
SELECT * FROM person LIMIT 10; /*Will show the first 10 records*/

SELECT * FROM person OFFSET 5 LIMIT 5; /*Will show the first 10 records from 6-10*/

SELECT * FROM person OFFSET 5 FETCH FIRST 5 ROW ONLY; /*Does the same job as limit*/


/*In*/
SELECT * FROM person WHERE country_of_birth IN ('China', 'Brazil', 'France');
/*Will display entries where country_of_birth are chosen, helps avoid having 
to write OR repeatedly for each country*/

/*Between*/
/*Find data in a range*/
SELECT * FROM person 
WHERE data_of_birth
BETWEEN DATE '2000-01-01' AND '2015-01-01';

/*Like and iLike*/
/*Getting data like a given param. %param or param% or %param%*/
SELECT * FROM person
WHERE email LIKE '%.com';

SELECT * FROM person
WHERE email LIKE '%@google.%';

% => represents anything


/*Group by*/
/*Group data by certain parameters*/
SELECT country_of_birth, COUNT(*) 
FROM person
GROUP BY country_of_birth
ORDER BY country_of_birth;

/*Group by having*/
/*Group data containing certain parameters*/
SELECT country_of_birth, COUNT(*)
FROM person 
GROUP BY country_of_birth
HAVING COUNT(*)>5
ORDER BY country_of_birth;




create table car (
	id BIGSERIAL NOT NULL PRIMARY KEY,
	make VARCHAR(50) NOT NULL,
	model VARCHAR(50) NOT NULL,
	price VARCHAR(50) NOT NULL
);


/*Max, Min, Avg*/
SELECT MAX(price) FROM car;
SELECT MIN(price) FROM car;
SELECT AVG(price) FROM car;
SELECT ROUND(AVG(price)) FROM car;

SELECT make,model, MIN(price) FROM car GROUP BY make, model;

/*Sum*/
SELECT SUM(price) FROM car;

/*Arithmetic Operators*/
SELECT 10 + 2;
SELECT 10 / 2;
SELECT 10 - 2;
SELECT 10 * 2;
SELECT 10^2;
SELECT 5!; /*Factorial*/
SELECT 10 % 3;

/*Calculations*/
/*Calculating Discount*/
SELECT make, model, price, ROUND(price * .10) AS Discount, ROUND(price - (price* .10)) AS finalPrice 
FROM car;

/*Coalesce*/
/*Will iterate through values to find and output the first value read if not null*/
/*Can be used in case if email not present, O/P "Email not Present"*/
SELECT COALESCE(email, 'Email not Present') FROM person;

SELECT COALESCE(null, null,1) AS number;
    /* O/P - 1 */
SELECT COALESCE(null, null,1,10) AS number;
    /* O/P - 1 */
SELECT COALESCE(null, null,10,1) AS number;
    /* O/P - 10 */


/*Timestamps and dates*/
SELECT NOW(); /*Gives current timestamp*/
SELECT NOW()::DATE;
SELECT NOW()::TIME;


/*Adding substracting dates*/
SELECT NOW() - INTERVAL '1 YEAR';
SELECT NOW() + INTERVAL '10 YEARS';
SELECT NOW() - INTERVAL '12 MONTHS';
SELECT NOW() - INTERVAL '2 DAYS';


/*Extracting fields from dates*/
SELECT EXTRACT(YEAR FROM NOW());
SELECT EXTRACT(DAY FROM NOW());
SELECT EXTRACT(DOW FROM NOW());

/*Age*/
SELECT first_name, last_name, gender, country_of_birth, date_of_birth, AGE(NOW(), date_of_birth) AS age 
FROM person;

/*Alter table*/
ALTER TABLE person DROP CONSTRAINT person_pkey; /*removes primary key*/
ALTER TABLE person ADD PRIMARY KEY (id); /*Will not work if dublicate data in column ID exists*/
ALTER TABLE person ADD PRIMARY KEY (id, first_name, last_name);/*Multiple primary keys, all data in 
rows must be unique*/

/*UNIQUE contraints*/
/*Ensures that each column has unique values, example, 
in the email column, each email must be unique. Therefore,
Unique constraints can be utilized*/
ALTER TABLE person ADD CONSTRAINT unique_email_address UNIQUE(email);

/*Check Constraint*/
ALTER TABLE person ADD CONSTRAINT gender_constraint CHECK (gender = 'Female' OR gender = 'Male');

/*Delete*/
DELETE FROM person; /*deletes everything*/
DELETE FROM person WHERE id = 2;

/*Update records*/
UPDATE person SET email = 'email' WHERE first_name = 'Omar';
UPDATE person SET email = 'email', first_name = 'Lol' WHERE first_name = 'Omar';

/*On conflict do nothing*/

/*UPSERT*/

/*Foreign Keys*/
CREATE TABLE person (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(7) NOT NULL,
    email VARCHAR(100),
    date_of_birth DATE NOT NULL,
    country_of_birth VARCHAR(50) NOT NULL,
    car_id BIGINT REFERENCES car(id),
    UNIQUE(car_id)
    /*One car for one person, not null not added as it's possible for people to not have
    a car*/
);

CREATE TABLE car(
    id BIGSERIAL NOT NULL PRIMARY KEY,
    make VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL,
    price NUMERIC(19,2) NOT NULL
);

/*Updating foreign key column*/
UPDATE person SET car_id = 2 WHERE id = 1;


