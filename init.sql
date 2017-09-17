CREATE TYPE SEX AS ENUM ('male', 'female');

CREATE TABLE users (
    id            SERIAL PRIMARY KEY,
    first_name    TEXT NOT NULL,
    last_name     TEXT NOT NULL,
    email         TEXT NOT NULL,
    phone_number  TEXT NOT NULL,
    sex           SEX,
    birthday      DATE,
    profile_image TEXT   
);

CREATE TABLE countries (
    id          SERIAL PRIMARY KEY,
    name        TEXT NOT NULL,
    service_fee INTEGER NOT NULL
);

CREATE TYPE AMENITY AS ENUM ('internet', 'gym', 'parking', 'elevator', 'smoking');

CREATE TABLE accommodation (
    id              SERIAL PRIMARY KEY,
    host_id         INTEGER REFERENCES users(id) NOT NULL,
    country_id      INTEGER REFERENCES countries(id) NOT NULL,
    address         TEXT NOT NULL,
    gps_coordinates POINT NOT NULL,
    description     TEXT NOT NULL,
    rooms           INTEGER CHECK (rooms > 0) NOT NULL,
    accommodates    INTEGER CHECK (accommodates > 0) NOT NULL,
    beds            INTEGER CHECK (beds > 0) NOT NULL,
    amenities       AMENITY[] NOT NULL,
    -- prices per day for every week
    cost            INTEGER[53] NOT NULL,
    cleaning_fee    INTEGER NOT NULL
);

CREATE TYPE RESPONSE AS ENUM ('approved', 'rejected');

CREATE TABLE requests (
    id              SERIAL PRIMARY KEY,
    user_id         INTEGER REFERENCES users(id) NOT NULL,
    accomodation_id INTEGER REFERENCES accommodation(id) NOT NULL,
    start_date      DATE NOT NULL,
    end_date        DATE CHECK (start_date <= end_date) NOT NULL,
    persons         INTEGER CHECK (persons > 0) NOT NULL,
    comment         TEXT,
    status          RESPONSE
);

CREATE TABLE accommodation_reviews (
    id         SERIAL PRIMARY KEY,
    request_id INTEGER REFERENCES requests(id) NOT NULL,
    review     TEXT NOT NULL,
    -- scores for Accuracy, Communication, Cleanliness, Location, Check In, Value respectively
    scores     INTEGER[6] NOT NULL
);

CREATE TABLE users_reviews (
    id  SERIAL PRIMARY KEY,
    request_id INTEGER REFERENCES requests(id) NOT NULL,
    review     TEXT NOT NULL,
    score      INTEGER NOT NULL
);

CREATE TYPE EVENT_TYPE AS ENUM ('sport', 'concert', 'festival');

CREATE TABLE events (
    id              SERIAL PRIMARY KEY,
    description     TEXT,
    gps_coordinates POINT NOT NULL,
    start_date      DATE NOT NULL,
    end_date        DATE CHECK (start_date <= end_date) NOT NULL,
    type            EVENT_TYPE NOT NULL
);

