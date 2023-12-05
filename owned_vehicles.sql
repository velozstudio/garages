create table if not exists owned_vehicles
(
    owner    varchar(46)   null,
    plate    varchar(12)   not null,
    vehicle  longtext      null,
    type     varchar(20)   null,
    state    int default 1 null,
    garageId varchar(255)  null,
    primary key (plate)
);