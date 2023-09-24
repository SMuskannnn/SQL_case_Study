--general queries
--total amount spent by everyone
select SUM(Amount) FROM credit_cards;


--Highest total expenditure
WITH total AS
(SELECT City, SUM(Amount) AS total_exp FROM credit_cards
GROUP BY City)
SELECT City,MAX(total_exp) as Highest_Total_expenditure FROM total;


--Lowest total expenditure
WITH total AS
(SELECT City, SUM(Amount) AS total_exp FROM credit_cards
GROUP BY City)
SELECT City,MIN(total_exp) as Lowest_Total_expenditure FROM total;



--Highest average expenditure
WITH total AS
(SELECT City, AVG(Amount) AS average_exp FROM credit_cards
GROUP BY City)
SELECT City,MAX(average_exp) as Highest_avg_expenditure FROM total;


--Lowest average expenditure
WITH total AS
(SELECT City, AVG(Amount) AS average_exp FROM credit_cards
GROUP BY City)
SELECT City,MIN(average_exp) as Lowest_avg_expenditure FROM total;


--FOR WHAT EXP WAS PLATINUM CARD USED MOST
WITH TOTAL_EXP AS(
  SELECT [Exp Type],COUNT([Exp Type]) AS total_exp FROM credit_cards
  WHERE [Card Type] = 'Platinum'
  GROUP BY [Exp Type]
  )
SELECT [Exp Type] FROM TOTAL_EXP
WHERE total_exp = (SELECT MAX(total_exp) FROM TOTAL_EXP);


--TOTAL Expenditure Analysis
SELECT [Card Type], SUM(Amount) FROM credit_cards
GROUP BY [Card Type];   --based on card typecredit_cards

SELECT City, SUM(Amount) FROM credit_cards
GROUP BY City;    --based on each city

SELECT ('20'||SUBSTR(Date,-2)) AS year, SUM(Amount) FROM credit_cards
GROUP BY year;        --based on year

SELECT ('20'||SUBSTR(Date,-2)) AS year,(SUBSTR(Date,INSTR(Date,'-')+1,3)) AS month, SUM(Amount) FROM credit_cards
GROUP BY month,year;    --month and year 


--USING PIVOT
--MONTHLY EXPENDITURE BY EXPENSE TYPE
SELECT
    [Exp Type],
    SUM(CASE WHEN UPPER((SUBSTR(Date,INSTR(Date,'-')+1,3))) = 'JAN' THEN Amount ELSE 0 END) AS "January",
    SUM(CASE WHEN UPPER((SUBSTR(Date,INSTR(Date,'-')+1,3))) = 'FEB' THEN Amount ELSE 0 END) AS "February",
    SUM(CASE WHEN UPPER((SUBSTR(Date,INSTR(Date,'-')+1,3))) = 'MAR' THEN Amount ELSE 0 END) AS "March",
    SUM(CASE WHEN UPPER((SUBSTR(Date,INSTR(Date,'-')+1,3))) = 'APR' THEN Amount ELSE 0 END) AS "April",
    SUM(CASE WHEN UPPER((SUBSTR(Date,INSTR(Date,'-')+1,3))) = 'MAY' THEN Amount ELSE 0 END) AS "May",
    SUM(CASE WHEN UPPER((SUBSTR(Date,INSTR(Date,'-')+1,3))) = 'JUN' THEN Amount ELSE 0 END) AS "June",
    SUM(CASE WHEN UPPER((SUBSTR(Date,INSTR(Date,'-')+1,3))) = 'JUL' THEN Amount ELSE 0 END) AS "July",
    SUM(CASE WHEN UPPER((SUBSTR(Date,INSTR(Date,'-')+1,3))) = 'AUG' THEN Amount ELSE 0 END) AS "August",
    SUM(CASE WHEN UPPER((SUBSTR(Date,INSTR(Date,'-')+1,3))) = 'SEP' THEN Amount ELSE 0 END) AS "September",
    SUM(CASE WHEN UPPER((SUBSTR(Date,INSTR(Date,'-')+1,3))) = 'OCT' THEN Amount ELSE 0 END) AS "October",
    SUM(CASE WHEN UPPER((SUBSTR(Date,INSTR(Date,'-')+1,3))) = 'NOV' THEN Amount ELSE 0 END) AS "November",
    SUM(CASE WHEN UPPER((SUBSTR(Date,INSTR(Date,'-')+1,3))) = 'DEC' THEN Amount ELSE 0 END) AS "December"
   	
