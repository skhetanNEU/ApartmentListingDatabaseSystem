INSERT INTO
    Address (building, street, city, state, country, zipcode)
VALUES
    ('201', 'Main St', 'Springfield', 'Illinois', 'USA', '62701'),
    ('305', 'Second St', 'Hillside', 'New Jersey', 'USA', '07205'),
    ('402', 'Third Ave', 'Lakeside', 'California', 'USA', '92040'),
    ('150', 'Fourth Blvd', 'Mountain View', 'California', 'USA', '94040'),
    ('120', 'Fifth Rd', 'Riverside', 'California', 'USA', '92501'),
    ('230', 'Sixth Ln', 'Virginia Beach', 'Virginia', 'USA', '23451'),
    ('310', 'Seventh Dr', 'Cliffside Park', 'New Jersey', 'USA', '07010'),
    ('125', 'Eighth Pl', 'Forestville', 'Maryland', 'USA', '20747'),
    ('480', 'Ninth Way', 'Palm Desert', 'California', 'USA', '92260'),
    ('360', 'Tenth Ct', 'Park City', 'Utah', 'USA', '84060'),
    ('101', 'Eleventh St', 'Austin', 'Texas', 'USA', '78701'),
    ('208', 'Twelfth Ave', 'Boston', 'Massachusetts', 'USA', '02108'),
    ('307', 'Thirteenth Blvd', 'Chicago', 'Illinois', 'USA', '60601'),
    ('410', 'Fourteenth Rd', 'Seattle', 'Washington', 'USA', '98101'),
    ('512', 'Fifteenth Ln', 'Denver', 'Colorado', 'USA', '80202'),
    ('156', 'Sixteenth Dr', 'Miami', 'Florida', 'USA', '33101'),
    ('223', 'Seventeenth Pl', 'Las Vegas', 'Nevada', 'USA', '89101'),
    ('332', 'Eighteenth Way', 'Atlanta', 'Georgia', 'USA', '30301'),
    ('449', 'Nineteenth Ct', 'Phoenix', 'Arizona', 'USA', '85001'),
    ('567', 'Twentieth St', 'Houston', 'Texas', 'USA', '77002'),
    ('621', 'Twenty-First Ave', 'Austin', 'Texas', 'USA', '78701'),
    ('734', 'Twenty-Second Blvd', 'Boston', 'Massachusetts', 'USA', '02108'),
    ('204', 'Fourth Ave', 'Lakeside', 'California', 'USA', '92040'),
    ('845', 'Twenty-Third Rd', 'Chicago', 'Illinois', 'USA', '60601'),
    ('969', 'Twenty-Fourth Ln', 'Seattle', 'Washington', 'USA', '98101'),
    ('102', 'Twenty-Fifth Dr', 'Denver', 'Colorado', 'USA', '80202'),
    ('215', 'Twenty-Sixth Pl', 'Miami', 'Florida', 'USA', '33101'),
    ('328', 'Twenty-Seventh Way', 'Las Vegas', 'Nevada', 'USA', '89101'),
    ('437', 'Twenty-Eighth Ct', 'Atlanta', 'Georgia', 'USA', '30301'),
    ('546', 'Twenty-Ninth St', 'Phoenix', 'Arizona', 'USA', '85001'),
    ('655', 'Thirtieth Ave', 'Houston', 'Texas', 'USA', '77002'),
    ('404', 'Third Ave', 'Lakeside', 'California', 'USA', '92040');

INSERT INTO
    Person (
        first_name,
        last_name,
        phone_number,
        email,
        dob,
        Addressid
    )
