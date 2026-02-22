-- select all tables
select * from type;
select * from transport;
select * from guest;
select * from rent;
select * from feedback;

-- BETWEEN Вивести імена, прізвища та номери кімнат гостей, які приїхали між 2 січням 2024 та 10 серпня 2024 року,
-- відсортує за номерами кімнат у зростаючому порядку
select first_name, last_name, room_num
from guest
where arrival_date between '2024-01-02' and '2024-08-10'
order by room_num asc;

-- IN Вивести все з таблиці rent, де транспортним засобом був той в якого id рівне 2 або 3
select *
from rent
where transport_id in(2,3);

-- EXIST Вивести ід гостя та час оренди засобу з таблиці оренда, якщо цей гість існує в таблиці гість
select guest_id, rent_time
from rent r
where exists(select 1 from guest g
whereg.guest_id = r.guest_id)
order by guest_id asc;

-- NOT EXISTS Вивести ід гостя та ім’я/прізвище з таблиці гість, якщо даний гість немає записів в таблиці оренда
select guest_id, first_name, last_name
from guest g
where NOT EXISTS(select 1 from rent r
where r.guest_id = g.guest_id);

-- LIKE Вивести всі рядочки з таблиці гість, якщо в імені гостя друга буква а або номер його кімнати закінчується
-- трійкою. Відсортує за іменами у спадаючому порядку.
select *
from guest
where first_name LIKE '_a%' OR room_num::text LIKE '%3'
order by first_name DESC;

-- Вивести всі рядки з таблиці оренда, якщо id транспорту не рівне 1 і час оренди більший двох годин.
select *
from rent
where transport_id != 1 AND rent_time > '02:00:00';

-- LIMIT Вивести id гостя та його прізвище, якщо прізвище є більше за ім’я, відсортувати за прізвищем у зростаючому
-- порядку. Вивести перші 3 рядки.
select guest_id as "ID",
last_name as "Last name"
from guest
where last_name > first_name
order by last_name asC
limit 3;

-- DISTINCT Вивести прізвища гостей, які не повторяються.
select distinct last_name
from guest;

-- Створюємо новий стовпець прізвище та ім’я, об’єднуючи два стовпця
select guest_id,
last_name || ' ' || first_name as full_name
from guest;

-- group by Вивести кількість транспортних засобів для кожного типу транспорту, групуючи за типом.
select type_id, count(transport_id) as transport_count
from transport
group by type_id;

-- Вивести номери кімнат, де за весь час зупинялось більше однієї людини. Відсортувати за номером кімнати за
-- зростанням.
select g.room_num, count(g.guest_id) as guest_count
from guest as g
group by room_num
having count(guest_id) > 1
order by room_num asC;

-- Виведе всі рядки із таблиць гість та оренда, але тільки ті, де для гостя є відповідний запис в таблиці оренда.
-- Об’єднає внутрішньо.
select *
from guest as g ,rent as r
where g.guest_id = r.guest_id;

-- Виведе усі наявні транспортні засоби та назви відповідних їм типів. Відсортує за к-стю місць за зростанням.
select t.transport_id, t.seats_num,ty.name as type_name
from transport as t
left join type as ty
on t.type_id = ty.type_id
order by t.seats_num asC;

-- Виведе id транспортого засобу, час оренди і ім’я орендаря(виведе усі імена незалежно від оренди). Відсортує за
-- зростанням часу оренди.
select r.transport_id, r.rent_time,g.first_name as guest_name
from rent as r
right join guest as g
on r.guest_id = g.guest_id
order by rent_time asC;

-- Виведе список повних імен гостей, об'єднуючи їхні імена та прізвища, а також загальний час оренди(навіть
-- якщо гість не орендував транспорт). З’єднюємо за полем id гостя і сортуємо за загалом часом у зростаючому
-- порядку.
select g.first_name||' '||g.last_name as full_name,
sum(r.rent_time) as full_time
from guest as g
full join rent as r on g.guest_id = r.guest_id
group by full_name
order by full_time asC;