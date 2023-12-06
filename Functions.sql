DELIMITER //

-- Function to check if address already exists.
CREATE FUNCTION AddressExists(
    _building VARCHAR(255),
    _street VARCHAR(255),
    _city VARCHAR(255),
    _state VARCHAR(255),
    _country VARCHAR(255),
    _zipcode VARCHAR(5)
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE addr_exists INT;
    SELECT COUNT(*) INTO addr_exists FROM Address
    WHERE building = _building AND street = _street AND city = _city 
    AND state = _state AND country = _country AND zipcode = _zipcode;
    RETURN addr_exists > 0;
END //

DELIMITER ;

-- Demonstartion of AddressExists function.
SELECT AddressExists( '101', 'Main St', 'Springfield', 'StateA', 'CountryX', '12345') as DoesAddressExist;

-- Demonstartion of AddressExists function.
SELECT AddressExists('123', 'Market Street', 'Parksville', 'NY', 'USA', '10021') as DoesAddressExist;


-- Function to check if person already exists.
DELIMITER //

CREATE FUNCTION PersonExists(
    _first_name VARCHAR(255),
    _last_name VARCHAR(255),
    _phone_number VARCHAR(255),
    _email VARCHAR(255),
	_dob date 
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE person_exists INT;
    SELECT COUNT(*) INTO person_exists FROM Person
    WHERE first_name = _first_name AND last_name = _last_name 
    AND phone_number = _phone_number AND email = _email
    AND dob = _dob;
    RETURN person_exists > 0;
END //

DELIMITER ;

-- Demonstartion of PersonExists function.
SELECT PersonExists(
        'Ethan',
        'Foster',
        '7234567890',
        'ethan.foster@example.com',
        '1986-07-01'
    ) as DoesPersonExist;
    
-- Demonstartion of PersonExists function.
SELECT PersonExists(
        'Ether',
        'Fost',
        '7233567890',
        'ether.fost@beta.com',
        '1986-07-05'
    ) as DoesPersonExist;
    
    
    -- Function to find number of listings in a state
 
 DELIMITER //

CREATE FUNCTION TotalListingsInCity(_state VARCHAR(255))
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM listing
    JOIN Address ON listing.Addressid = Address.id
    WHERE Address.state = _state;
    RETURN total;
END //

DELIMITER ;

-- Demonstration of function

SELECT TotalListingsInCity('StateC');

-- Function to find average broker rating

DELIMITER //

CREATE FUNCTION AverageBrokerRating()
RETURNS DECIMAL(3,2) DETERMINISTIC
BEGIN
    DECLARE avg_rating DECIMAL(3,2);
    SELECT AVG(rating) INTO avg_rating FROM broker;
    RETURN avg_rating;
END //

DELIMITER ;
 
-- Demonstration of function
SELECT AverageBrokerRating();