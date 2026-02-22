create table type(
    type_id serial primary key,
    name varchar(30) not null unique
);

create table transport(
    transport_id serial primary key,
    type_id int references type(type_id),
    seats_num int not null check (seats_num >= 1)
);

create table guest(
    guest_id serial primary key,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    middle_name varchar(50),
    room_num integer not null,
    arrival_date date check (extract(year from arrival_date) >= 2021
    and extract(year from arrival_date) <= extract(year from current_date)),
    departure_date date check (departure_date > arrival_date)
);

create table rent(
    guest_id int references guest(guest_id),
    transport_id int references transport(transport_id),
    start_datetime timestamp not null check (extract(year from start_datetime) >= 2021
    and extract(hour from start_datetime) between 8 and 21
    and extract(year from start_datetime) <= extract(year from current_date)),
    end_datetime timestamp not null check (end_datetime > start_datetime
    and extract(hour from end_datetime) between 8 and 21),
    rent_time time not null,
    primary key (guest_id, transport_id, start_datetime)
);

create table feedback(
    feedback_id serial primary key,
    guest_id int,
    transport_id int,
    start_datetime timestamp,
    review_text text not null check (length(review_text) >= 10),
    sentimental_label varchar(20),
    processing_status varchar(20) default 'pending'
    check (processing_status in ('pending', 'processed','failed')),
    processed_at timestamp,
    foreign key (guest_id, transport_id, start_datetime) references rent(guest_id, transport_id, start_datetime)
);

create index idx_feedback_status on feedback(processing_status);