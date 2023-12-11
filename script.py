import json
from random import Random
import re
from mysql.connector import connect, cursor, Error

class Address:
    def __init__(self, building, street, city, state, zip_code, country, id = 0):
        self.building = building
        self.street = street
        self.city = city
        self.state = state
        self.zip_code = zip_code
        self.country = country

    def setId(self, id):
        self.id = id

class Residential:
    def __init__(self, max_occupant, id = 0):
        self.max_occupant = max_occupant

    def setId(self, id):
        self.id = id

class Facilities:
    def __init__(self, trash, gas, water, laundry, id = 0):
        self.trash = trash
        self.gas = gas
        self.water = water
        self.laundry = laundry
    
    def setId(self, id):
        self.id = id

class SizeOfHouse:
    def __init__(self, rooms=0, bathrooms=0, id = 0):
        self.rooms = rooms
        self.bathrooms = bathrooms

    def setId(self, id):
        self.id = id

class HouseType:
    def __init__(self, type, id = 0):
        self.type = type

    def setId(self, id):
        self.id = id

class Listing:
    def __init__(self, dateOfListing, id = 0):
        self.dateOfListing = dateOfListing

    def setId(self, id):
        self.id = id

class Person:
    def __init__(self, first_name, last_name, phone_number, email, dob, id = 0):
        self.first_name = first_name
        self.last_name = last_name
        self.phone_number = phone_number
        self.email = email
        self.dob = dob

    def setId(self, id):
        self.id = id

class Broker:
    def __init__(self, broker_permit, agency_name, rating, joining_date, person_id = 0, id = 0):
        self.agency_name = agency_name
        self.rating = rating
        self.joining_date = joining_date
        self.person_id = person_id
        self.broker_permit = broker_permit

    def setPersonId(self, person_id):
        self.person_id = person_id

    def setId(self, id):
        self.id = id


# read the json file from the data directory in the current directory
import os
r = []
for root, dirs, files in os.walk("data"):
    for file in files:
        if file.endswith(".json"):
             r.append(os.path.join(root, file))

