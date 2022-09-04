--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing

--task1
--Корабли: Для каждого класса определите число кораблей этого класса, потопленных в сражениях. Вывести: класс и число потопленных кораблей.
select class, count(name) from ships
where name in (select ship from outcomes where result = 'sunk')
group by class
--task2
--Корабли: Для каждого класса определите год, когда был спущен на воду первый корабль этого класса. Если год спуска на воду головного корабля неизвестен, определите минимальный год спуска на воду кораблей этого класса. Вывести: класс, год.
select class, min(launched)
from ships
group by class
--task3
--Корабли: Для классов, имеющих потери в виде потопленных кораблей и не менее 3 кораблей в базе данных, вывести имя класса и число потопленных кораблей.
select class, count(name) from ships
where name in (select ship from outcomes where result = 'sunk')
group by class
--task4
--Корабли: Найдите названия кораблей, имеющих наибольшее число орудий среди всех кораблей такого же водоизмещения (учесть корабли из таблицы Outcomes).
with all_ships as (select * from outcomes
left join ships
on outcomes.ship = ships.name
left join classes
on ships.class = classes.class)
select distinct(ship) from all_ships
left join (select displacement, max(numGuns) as max_guns 
from classes
group by displacement) as all_displacement
on all_displacement.displacement = all_ships.displacement
where numGuns = max_guns
--task5
--Компьютерная фирма: Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM и с самым быстрым процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker
with my_pc as (select * from pc where ram = (select min(ram) from pc))
select distinct maker from product
where model in (select model from my_pc where speed = (select max(speed) from my_pc))
and maker in (select distinct maker from printer
join product
on product.model = printer.model)
