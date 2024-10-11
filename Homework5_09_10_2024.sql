USE airport;
-- SET SQL_SAFE_UPDATES = 0;
SELECT 
* 
FROM airliners;
/*
Описание задания.
 1 уровень сложности: Для выполнения работы использовать базу данных airport(скрип в репозитории в каталоге scripts).


Простые выборки (перед началом посмотрите в каких таблицах что находится):
1) Выбрать всех клиентов, чей возраст больше чем 40;
2) Выбрать всех клиентов, у которых в фамилии есть вхождение 'Egor';
3) Выбрать все билеты, которые относятся к классу Economy или PremiumEconomy и цена больше 40000;
4) Выбрать все поездки, у которых статус был отменен или задержан, вывести только коды отправления и прибытия.
5) Выбрать всех клиентов и отсортировать их по фамилии в алфавитном порядке;
6) Выбрать всех клиентов и отсортировать их по возрасту в порядке убывания;
7) Вывести все билеты НЕ Economy класса и отсортировать их по стоимости в порядке убывания;

2 уровень сложности: 
*/
-- 1) Выбрать всех клиентов, чей возраст больше чем 40;
SELECT 
* 
FROM clients;
SELECT
name,
age AS alter_then_40
FROM clients
WHERE age > 40;
-- *********
-- 2) Выбрать всех клиентов, у которых в фамилии есть вхождение 'Egor';
SELECT -- variant 1
SUBSTRING(name,LOCATE(' ',name)) AS nach_name_with_Egor 
FROM clients
WHERE name LIKE '%Egor%';
SELECT -- variant 2
SUBSTRING(name,LOCATE(' ',name)) AS nach_name_with_Egor
FROM clients
WHERE SUBSTRING(name,LOCATE(' ',name)) LIKE '%Egor%';
/*COMENT
variant 1 и variant 2 дают одиноковые результаты только потому что в clients нету пасажиров с первое имя вalter
которое был корень Egor. Если execut нижние команды, то появится и первое имя содержащее Egor. Тогда толькоalter
variant 2 дает правильные результаты, в которые входят только фамилии.
INSERT INTO clients (id,name) VALUES ('id_Probe1','Egor_Some Family_Some');
SELECT * FROM clients WHERE id = 'id_Probe1';
DELETE  FROM clients WHERE id = 'id_Probe1';
*/

-- 3) Выбрать все билеты, которые относятся к классу Economy или PremiumEconomy и цена больше 40000;
SELECT
*
FROM tickets;
SELECT
*
FROM tickets
WHERE service_class = 'Economy' OR service_class = 'PremiumEconomy' AND price > 40000;

-- 4) Выбрать все поездки, у которых статус был отменен или задержан, вывести только коды отправления и прибытия.
SELECT
departure,
arrival
FROM trips
WHERE status = 'Cancelled' OR status = 'Delayed';

-- 5) Выбрать всех клиентов и отсортировать их по фамилии в алфавитном порядке;
SELECT 
name AS ascedentic_nach_name
FROM clients
ORDER BY SUBSTRING(name,LOCATE(' ',name)) ASC;

-- 6) Выбрать всех клиентов и отсортировать их по возрасту в порядке убывания;
SELECT
name,
age AS descedentic_age
FROM clients
ORDER BY age DESC;

-- 7) Вывести все билеты НЕ Economy класса и отсортировать их по стоимости в порядке убывания;
SELECT
id,
trip_id,
service_class,
price AS descedentic_price,
client_id
FROM tickets
WHERE service_class != 'Economy'
ORDER BY descedentic_price DESC;

-- END