VALUES
    ('John', 'Doe', '1234567890', 'john.doe@example.com', '1980-01-01', 1),
    ('Jane', 'Smith', '2234567890', 'jane.smith@example.com', '1981-02-01', 2),
    ('Alice', 'Johnson', '3234567890', 'alice.johnson@example.com', '1982-03-01', 3),
    ('Bob', 'Brown', '4234567890', 'bob.brown@example.com', '1983-04-01', 4),
    ('Charlie', 'Davis', '5234567890', 'charlie.davis@example.com', '1984-05-01', 5),
    ('Diana', 'Evans', '6234567890', 'diana.evans@example.com', '1985-06-01', 6),
    ('Ethan', 'Foster', '7234567890', 'ethan.foster@example.com', '1986-07-01', 7),
    ('Fiona', 'Garcia', '8234567890', 'fiona.garcia@example.com', '1987-08-01', 8),
    ('George', 'Hill', '9234567890', 'george.hill@example.com', '1988-09-01', 9),
    ('Hannah', 'Irvine', '1023456770', 'hannah.irvine@example.com', '1989-10-01', 10),
    ('Ivan', 'Jackson', '1123456789', 'ivan.jackson@example.com', '1990-11-01', 1),
    ('Julia', 'Keller', '1223456789', 'julia.keller@example.com', '1991-12-01', 2),
    ('Kevin', 'Lee', '1323456789', 'kevin.lee@example.com', '1992-01-02', 11),
    ('Luna', 'Morgan', '1423456789', 'luna.morgan@example.com', '1993-02-02', 12),
    ('Miles', 'Nolan', '1523456789', 'miles.nolan@example.com', '1994-03-02', 13),
    ('Nina', 'Ortega', '1623456789', 'nina.ortega@example.com', '1995-04-02', 14),
    ('Oliver', 'Perez', '1723456789', 'oliver.perez@example.com', '1996-05-02', 5),
    ('Penelope', 'Quinn', '1823456789', 'penelope.quinn@example.com', '1997-06-02', 6),
    ('Quincy', 'Reed', '1923456789', 'quincy.reed@example.com', '1998-07-02', 7),
    ('Rachel', 'Stewart', '2023456789', 'rachel.stewart@example.com', '1999-08-02', 8),
    ('Rachel', 'Green', '2023456779', 'rachel.green@example.com', '1997-07-05', 8);

   


INSERT INTO
    houseType (type)
VALUES
    ('Detached'),
    ('Semi-Detached'),
    ('Townhouse'),
    ('Condo'),
    ('Apartment'),
    ('Loft'),
    ('Studio'),
    ('Duplex'),
    ('Triplex'),
    ('Bungalow');
    


INSERT INTO
    facilities (water, gas, laundry, trash)
VALUES
    (1, 1, 1, 1),
    (0, 1, 0, 1),
    (1, 0, 1, 0),
    (0, 0, 1, 1),
    (1, 1, 0, 0),
    (0, 1, 1, 0),
    (1, 0, 0, 1),
    (0, 0, 0, 0),
    (1, 1, 1, 0),
    (0, 1, 0, 0);

INSERT INTO
    sizeOfHouse (rooms, bathrooms)
VALUES
    (1,1),
    (2,1),
    (2,2),
    (3,1),
    (3,2),
    (3,3),
    (4,1),
    (4,2),
    (4,3),
    (5,1),
    (5,2),
    (5,3);
    
INSERT INTO
    listing (Addressid, dateOfListing)
VALUES
    (1, '2022-01-01'),
    (2, '2022-01-15'),
    (3, '2022-02-01'),
    (4, '2022-02-15'),
    (5, '2022-03-01'),
    (6, '2022-03-15'),
    (7, '2022-04-01'),
    (8, '2022-04-15'),
    (9, '2022-05-01'),
    (10, '2022-05-15'),
    (11, '2022-06-01'),
    (15, '2022-07-15'),
    (20, '2022-08-01'),
    (23, '2022-08-01'),
    (25, '2022-09-15'),
    (30, '2022-10-01'),
    (17, '2023-01-15'),
    (12, '2023-02-01'),
    (19, '2023-03-15'),
    (22, '2023-04-01'),
    (27, '2023-05-15'),
    (32, '2023-05-27');


INSERT INTO
    broker (broker_permit, rating, joining_date, Personid)
