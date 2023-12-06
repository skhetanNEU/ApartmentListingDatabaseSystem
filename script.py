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


houseType = None
facilities = None
sizeOfHouse = None
resiential = None
address = None
with open('test.json', 'r') as json_file:
    data = json.load(json_file)
    
    #Address Mapping
    addressData = data['address']
    pattern = re.compile(r'(UNIT\s+\S+)')
    # Use the findall method to extract matches
    matches = pattern.findall(data['streetAddress'])
    if matches:
        unit_number = matches[0]
        print(unit_number)
    else:
        unit_number = ""
        print("No unit number found.")
    address = Address(unit_number,addressData['streetAddress'], addressData['city'], addressData['state'], addressData['zipcode'], 'USA')


    #Facilities Mapping
    resoFacts = data['resoFacts']
    if resoFacts:
        associationFeeIncludes = resoFacts['associationFeeIncludes']
        if associationFeeIncludes:
            trash = any(item in "Trash" for item in associationFeeIncludes)
            gas = any(item in "Gas" for item in associationFeeIncludes)
            water = any(item in "Water" for item in associationFeeIncludes)
        laundryFeatures = resoFacts['laundryFeatures']
        if laundryFeatures:
            laundry = True if len(laundryFeatures) > 0 else False
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
    email = first_name +"."+ last_name +"+test"+"@outlook.com"
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
        password = '',
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
                facilities_id = cursor.fetchone()[0]
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
                houseType_id = cursor.fetchone()[0]
                houseType.setId(houseType_id)


                #insert the listing data to the listing table
                listing_query = "INSERT INTO listing (addressid, dateOfListing) VALUES (%s, %s)"
                #get the id of the address from the address table
                address_query = "SELECT id FROM address WHERE building=%s AND street=%s AND city=%s AND state=%s AND zipcode=%s AND country=%s"
                address_values = (address.building, address.street, address.city, address.state, address.zip_code, address.country)
                print(address_values)
                cursor.execute(address_query, address_values)
                address_id = cursor.fetchone()[0]
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
                listing_id = cursor.fetchone()[0]
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
                person_query = "INSERT INTO person (first_name, last_name, phone_number, email, dob) VALUES (%s, %s, %s, %s, %s)"
                person_values = (person.first_name, person.last_name, person.phone_number, person.email, person.dob)
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
                person_query = "SELECT id FROM person WHERE first_name=%s AND last_name=%s AND phone_number=%s AND email=%s AND dob=%s"
                person_values = (person.first_name, person.last_name, person.phone_number, person.email, person.dob)
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