for i in r:
    with open(i, 'r') as json_file:
        data = json.load(json_file)
        
        houseType = None
        facilities = None
        sizeOfHouse = None
        resiential = None
        address = None


        #Address Mapping
        addressData = data['address']
        # Use a regular expression to extract the unit number or apartment number
        pattern = re.compile(r'(UNIT\s+\S+)|(APT\s+\S+)|(APT\s+\S+\s+\S+)|(UNIT\s+\S+\s+\S+)', re.IGNORECASE)
        # Use the findall method to extract matches
        matches = pattern.finditer(data['streetAddress'])
        # If a match is found, extract the unit number
        unit_number = ""
        for match in matches:
            unit_number = match.group(0)
            print(match.group(0))
            print("Unit number found:", unit_number)        
        address = Address(unit_number,addressData['streetAddress'], addressData['city'], addressData['state'], addressData['zipcode'], 'USA')


        #Facilities Mapping
        resoFacts = data['resoFacts']
        if resoFacts:
            associationFeeIncludes = resoFacts['associationFeeIncludes']
            trash = False
            gas = False
            water = False
            laundry = False
            if associationFeeIncludes:
                trash = any(item in "Trash" for item in associationFeeIncludes)
                gas = any(item in "Gas" for item in associationFeeIncludes)
                water = any(item in "Water" for item in associationFeeIncludes)
            if resoFacts["gas"]:
                gas = True
            if resoFacts["waterSource"]:
                water = True
            if resoFacts["laundryFeatures"]:
                laundry = True
            
        facilities = Facilities(trash, gas, water, laundry)
        
        
        #sizeOfHouse Mapping
        sizeOfHouse = SizeOfHouse(data['bedrooms'], data['bathrooms'])

        
        #houseType Mapping
        houseType = HouseType(data['homeType'])

        
        #Listing Mapping
        listing = Listing(data['datePosted'])

        #Residential Mapping
        residential = Residential(sizeOfHouse.rooms * 2)


        #Person Mapping
        listed_by = data['listed_by']
        display_name = listed_by['display_name']
        name = display_name.split()
        if name and len(name) > 1:
            last_name = name[1]
        first_name = name[0]
        phone = listed_by['phone']
        if phone:
            phone_number = phone['areacode']  + phone['prefix'] + phone['number']
        else:
            #generate random phone number
            phone_number = Random().randint(1000000000, 9999999999).__str__()
        email = first_name +"."+ last_name +"+test"+"@example.com"
        ##Generate radom date of birth between 1970 and 2000
        dob = Random().randint(1970, 2000)
        dob = str(dob) + "-01-01"
        person = Person(first_name, last_name, phone_number, email, dob)



        #Broker Mapping
        listed_by = data['listed_by']
        broker_permit = listed_by['zuid']
        broker_rating = Random().randint(1, 5)
        ##Generate random date should be between 2000 and 2010
        joining_date = Random().randint(2000, 2010)
        joining_date = str(joining_date) + "-01-01"
        agency_name = listed_by['business_name']
        broker = Broker(broker_permit, agency_name, broker_rating, joining_date)

    conn = None
    try: 
        conn =connect(
            host = 'localhost',
            user = 'root',
            password = 'root',
            database = 'apartments_db'
        )
            
        if conn.is_connected():
            print("connected")


            with conn.cursor() as cursor:
                try:
                    address_query = "INSERT INTO address (building, street, city, state, zipcode, country) VALUES (%s, %s, %s, %s, %s, %s)"
                    address_values = (address.building, address.street, address.city, address.state, address.zip_code, address.country)
                    cursor.execute(address_query, address_values)
                    conn.commit()
                except Error as ex:
                    # Rollback in case of an exception
                    conn.rollback()
                    print("Error executing SQL queries:", ex)

            with conn.cursor() as cursor:
                try:
                    facilities_query = "SELECT id FROM facilities WHERE trash=%s AND gas=%s AND water=%s AND laundry=%s"
                    facilities_values = (facilities.trash, facilities.gas, facilities.water, facilities.laundry)
                    cursor.execute(facilities_query, facilities_values)
                    result = cursor.fetchall()
                    if len(result) < 1:
                        facilities_query = "INSERT INTO facilities (trash, gas, water, laundry) VALUES (%s, %s, %s, %s)"
                        cursor.execute(facilities_query, facilities_values)
                        conn.commit()
                    cursor.execute(facilities_query, facilities_values)
                    facilities_id =  cursor.fetchall()[0][0]
                    #TODO: create a new row if the data is not present using a insert query and do select query to get the id
                    facilities.setId(facilities_id)


                    #select the id of the sizeOfHouse
                    #TODO: create a new row if the data is not present using a stored procedure
                    sizeOfHouse_query = "SELECT id FROM sizeOfHouse WHERE rooms=%s AND bathrooms=%s"
                    sizeOfHouse_values = (sizeOfHouse.rooms, sizeOfHouse.bathrooms)
                    cursor.execute(sizeOfHouse_query, sizeOfHouse_values)
                    sizeOfHouse_id = cursor.fetchone()[0]
                    sizeOfHouse.setId(sizeOfHouse_id)


                    #select the id of the houseType
                    houseType_query = "SELECT id FROM houseType WHERE type=%s"
                    houseType_values = (houseType.type,)
                    cursor.execute(houseType_query, houseType_values)
                    #TODO: create a new row if the data is not present using a insert query and select query to get the id
                    houseType_id = cursor.fetchall()
                    if len(houseType_id) < 1:
                        houseTypeInsert_query = "INSERT INTO houseType (type) VALUES (%s)"
                        cursor.execute(houseTypeInsert_query, houseType_values)
                        conn.commit()
                    cursor.execute(houseType_query, houseType_values)
                    houseType_id = cursor.fetchall()[0][0]
                    houseType.setId(houseType_id)

                except Error as ex:
                    # Rollback in case of an exception
                    conn.rollback()
                    print("Error executing SQL queries:", ex)

            with conn.cursor() as cursor:
                try:
                    #insert the listing data to the listing table
                    listing_query = "INSERT INTO listing (addressid, dateOfListing) VALUES (%s, %s)"
                    #get the id of the address from the address table
                    address_query = "SELECT id FROM address WHERE building=%s AND street=%s AND city=%s AND state=%s AND zipcode=%s AND country=%s"
                    address_values = (address.building, address.street, address.city, address.state, address.zip_code, address.country)
                    cursor.execute(address_query, address_values)
                    address_id = cursor.fetchall()[0][0]
                    listing_values = (address_id, listing.dateOfListing)
                    cursor.execute(listing_query, listing_values)
                    conn.commit()
                except Error as ex:
                    # Rollback in case of an exception
                    conn.rollback()
                    print("Error executing SQL queries:", ex)
                

            with conn.cursor() as cursor:
                try:
                    #insert the residential data to the residential table
                    residential_query = "INSERT INTO residential (max_occupant, listingid, facilitiesid, sizeOfHouseid, houseTypeid) VALUES (%s, %s, %s, %s, %s)"
                    #get the id of the listing from the listing table
                    listing_query = "SELECT id FROM listing WHERE addressid=%s AND dateOfListing=%s"
                    listing_values = (address_id, listing.dateOfListing)
                    cursor.execute(listing_query, listing_values)
                    listing_id = cursor.fetchall()[0][0]
                    residential_values = (residential.max_occupant, listing_id, facilities.id, sizeOfHouse.id, houseType.id)
                    cursor.execute(residential_query, residential_values)
                    conn.commit()
                    print("Data inserted successfully")

                except Error as ex:
                    # Rollback in case of an exception
                    conn.rollback()
                    print("Error executing SQL queries:", ex)

            with conn.cursor() as cursor:
                try:  
                    #insert data into person table and broker table
                    person_query = "INSERT INTO person (first_name, last_name, phone_number, email, dob, addressid) VALUES (%s, %s, %s, %s, %s, %s)"
                    person_values = (person.first_name, person.last_name, person.phone_number, person.email, person.dob, 1)
                    cursor.execute(person_query, person_values)
                    conn.commit()
                    print("Data inserted successfully")
                
                except Error as ex:
                    # Rollback in case of an exception
                    conn.rollback()
                    print("Error executing SQL queries:", ex)

            with conn.cursor() as cursor:
                try:
                    #insert data into broker table
                    #get the id of the person from the person table
                    person_query = "SELECT id FROM person WHERE email=%s"
                    person_values = (person.email,)
                    cursor.execute(person_query, person_values)
                    person_id = cursor.fetchone()[0]
                    broker.setPersonId(person_id)
                    broker_query = "INSERT INTO broker (broker_permit, agency_name, rating, joining_date, personid) VALUES (%s, %s, %s, %s, %s)"
                    broker_values = (broker.broker_permit, broker.agency_name, broker.rating, broker.joining_date, broker.person_id)
                    cursor.execute(broker_query, broker_values)
                    conn.commit()
                    print("Data inserted successfully")
                
                except Error as ex:
                    # Rollback in case of an exception
                    conn.rollback()
                    print("Error executing SQL queries:", ex)


    except Error as ex:
        print("Error connecting to database", ex)

    finally:
    # Close the connection in the finally block
        if conn.is_connected():
            conn.close()
            print("Connection closed")