VALUES
    ('BP1001', 4, '2021-01-01', 1),
    ('BP1002', 5, '2021-01-15', 2),
    ('BP1003', 3, '2022-02-01', 3),
    ('BP1004', 4, '2022-02-15', 4),
    ('BP1005', 5, '2020-03-01', 5),
    ('BP1006', 4, '2020-03-15', 6),
    ('BP1007', 3, '2022-04-01', 7),
    ('BP1008', 5, '2022-04-15', 8),
    ('BP1009', 4, '2019-05-01', 9),
    ('BP1010', 3, '2019-05-15', 10);
    
INSERT INTO
    owner (number_of_listing, Personid)
VALUES
    (2, 1),
    (3, 2),
    (1, 3),
    (4, 4),
    (2, 5),
    (3, 6),
    (1, 7),
    (4, 8),
    (2, 9),
    (3, 10);

INSERT INTO
    commercial (permit, listingid)
VALUES
    (2001, 1),
    (2002, 2),
    (2003, 3),
    (2004, 4),
    (2005, 5),
    (2006, 6),
    (2007, 7),
    (2008, 8),
    (2009, 9),
    (2010, 10);


INSERT INTO
    residential (
        max_occupant,
        listingid,
        facilitiesid,
        sizeOfHouseid,
        houseTypeid
    )
VALUES
    (4, 1, 1, 1, 1),
    (3, 2, 2, 2, 2),
    (5, 3, 3, 3, 3),
    (2, 4, 4, 4, 4),
    (6, 5, 5, 5, 5),
    (4, 6, 6, 6, 6),
    (3, 7, 7, 7, 7),
    (5, 8, 8, 8, 8),
    (2, 9, 9, 9, 9),
    (6, 10, 10, 10, 10);

INSERT INTO
    sell (
        buying_price,
        mortgage_allowed,
        listingid,
        ownerid,
        brokerid
    )
VALUES
    (300000, 1, 1, 1, 1),
    (250000, 0, 2, 2, 2),
    (500000, 1, 3, 3, 3),
    (450000, 0, 4, 4, 4),
    (350000, 1, 5, 5, 5),
    (400000, 0, 6, 6, 6),
    (550000, 1, 7, 7, 7),
    (600000, 0, 8, 8, 8),
    (650000, 1, 9, 9, 9),
    (700000, 0, 10, 10, 10);

INSERT INTO
    rent (
        ownerid,
        brokerid,
        lease_start_date,
        lease_end_date,
        listingid
    )
VALUES
    (1, 1, '2023-01-01', '2023-12-31', 1),
    (2, 2, '2023-02-01', '2024-01-31', 2),
    (3, 3, '2023-03-01', '2024-02-28', 3),
    (4, 4, '2023-04-01', '2024-03-31', 4),
    (5, 5, '2023-05-01', '2024-04-30', 5),
    (6, 6, '2023-06-01', '2024-05-31', 6),
    (7, 7, '2023-07-01', '2024-06-30', 7),
    (8, 8, '2023-08-01', '2024-07-31', 8),
    (9, 9, '2023-09-01', '2024-08-31', 9),
    (10, 10, '2023-10-01', '2024-09-30', 10);

INSERT INTO
    mortgageCompanies (name)
VALUES
    ('Mortgage One'),
    ('Mortgage Two'),
    ('Mortgage Three'),
    ('Mortgage Four'),
    ('Mortgage Five'),
    ('Mortgage Six'),
    ('Mortgage Seven'),
    ('Mortgage Eight'),
    ('Mortgage Nine'),
    ('Mortgage Ten');



INSERT INTO
    mortgageProviderListing (mortgageCompaniesid, sellid)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8),
    (9, 9),
    (10, 10);
    
INSERT INTO
    sublease (
        rooms_available,
        rooms_occupied,
        mixed_gender,
        parking_available,
        listingid,
        ownerid
    )
VALUES
    (2, 1, 1, 1, 1, 1),
    (3, 2, 0, 0, 2, 2),
    (4, 3, 1, 1, 3, 3),
    (1, 0, 0, 0, 4, 4),
    (2, 2, 1, 1, 5, 5),
    (3, 1, 0, 0, 6, 6),
    (1, 1, 1, 1, 7, 7),
    (2, 2, 0, 0, 8, 8),
    (3, 3, 1, 1, 9, 9),
    (4, 4, 0, 0, 10, 10);