FROM credit_cards
GROUP BY [Exp Type];
--TOTAL EXP BY CARD TYPE AND GENDER
SELECT
    [Card Type],
    SUM(CASE WHEN Gender = 'M' THEN Amount ELSE 0 END) AS "Male",
    SUM(CASE WHEN Gender = 'F' THEN Amount ELSE 0 END) AS "Female"
FROM credit_cards
GROUP BY [Card Type];

--TOTAL EXP TYPE AND YEAR
SELECT
    [Exp Type],
    SUM(CASE WHEN SUBSTR(Date, -2) = '13' THEN Amount ELSE 0 END) AS "2013",
    SUM(CASE WHEN SUBSTR(Date, -2) = '14' THEN Amount ELSE 0 END) AS "2014",
    SUM(CASE WHEN SUBSTR(Date, -2) = '15' THEN Amount ELSE 0 END) AS "2015"
FROM credit_cards
GROUP BY [Exp Type];


--VIEW AND WINDOW FUNCTIONS
--Which 3 Cities spent most the following years
--created a view named ASK
CREATE VIEW ask AS
WITH table2 AS
(With table1 AS(
SELECT ('20'||SUBSTR(Date,-2)) AS year,City,Amount FROM credit_cards)
SELECT ROW_NUMBER()OVER(PARTITION BY year),year,City,SUM(Amount) AS total FROM table1 --each year has independent no. of rows
GROUP BY city)
SELECT year,City,total,DENSE_RANK()OVER(PARTITION BY year ORDER BY total DESC) AS rank FROM table2;

--USING VIEW TO GET THE DESIRED RESULT
SELECT year,rank,City,total FROM ask
where rank < 4;


--EXPENSE TYPE ANALYSIS

--total
SELECT [Exp Type],COUNT([Card Type]) AS [Number of cards used],SUM(Amount) as [total expense]FROM credit_cards
GROUP BY [Exp Type]
ORDER BY [total expense];

--average
SELECT [Exp Type], ROUND(AVG(Amount),3) AS Average_Expenditure
FROM credit_cards
GROUP BY [Exp Type]
ORDER BY Average_Expenditure DESC;
 
--EXPENSE DISTRIBUTION BY GENDER 
SELECT [Exp Type], Gender, COUNT(*) AS Count
FROM credit_cards
GROUP BY [Exp Type], Gender
ORDER BY [Exp Type], Gender;


--CARD TYPE ANALYSIS
--number of cards for each Card Type in each city
SELECT
    City,
    COUNT(CASE WHEN UPPER([Card Type]) = 'PLATINUM' THEN [Card Type] ELSE NULL END) AS "PLATINUM",
    COUNT(CASE WHEN UPPER([Card Type]) = 'GOLD' THEN [Card Type] ELSE NULL END) AS "GOLD",
    COUNT(CASE WHEN UPPER([Card Type]) = 'SILVER' THEN [Card Type] ELSE NULL END) AS "SILVER",
    COUNT(CASE WHEN UPPER([Card Type]) = 'SIGNATURE' THEN [Card Type] ELSE NULL END) AS "SIGNATURE"
FROM credit_cards
GROUP BY City;

--NO. of cards for each card type for each gender
SELECT
    [Card Type],
    COUNT(CASE WHEN Gender = 'M' THEN [Card Type] ELSE NULL END) AS "Male",
    COUNT(CASE WHEN Gender = 'F' THEN [Card Type] ELSE NULL END) AS "Female"
FROM credit_cards
GROUP BY [Card Type];

--what type and No. of cards used exp type
SELECT [Card Type],[Exp Type], COUNT(*) AS Count
FROM credit_cards
GROUP BY [Card Type],[Exp Type]
ORDER BY [Card Type],[Exp Type];



--DATA CLEANING AND VALIDATION
--1.NULL values
SELECT *
FROM credit_cards
WHERE City IS NULL OR Amount IS NULL;

--2.Duplicate Entries
--DELETE FROM credit_cards
SELECT * FROM credit_cards
WHERE ( "index", City, Date, [Card Type], [Exp Type], Gender, Amount) NOT IN (
    SELECT MIN("index"), City, Date, [Card Type], [Exp Type], Gender, Amount
    FROM credit_cards
    GROUP BY City, Date, [Card Type], [Exp Type], Gender, Amount
);

-- AMOUNT
SELECT *
FROM credit_cards
WHERE Amount < 0;

--Gender Validation
SELECT *
FROM credit_cards
WHERE Gender NOT IN ('M', 'F');
