insert into type(name)
values
('canoe'),
('boat'),
('catamaran');

insert into transport(type_id,seats_num)
values
(2,3),
(1,2),
(3,4),
(1,1),
(2,5),
(3,6);

insert into guest (first_name, last_name, middle_name, room_num, arrival_date, departure_date)
values
('John', 'Doe', 'Michael', 101, '2023-11-15', '2023-11-20'),
('Jane', 'Smith', NULL, 104, '2024-01-10', '2024-01-15'),
('Emily', 'Johnson', 'Rose', 103, '2024-05-05', '2024-05-10'),
('Anna', 'Doel',NULL, 107, '2024-05-03', '2024-05-10'),
('David', 'Doel',NULL, 107, '2024-05-03', '2024-05-10'),
('Liam', 'Brown', 'James', 108, '2024-06-01', '2024-06-07'),
('Sophia', 'Martinez', 'Elena', 110, '2024-06-10', '2024-06-15'),
('Oliver', 'Garcia', NULL, 115, '2024-07-01', '2024-07-05'),
('Ava', 'Rodriguez', 'Maria', 104, '2024-01-20', '2024-01-29'),
('Noah', 'Hernandez', 'Alexander', 109, '2024-08-01', '2024-08-08');

insert into rent (guest_id, transport_id, start_datetime, end_datetime, rent_time)
values
(1, 2, '2023-11-16 10:00:00', '2023-11-16 12:00:00', '02:00:00'),
(2, 1, '2024-01-10 14:30:00', '2024-01-10 16:30:00', '02:00:00'),
(3, 3, '2024-05-07 08:15:00', '2024-05-07 10:45:00', '02:30:00'),
(6, 5, '2024-06-03 09:00:00', '2024-06-03 12:00:00', '03:00:00'),
(7, 2, '2024-06-12 13:00:00', '2024-06-12 15:30:00', '02:30:00'),
(6, 4, '2024-06-06 11:00:00', '2024-06-06 13:00:00', '02:00:00'),
(10, 6, '2024-08-07 10:00:00', '2024-08-07 12:30:00', '02:30:00'),
(9, 1, '2024-01-25 09:00:00', '2024-01-25 11:00:00', '02:00:00');

insert into feedback (guest_id, transport_id, start_datetime, review_text)
values
-- Guest Jane Smith (ID 2), rented Canoe (ID 1)
(2, 1, '2024-01-10 14:30:00', 'The canoe was very stable and easy to handle. We had a great time on the lake!'),

-- Guest Liam Brown (ID 6), rented Boat (ID 5)
(6, 5, '2024-06-03 09:00:00', 'The boat motor was making a strange noise, and it felt a bit unsafe at times.'),

-- Guest Liam Brown (ID 6), rented Canoe (ID 4)
(6, 4, '2024-06-06 11:00:00', 'Decent experience, but the paddles were quite worn out and uncomfortable to hold.'),

-- Guest Noah Hernandez (ID 10), rented Catamaran (ID 6)
(10, 6, '2024-08-07 10:00:00', 'Absolutely amazing trip! The catamaran was spacious and very clean. Worth every penny.'),

-- Guest Ava Rodriguez (ID 9), rented Canoe (ID 1)
(9, 1, '2024-01-25 09:00:00', 'It was okay, but the service was a bit slow during the pick-up process.');