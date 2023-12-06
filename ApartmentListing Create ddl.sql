use apartments_db;

CREATE TABLE Address (
    id int(10) NOT NULL AUTO_INCREMENT,
    building varchar(255) NOT NULL,
    street varchar(255) NOT NULL,
    city varchar(255) NOT NULL,
    state varchar(255) NOT NULL,
    country varchar(255) NOT NULL,
    zipcode varchar(5) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE broker (
    id int(10) NOT NULL AUTO_INCREMENT,
    broker_permit varchar(255) NOT NULL UNIQUE,
    rating int(10),
    joining_date date NOT NULL,
    Personid int(10) NOT NULL,
    agency_name varchar(100) DEFAULT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE commercial (
    id int(11) NOT NULL AUTO_INCREMENT,
    permit int(10) NOT NULL UNIQUE,
    listingid int(10) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE facilities (
    id int(10) NOT NULL AUTO_INCREMENT,
    water bit(1) NOT NULL,
    gas bit(1) NOT NULL,
    laundry bit(1) NOT NULL,
    trash bit(1) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE houseType (
    id int(10) NOT NULL AUTO_INCREMENT,
    type varchar(255) NOT NULL UNIQUE,
    PRIMARY KEY (id)
);

CREATE TABLE listing (
    id int(10) NOT NULL AUTO_INCREMENT,
    Addressid int(10) NOT NULL,
    dateOfListing date,
    PRIMARY KEY (id)
);

CREATE TABLE mortgageCompanies (
    id int(10) NOT NULL AUTO_INCREMENT,
    name varchar(255) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE mortgageProviderListing (
    id int(10) NOT NULL AUTO_INCREMENT,
    mortgageCompaniesid int(10) NOT NULL,
    sellid int(10) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE owner (
    id int(10) NOT NULL AUTO_INCREMENT,
    number_of_listing int(10),
    Personid int(10) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE Person (
    id int(10) NOT NULL AUTO_INCREMENT,
    first_name varchar(255) NOT NULL,
    last_name varchar(255) NOT NULL,
    phone_number varchar(10) NOT NULL UNIQUE,
    email varchar(255) NOT NULL UNIQUE,
    dob date NOT NULL,
    Addressid int(10) DEFAULT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE rent (
    id int(10) NOT NULL AUTO_INCREMENT,
    ownerid int(10) NOT NULL,
    brokerid int(10) NOT NULL,
    lease_start_date date NOT NULL,
    lease_end_date date NOT NULL,
    listingid int(10) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE residential (
    id int(10) NOT NULL AUTO_INCREMENT,
    max_occupant int(10) NOT NULL,
    listingid int(10) NOT NULL,
    facilitiesid int(10) NOT NULL,
    sizeOfHouseid int(10) NOT NULL,
    houseTypeid int(10) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE sell (
    id int(10) NOT NULL AUTO_INCREMENT,
    buying_price int(10),
    mortgage_allowed bit(1) NOT NULL,
    listingid int(10) NOT NULL,
    ownerid int(10) NOT NULL,
    brokerid int(10) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE sizeOfHouse (
    id int(10) NOT NULL AUTO_INCREMENT,
    rooms int(10) NOT NULL,
    bathrooms int(10) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE sublease (
    id int(10) NOT NULL AUTO_INCREMENT,
    rooms_available int(10) NOT NULL,
    rooms_occupied int(10) NOT NULL,
    mixed_gender bit(1) NOT NULL,
    parking_available bit(1) NOT NULL,
    listingid int(10) NOT NULL,
    ownerid int(10) NOT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE
    Person
ADD
    CONSTRAINT FKPerson628834 FOREIGN KEY (Addressid) REFERENCES Address (id);

ALTER TABLE
    owner
ADD
    CONSTRAINT FKowner873786 FOREIGN KEY (Personid) REFERENCES Person (id);

ALTER TABLE
    broker
ADD
    CONSTRAINT FKbroker315171 FOREIGN KEY (Personid) REFERENCES Person (id);

ALTER TABLE
    rent
ADD
    CONSTRAINT FKrent417291 FOREIGN KEY (brokerid) REFERENCES broker (id);

ALTER TABLE
    rent
ADD
    CONSTRAINT FKrent64348 FOREIGN KEY (ownerid) REFERENCES owner (id);

ALTER TABLE
    listing
ADD
    CONSTRAINT FKlisting515627 FOREIGN KEY (Addressid) REFERENCES Address (id);

ALTER TABLE
    rent
ADD
    CONSTRAINT FKrent548686 FOREIGN KEY (listingid) REFERENCES listing (id);

ALTER TABLE
    sell
ADD
    CONSTRAINT FKsell518965 FOREIGN KEY (listingid) REFERENCES listing (id);

ALTER TABLE
    sublease
ADD
    CONSTRAINT FKsublease900801 FOREIGN KEY (listingid) REFERENCES listing (id);

ALTER TABLE
    mortgageProviderListing
ADD
    CONSTRAINT FKmortgagePr126823 FOREIGN KEY (mortgageCompaniesid) REFERENCES mortgageCompanies (id);

ALTER TABLE
    residential
ADD
    CONSTRAINT FKresidentia308035 FOREIGN KEY (listingid) REFERENCES listing (id);

ALTER TABLE
    commercial
ADD
    CONSTRAINT FKcommercial696954 FOREIGN KEY (listingid) REFERENCES listing (id);

ALTER TABLE
    residential
ADD
    CONSTRAINT FKresidentia463363 FOREIGN KEY (facilitiesid) REFERENCES facilities (id);

ALTER TABLE
    residential
ADD
    CONSTRAINT FKresidentia439396 FOREIGN KEY (sizeOfHouseid) REFERENCES sizeOfHouse (id);

ALTER TABLE
    residential
ADD
    CONSTRAINT FKresidentia899798 FOREIGN KEY (houseTypeid) REFERENCES houseType (id);

ALTER TABLE
    sell
ADD
    CONSTRAINT FKsell34627 FOREIGN KEY (ownerid) REFERENCES owner (id);

ALTER TABLE
    sublease
ADD
    CONSTRAINT FKsublease385140 FOREIGN KEY (ownerid) REFERENCES owner (id);

ALTER TABLE
    sell
ADD
    CONSTRAINT FKsell387570 FOREIGN KEY (brokerid) REFERENCES broker (id);

ALTER TABLE
    mortgageProviderListing
ADD
    CONSTRAINT FKmortgagePr953801 FOREIGN KEY (sellid) REFERENCES sell (id);