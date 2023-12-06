
-- Trigger to validate phone number is of 10 digits.
DELIMITER //

CREATE TRIGGER CheckPhoneNumberLength
BEFORE INSERT ON Person
FOR EACH ROW
BEGIN
    IF LENGTH(NEW.phone_number) <> 10 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Phone number must be exactly 10 digits';
    END IF;
END //

DELIMITER ;

-- Demonstartion of trigger.
INSERT INTO
    Address (building, street, city, state, country, zipcode)
VALUES
    ('111', 'Lower St', 'Springfield', 'StateA', 'CountryX', '12345');

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
        '1230',
        'john.doe1996@example.com',
        '1980-01-01',
        10
    );
    
 

DELIMITER //

CREATE TRIGGER CheckAddressBeforeInsert
BEFORE INSERT ON Address
FOR EACH ROW
BEGIN
    IF AddressExists(NEW.building, NEW.street, NEW.city, NEW.state, NEW.country, NEW.zipcode) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Address already exists. Insertion canceled.';
    END IF;
END //

DELIMITER ;

-- Demonstartion of trigger.
INSERT INTO
    Address (building, street, city, state, country, zipcode)
VALUES
    ('111', 'Lower St', 'Springfield', 'StateA', 'CountryX', '12345');
    
    -- Demonstartion of trigger.
INSERT INTO
    Address (building, street, city, state, country, zipcode)
VALUES
    ('121', 'Upper St', 'Springfield', 'StateA', 'CountryX', '12345');