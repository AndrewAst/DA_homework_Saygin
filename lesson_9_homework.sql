--task1  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem
SELECT 
    CASE
        WHEN Grades.Grade > 7 THEN Students.Name
        WHEN Grades.Grade <= 7 THEN NULL
        END, Grades.Grade, Students.Marks FROM Students INNER JOIN Grades 
        ON Students.Marks BETWEEN Grades.Min_Mark AND Max_Mark ORDER BY Grades.Grade DESC, Students.Name ASC, Students.Marks ASC;
       
--task2  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/occupations/problem
WITH main AS ( SELECT * FROM 
              ( SELECT occupation, name, row_number() over(partition by occupation order by name) r FROM occupations ) 
              PIVOT ( MAX(name) FOR occupation IN ('Doctor' AS D,'Singer' AS S,'Professor' AS P,'Actor' AS A) ) ORDER BY D,P,S,A ) 
              SELECT D AS Doctor, P AS Professor, S AS Singer, A AS Actor FROM main m;
             
--task3  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-9/problem
SELECT DISTINCT CITY FROM STATION 
WHERE CITY NOT IN (SELECT CITY FROM STATION WHERE CITY LIKE 'A%' OR CITY LIKE 'E%' OR CITY LIKE 'I%' OR CITY LIKE 'O%' OR CITY LIKE 'U%');

--task4  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-10/problem
SELECT DISTINCT CITY FROM STATION 
WHERE (CITY NOT LIKE '%a' AND CITY NOT LIKE '%e' AND CITY NOT LIKE '%i' AND CITY NOT LIKE '%o' AND CITY NOT LIKE '%u');

--task5  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-11/problem
SELECT DISTINCT CITY FROM STATION 
WHERE (CITY NOT LIKE 'A%' AND CITY NOT LIKE 'E%' AND CITY NOT LIKE 'I%' AND CITY NOT LIKE 'O%' AND CITY NOT LIKE 'U%') OR (CITY NOT LIKE '%a' AND CITY NOT LIKE '%e' AND CITY NOT LIKE '%i' AND CITY NOT LIKE '%o' AND CITY NOT LIKE '%u');

--task6  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-12/problem
SELECT DISTINCT CITY FROM STATION 
WHERE (CITY NOT LIKE 'A%' AND CITY NOT LIKE 'E%' AND CITY NOT LIKE 'I%' AND CITY NOT LIKE 'O%' AND CITY NOT LIKE 'U%') AND (CITY NOT LIKE '%a' AND CITY NOT LIKE '%e' AND CITY NOT LIKE '%i' AND CITY NOT LIKE '%o' AND CITY NOT LIKE '%u');

--task7  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/salary-of-employees/problem
select name from Employee 
where months < 10 and salary > 2000;

--task8  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem
select case when Grades.Grade > 7 then Students.Name 
else Null End, Grades.Grade, Students.Marks From Students 
Join Grades on Students.Marks between  Grades.Min_Mark and Grades.Max_Mark
Order by Grades.Grade desc, Students.Name asc, Students.Marks asc;