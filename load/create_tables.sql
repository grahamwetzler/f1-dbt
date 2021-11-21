create schema ergast;

create table if not exists ergast.circuits (
    "circuitId" DECIMAL,
    "circuitRef" varchar,
    name varchar,
    location varchar,
    country varchar,
    lat DECIMAL,
    lng DECIMAL,
    alt DECIMAL,
    url varchar
);

truncate table ergast.circuits;

create table if not exists ergast.constructor_results (
    "constructorResultsId" DECIMAL,
    "raceId" DECIMAL,
    "constructorId" DECIMAL,
    points DECIMAL,
    status varchar
);

truncate table ergast.constructor_results;

create table if not exists ergast.constructor_standings (
    "constructorStandingsId" DECIMAL,
    "raceId" DECIMAL,
    "constructorId" DECIMAL,
    points DECIMAL,
    position DECIMAL,
    "positionText" varchar,
    wins DECIMAL
);

truncate table ergast.constructor_standings;

create table if not exists ergast.constructors (
    "constructorId" DECIMAL,
    "constructorRef" varchar,
    name varchar,
    nationality varchar,
    url varchar
);

truncate table ergast.constructors;

create table if not exists ergast.driver_standings (
    "driverStandingsId" DECIMAL,
    "raceId" DECIMAL,
    "driverId" DECIMAL,
    points DECIMAL,
    position DECIMAL,
    "positionText" varchar,
    wins DECIMAL
);

truncate table ergast.driver_standings;

create table if not exists ergast.drivers (
    "driverId" DECIMAL,
    "driverRef" varchar,
    number varchar,
    code varchar,
    forename varchar,
    surname varchar,
    dob date,
    nationality varchar,
    url varchar
);

truncate table ergast.drivers;

create table if not exists ergast.lap_times (
    "raceId" DECIMAL,
    "driverId" DECIMAL,
    lap DECIMAL,
    position DECIMAL,
    time interval,
    milliseconds DECIMAL
);

truncate table ergast.lap_times;



create table if not exists ergast.pit_stops (
    "raceId" DECIMAL,
    "driverId" DECIMAL,
    stop DECIMAL,
    lap DECIMAL,
    time interval,
    duration varchar,
    milliseconds DECIMAL
);

truncate table ergast.pit_stops;

create table if not exists ergast.qualifying (
    "qualifyId" DECIMAL,
    "raceId" DECIMAL,
    "driverId" DECIMAL,
    "constructorId" DECIMAL,
    number DECIMAL,
    position DECIMAL,
    q1 varchar,
    q2 varchar,
    q3 varchar
);

truncate table ergast.qualifying;

create table if not exists ergast.races (
    "raceId" DECIMAL,
    year DECIMAL,
    round DECIMAL,
    "circuitId" DECIMAL,
    name varchar,
    date date,
    time varchar,
    url varchar
);

truncate table ergast.races;

create table if not exists ergast.results (
    "resultId" DECIMAL,
    "raceId" DECIMAL,
    "driverId" DECIMAL,
    "constructorId" DECIMAL,
    number varchar,
    grid DECIMAL,
    position varchar,
    "positionText" varchar,
    "positionOrder" DECIMAL,
    points DECIMAL,
    laps DECIMAL,
    time varchar,
    milliseconds varchar,
    "fastestLap" varchar,
    rank varchar,
    "fastestLapTime" varchar,
    "fastestLapSpeed" varchar,
    "statusId" DECIMAL
);

truncate table ergast.results;

create table if not exists ergast.seasons (
    year DECIMAL,
    url varchar
);

truncate table ergast.seasons;

create table if not exists ergast.status (
    "statusId" DECIMAL,
    status varchar
);

truncate table ergast.status;
