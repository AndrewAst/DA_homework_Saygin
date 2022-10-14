--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1 (lesson5)
-- Компьютерная фирма: Сделать view (pages_all_products), в которой будет постраничная разбивка всех продуктов (не более двух продуктов на одной странице). Вывод: все данные из laptop, номер страницы, список всех страниц
create view pages_all_products as
select *,
case when rn %2 != 0 then rn/2 else rn / 2+1 end as page_num,
case when rn % 2 = 0 then 2 else 1 end as position
from
(select *, row_number(*) over (order by price desc) as rn
from laptop) a

select * from pages_all_products

sample:
1 1
2 1
1 2
2 2
1 3
2 3

--task2 (lesson5)
-- Компьютерная фирма: Сделать view (distribution_by_type), в рамках которого будет процентное соотношение всех товаров по типу устройства. Вывод: производитель, тип, процент (%)

create view distribution_by_type as

select distinct maker, type, dol from (select *, row_number (*) over (), 
count(*) over (partition by maker, type) as rn,
count(*) over () as aa, 100 * (count(*) over (partition by maker, type)) / (count(*) over ()):: numeric as dol
from product) qq

select * from distribution_by_type

--task3 (lesson5)
-- Компьютерная фирма: Сделать на базе предыдущенр view график - круговую диаграмму. Пример https://plotly.com/python/histograms/

https://colab.research.google.com/drive/1GAvaWTN5Emhe5WPb2kUzBFexUfU0tG4h#scrollTo=TUXcjuG1saaj

--task4 (lesson5)
-- Корабли: Сделать копию таблицы ships (ships_two_words), но название корабля должно состоять из двух слов
create table ships_two_words as
select * from ships where name like '% %'

--task5 (lesson5)
-- Корабли: Вывести список кораблей, у которых class отсутствует (IS NULL) и название начинается с буквы "S"
select ship from outcomes
full join classes on classes.class = outcomes.ship 
full join ships on ships.name = outcomes.ship 
where ships.class is null and classes.class is null and outcomes.ship like 'S%'

--task6 (lesson5)
-- Компьютерная фирма: Вывести все принтеры производителя = 'A' со стоимостью выше средней по принтерам производителя = 'C' и три самых дорогих (через оконные функции). Вывести model
select model from
(select *, round (avg(price) over (partition by maker order by type),2) as rn,
row_number() over (order by price desc) rg
from (select product.model, maker, price, product.type from product 
join printer
on product.model = printer.model) as foo) as foo1
where rg<=3 or (maker='A' and (price - (select rn from (select *, round (avg(price) 
over (partition by maker order by type),2) as rn from (select product.model, maker, price, product.type from product
join printer on product.model = printer.model) as foo) as foo1 where maker = 'C') >0))