--task1  (lesson8)
-- oracle: https://leetcode.com/problems/department-top-three-salaries/
select d.Name as Department, a. Name as Employee, a. Salary from 
(select e.*, dense_rank() over (partition by DepartmentId order by Salary desc) as drn 
from Employee e) a 
join Department d
on a.DepartmentId = d.Id 
where drn <=3;

--task2  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/17
select member_name, status, SUM(amount*unit_price) as costs 
from Payments 
join FamilyMembers
on Familymembers.member_id = payments.family_member
where Year (date)='2005'
GROUP BY member_name, status

--task3  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/13
select name from (select name, count(*) as c from passenger 
group by name) a 
where c > 1

--task4  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38
select count(first_name) as count from Student
left join Student_in_class
on Student.id = Student_in_class.student 
left join Class
on Student_in_class.class = Class.id 
where first_name = 'Anna'

--task5  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/35
select COUNT(classroom ) as count from Schedule
where date = '2019-09-02'

--task6  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38
select count(first_name) as count from Student
left join Student_in_class
on Student.id = Student_in_class.student 
left join Class
on Student_in_class.class = Class.id 
where first_name = 'Anna'

--task7  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/32
SELECT round (avg (TIMESTAMPDIFF(YEAR, birthday, CURDATE())),0) AS age
FROM FamilyMembers

--task8  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/27
select good_type_name, sum(amount*unit_price) as costs 
from Payments 
join Goods on Payments.good = Goods.good_id 
join GoodTypes on Goods.type = GoodTypes.good_type_id 
where Year (date)='2005'
GROUP BY good_type_name

--task9  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/37
SELECT min (TIMESTAMPDIFF(YEAR, birthday, CURDATE())) AS year
FROM Student

--task10  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/44
SELECT max (TIMESTAMPDIFF(YEAR, birthday, CURDATE())) as max_year FROM Student AS s 
JOIN Student_in_class AS  sc ON s.id = sc.student 
JOIN Class AS c ON c.id = sc.class 
WHERE name = 10

--task11 (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/20
SELECT status, member_name, sum(amount * unit_price) AS costs
FROM FamilyMembers AS f 
JOIN Payments AS p ON f.member_id = p.family_member 
JOIN Goods AS g ON p.good = g.good_id 
JOIN GoodTypes AS gt ON g.type = gt.good_type_id
WHERE good_type_name = 'entertainment'
GROUP BY status, member_name

--task12  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/55
DELETE FROM Company
WHERE id IN 
(SELECT company FROM Trip 
GROUP BY company HAVING count(id) = (SELECT min(count) FROM 
(SELECT count(id) AS count FROM trip GROUP BY company) AS a))

--task13  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/45
SELECT classroom FROM Schedule
GROUP BY classroom 
HAVING count(id) = (SELECT max(count) FROM 
(SELECT classroom, count(id) AS count 
FROM Schedule GROUP BY classroom) AS a)

--task14  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/43
select last_name FROM 
(select last_name,
rank() over (order by last_name) from Subject
join Schedule on Subject.id = Schedule.subject 
join Teacher on Schedule.teacher = Teacher.id 
where name = 'Physical Culture') as a

--task15  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/63
select name from
(select *,
concat(last_name, '.', left(first_name, 1), '.', left(middle_name, 1), '.') as name
from Student) a
order by name
