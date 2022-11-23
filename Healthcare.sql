CREATE DATABASE healthcare;

USE healthcare;

SELECT *
FROM Health_Camp_Detail;

SELECT *
FROM First_Health_Camp_Attended;

-- Joining Health_Camp_Detail & First_Health_Camp_Attended to get info for the first event
    
SELECT *
FROM Health_Camp_Detail
JOIN First_Health_Camp_Attended
	USING(Health_Camp_ID);
    
-- Creating table for the query above

CREATE TABLE First_Health_Camp
(
Health_Camp_ID INT,
Camp_Start_Date DATE,
Camp_End_Date DATE,
Category1 VARCHAR(10),
Category2 VARCHAR(10),
Category3 INT,
Patient_ID INT,
Donation INT,
Health_Score DOUBLE
);

-- Inserting the two joined tables into the new table

INSERT INTO First_Health_Camp
SELECT *
FROM Health_Camp_Detail
JOIN First_Health_Camp_Attended
	USING(Health_Camp_ID);
    
SELECT Patient_ID, 
	   Health_Camp_ID, 
       Camp_Start_Date, 
       Camp_End_Date, 
       Category1, 
       Donation, 
       Health_Score
FROM First_Health_Camp;

-- Getting the total amount donated

SELECT SUM(Donation) AS 'Total Donations'
FROM First_Health_Camp;

-- Checking to see which patients had a high & low score

SELECT Patient_ID, 
	   Health_Score,
CASE
	WHEN AVG(Health_Score) < (SELECT AVG(Health_Score) FROM First_Health_Camp) THEN 'Low Health Score'
    WHEN AVG(Health_Score) > (SELECT AVG(Health_Score) FROM First_Health_Camp) THEN 'High Health Score'
    ELSE Health_Score
END AS 'Patient Score'
FROM First_Health_Camp
GROUP BY Patient_ID, Health_Score;


-- Joining Health_Camp_Detail & Second_Health_Camp_Attended to get info for the Second event
    
SELECT *
FROM Health_Camp_Detail
JOIN Second_Health_Camp_Attended
	USING(Health_Camp_ID);

-- Create new table for the second camp event

CREATE TABLE Second_Health_Camp
(
Health_Camp_ID INT,
Camp_Start_Date DATE,
Camp_End_Date DATE,
Category1 VARCHAR(10),
Category2 VARCHAR(10),
Category3 INT,
Patient_ID INT,
Health_Score DOUBLE
);

-- Inserting the two joined tables into the new table

INSERT INTO Second_Health_Camp
SELECT *
FROM Health_Camp_Detail
JOIN Second_Health_Camp_Attended
	USING(Health_Camp_ID);
    
SELECT Patient_ID, 
	   Health_Camp_ID, 
       Camp_Start_Date, 
       Camp_End_Date, 
       Category1, 
       Health_Score
FROM Second_Health_Camp;

-- Checking to see which patients had a high & low score

SELECT Patient_ID, 
	   Health_Score,
CASE
	WHEN AVG(Health_Score) < (SELECT AVG(Health_Score) FROM Second_Health_Camp) THEN 'Low Health Score'
    WHEN AVG(Health_Score) > (SELECT AVG(Health_Score) FROM Second_Health_Camp) THEN 'High Health Score'
    ELSE Health_Score
END AS 'Patient Score'
FROM Second_Health_Camp
GROUP BY Patient_ID, Health_Score;


-- Joining Health_Camp_Detail & Third_Health_Camp_Attended to get info for the Third event
    
SELECT *
FROM Health_Camp_Detail
JOIN Third_Health_Camp_Attended
	USING(Health_Camp_ID);
    
-- Create new table for the third camp event

CREATE TABLE Third_Health_Camp
(
Health_Camp_ID INT,
Camp_Start_Date DATE,
Camp_End_Date DATE,
Category1 VARCHAR(10),
Category2 VARCHAR(10),
Category3 INT,
Patient_ID INT,
Number_of_stall_visited INT,
Last_Stall_Visited_Number INT
);

-- Inserting the two joined tables into the new table

INSERT INTO Third_Health_Camp
SELECT *
FROM Health_Camp_Detail
JOIN Third_Health_Camp_Attended
	USING(Health_Camp_ID);
    
SELECT Patient_ID, 
	   Health_Camp_ID, 
       Category1, 
       Number_of_stall_visited, 
       Last_Stall_Visited_Number
FROM Third_Health_Camp;

-- Getting the total number of booths visited by patients

SELECT Number_of_stall_visited, 
	   COUNT(Number_of_stall_visited) AS 'Total Number of Visits'
FROM Third_Health_Camp
GROUP BY Number_of_stall_visited
ORDER BY Number_of_stall_visited;

-- Checking for patients that went to multiple events(Duplicate Patient Id)

SELECT Patient_ID, COUNT(Patient_ID) AS 'Events Attended'
FROM registration_details
GROUP BY Patient_ID
HAVING COUNT(Patient_ID) > 1
ORDER BY 2;