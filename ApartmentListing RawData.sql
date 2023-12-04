INSERT INTO
    Address (building, street, city, state, country)
VALUES
    (
        '101',
        'Main St',
        'Springfield',
        'StateA',
        'CountryX'
    ),
    (
        '102',
        'Second St',
        'Hillside',
        'StateB',
        'CountryY'
    ),
    (
        '103',
        'Third Ave',
        'Lakeside',
        'StateC',
        'CountryZ'
    ),
    (
        '104',
        'Fourth Blvd',
        'Mountainview',
        'StateD',
        'CountryW'
    ),
    (
        '105',
        'Fifth Rd',
        'Riverside',
        'StateE',
        'CountryV'
    ),
    (
        '106',
        'Sixth Ln',
        'Beachside',
        'StateF',
        'CountryU'
    ),
    (
        '107',
        'Seventh Dr',
        'Cliffside',
        'StateG',
        'CountryT'
    ),
    (
        '108',
        'Eighth Pl',
        'Forestville',
        'StateH',
        'CountryS'
    ),
    (
        '109',
        'Ninth Way',
        'Deserttown',
        'StateI',
        'CountryR'
    ),
    (
        '110',
        'Tenth Ct',
        'Snowtown',
        'StateJ',
        'CountryQ'
    );

INSERT INTO
    broker (broker_permit, rating, joining_date, Personid)
VALUES
    ('BP1001', 4, '2022-01-01', 1),
    ('BP1002', 5, '2022-01-15', 2),
    ('BP1003', 3, '2022-02-01', 3),
    ('BP1004', 4, '2022-02-15', 4),
    ('BP1005', 5, '2022-03-01', 5),
    ('BP1006', 4, '2022-03-15', 6),
    ('BP1007', 3, '2022-04-01', 7),
    ('BP1008', 5, '2022-04-15', 8),
    ('BP1009', 4, '2022-05-01', 9),
    ('BP1010', 3, '2022-05-15', 10);

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
    (10, '2022-05-15');

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
    Person (
        first_name,
        last_name,
        phone_number,
        email,
        dob,
        Addressid
    )
VALUES
    (
        'John',
        'Doe',
        1234567890,
        'john.doe@example.com',
        '1980-01-01',
        1
    ),
    (
        'Jane',
        'Smith',
        2234567890,
        'jane.smith@example.com',
        '1981-02-01',
        2
    ),
    (
        'Alice',
        'Johnson',
        3234567890,
        'alice.johnson@example.com',
        '1982-03-01',
        3
    ),
    (
        'Bob',
        'Brown',
        4234567890,
        'bob.brown@example.com',
        '1983-04-01',
        4
    ),
    (
        'Charlie',
        'Davis',
        5234567890,
        'charlie.davis@example.com',
        '1984-05-01',
        5
    ),
    (
        'Diana',
        'Evans',
        6234567890,
        'diana.evans@example.com',
        '1985-06-01',
        6
    ),
    (
        'Ethan',
        'Foster',
        7234567890,
        'ethan.foster@example.com',
        '1986-07-01',
        7
    ),
    (
        'Fiona',
        'Garcia',
        8234567890,
        'fiona.garcia@example.com',
        '1987-08-01',
        8
    ),
    (
        'George',
        'Hill',
        9234567890,
        'george.hill@example.com',
        '1988-09-01',
        9
    ),
    (
        'Hannah',
        'Irvine',
        10234567890,
        'hannah.irvine@example.com',
        '1989-10-01',
        10
    );

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
    (5,3)
    
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