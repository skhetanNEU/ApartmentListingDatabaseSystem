-- Procedure to add a broker.
DROP PROCEDURE IF EXISTS RegisterComprehensiveBroker;
    
DELIMITER //

CREATE PROCEDURE RegisterComprehensiveBroker(
    IN _building VARCHAR(255),
    IN _street VARCHAR(255),
    IN _city VARCHAR(255),
    IN _state VARCHAR(255),
    IN _country VARCHAR(255),
    IN _zipcode VARCHAR(5),
    IN _first_name VARCHAR(255),
    IN _last_name VARCHAR(255),
    IN _phone_number varchar(255),
    IN _email VARCHAR(255),
    IN _dob DATE,
    IN _broker_permit VARCHAR(255),
    IN _rating INT,
    IN _joining_date DATE,
    IN _agency_name VARCHAR(100)
)
BEGIN
    DECLARE _Addressid INT;
    DECLARE _Personid INT;

    -- Check for existing address
    IF AddressExists(_building, _street, _city, _state, _country, _zipcode) = 0 THEN
        INSERT INTO Address (building, street, city, state, country, zipcode)
        VALUES (_building, _street, _city, _state, _country, _zipcode);
        SET _Addressid = LAST_INSERT_ID();
    ELSE
        SELECT id INTO _Addressid FROM Address 
        WHERE building = _building AND street = _street AND city = _city 
        AND state = _state AND country = _country AND zipcode = _zipcode
        LIMIT 1;
    END IF;

    -- Check for existing person
    IF PersonExists(_first_name, _last_name, _phone_number, _email, _dob) = 0 THEN
        INSERT INTO Person (first_name, last_name, phone_number, email, dob, Addressid)
        VALUES (_first_name, _last_name, _phone_number, _email, _dob, _Addressid);
        SET _Personid = LAST_INSERT_ID();
    ELSE
        SELECT id INTO _Personid FROM Person 
        WHERE first_name = _first_name AND last_name = _last_name 
        AND phone_number = _phone_number AND email = _email
        LIMIT 1;
    END IF;

    -- Insert broker details
    INSERT INTO broker (broker_permit, rating, joining_date, Personid, agency_name)
    VALUES (_broker_permit, _rating, _joining_date, _Personid, _agency_name);
END //

DELIMITER ;

/*
-- Demonstartion of entirely new broker.
CALL RegisterComprehensiveBroker(
    '123',                     -- Building
    'Market Street',           -- Street
    'Newtown',                 -- City
    'NY',                      -- State
    'USA',                     -- Country
    '10001',                   -- Zipcode
    'Jane',                    -- First name
    'Smith',                   -- Last name
    '5551234567',                -- Phone number
    'jane.smith2021@example.com',  -- Email
    '1985-02-15',              -- Date of Birth
    'BP2002',                  -- Broker permit
    5,                         -- Rating
    '2023-01-01',              -- Joining date
    'Smith Realty'             -- Agency name
);

SELECT * FROM Address AS ad
INNER JOIN Person AS pr 
ON pr.Addressid =  ad.id
INNER JOIN Broker AS br 
ON br.PersonId = pr.id
WHERE ad.building = '123' and pr.email = 'jane.smith2021@example.com';

-- Demonstartion of new broker if address already exists.

CALL RegisterComprehensiveBroker(
    '123',                     -- Building
    'Market Street',           -- Street
    'Newtown',                 -- City
    'NY',                      -- State
    'USA',                     -- Country
    '10001',                   -- Zipcode
    'Paula',                    -- First name
    'Adeline',                   -- Last name
    '5557734567',                -- Phone number
    'adeline.paula@example.com',  -- Email
    '1985-02-15',              -- Date of Birth
    'BP2032',                  -- Broker permit
    5,                         -- Rating
    '2019-01-01',              -- Joining date
    'Gray Realty'             -- Agency name
);

SELECT * FROM Address AS ad
INNER JOIN Person AS pr 
ON pr.Addressid =  ad.id
INNER JOIN Broker AS br 
ON br.PersonId = pr.id
WHERE ad.building = '123' and pr.email = 'adeline.paula@example.com';

*/
-- Stored procedure to Add Mortgage Company 


DROP PROCEDURE IF EXISTS AddMortgageCompany;
DELIMITER //
CREATE PROCEDURE AddMortgageCompany(
    IN _name VARCHAR(255)
)
BEGIN
    -- Check if a mortgage company with the specified name already exists
    IF NOT EXISTS (SELECT * FROM mortgageCompanies WHERE name = _name) THEN
        -- Insert the new mortgage company since it does not exist
        INSERT INTO mortgageCompanies(name)
        VALUES (_name);
    END IF;
END //

DELIMITER ;

/*
-- Demonstartion of stored procedure
CALL AddMortgageCompany('Acme Mortgages');

SELECT * FROM mortgageCompanies where name = 'Acme Mortgages';

-- For Company names already in the table, no new entry is created. 
CALL AddMortgageCompany('Acme Mortgages');

SELECT * FROM mortgageCompanies where name = 'Acme Mortgages';

*/
-- Stored procedure to list properties by city.

DROP PROCEDURE IF EXISTS ListPropertiesByState;

DELIMITER //
CREATE PROCEDURE ListPropertiesByState(
    IN _state VARCHAR(255)
)
BEGIN
    SELECT * FROM listing l
    JOIN Address a ON l.Addressid = a.id
    WHERE a.state = _state;
END //
DELIMITER ;

/*
-- Demonstartion of stored procedure. 
CALL ListPropertiesByState('California');

*/
-- Stored procedure for adding new listing

DROP PROCEDURE IF EXISTS AddPropertyListing;

DELIMITER //
CREATE PROCEDURE AddPropertyListing(
    IN _building VARCHAR(255),
    IN _street VARCHAR(255),
    IN _city VARCHAR(255),
    IN _state VARCHAR(255),
    IN _country VARCHAR(255),
    IN _zipcode VARCHAR(5),
    IN _dateOfListing DATE
)
BEGIN
    INSERT INTO Address(building, street, city, state, country, zipcode)
    VALUES (_building, _street, _city, _state, _country, _zipcode);

    INSERT INTO listing(Addressid, dateOfListing)
    VALUES (LAST_INSERT_ID(), _dateOfListing);
END //
DELIMITER ; 

/*
-- Demonstartion of stored procedure.
CALL AddPropertyListing('67', 'Main St', 'Springfield', 'StateA', 'CountryX', '12345', '2021-01-01');

SELECT * FROM listing l
    JOIN Address a ON l.Addressid = a.id
    WHERE a.building = '67';
 */ 


-- Stored procedure to list properties by city.

DROP PROCEDURE IF EXISTS ListPropertiesByZipcode;

DELIMITER //
CREATE PROCEDURE ListPropertiesByZipcode(
    IN _zipcode VARCHAR(255)
)
BEGIN
    SELECT * FROM listing l
    JOIN Address a ON l.Addressid = a.id
    WHERE a.zipcode = _zipcode;
END //
DELIMITER ;

/*
-- Demonstartion of stored procedure. 
CALL ListPropertiesByZipcode('92040');
*/

    
    
