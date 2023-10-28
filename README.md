# Apartment Listing Database System

The Apartment Listings Management System (ALMS) will serve as an integrated digital platform designed to centralize and simplify the various dimensions of the real estate market. Acting as a bridge between property listers, such as sellers and brokers, and seekers, like buyers and renters, ALMS aspires to make property-related activities—ranging from listing to transaction—both transparent and efficient. We have taken inspiration from platforms like Zillow, which offer a user-centric experience in the realm of real estate. 

Key Features: 
1. Individualized profiles catered to buyers, sellers, brokers, and administrators.
2. Empower users with comprehensive search capabilities that allow filtering based on numerous criteria such as location, size, amenities, and budget.
3. A transparent platform where buyers or renters can openly rate and provide feedback on properties and their associated brokers. This ensures that prospective buyers/renters can make informed decisions based on the past experiences of others.
4. Tables: Defined for various entities, including apartments, buyers, sellers, brokers, transactions, and reviews.
5. Relationships: Established between tables to represent associations. For instance, a broker might represent multiple properties, or a buyer might make inquiries on multiple listings.
6. Constraints: Implemented to maintain data integrity, such as validating price formats, ensuring appropriate date entries, and verifying phone numbers.


# Database Design Relational Schema: 


![image](https://github.com/skhetanNEU/Apartment_Listing_Database_System/assets/98121476/3c5f366a-d7e5-42e9-8eb0-b1fda9fe9ddb)


1. Address ( id , building, street, city, state, country) Primary Key: id
2. Broker ( id , broker_permit, rating, joining_date, Personid) Primary Key: id Foreign Key: Personid references Person
3. Commercial ( id , permit, listingid) Primary Key: id Foreign Key: listingid references Listing
4. Facilities ( id , water, gas, laundry, trash) Primary Key: id
5. HouseType ( id , type) Primary Key: id
6. Listing ( id , Addressid, dateOfListing) Primary Key: id Foreign Key: Addressid references Address
7. MortgageCompanies ( id , name) Primary Key: id
8. MortgageProviderListing ( id , mortgageCompaniesid, sellid) Primary Key: id Foreign Keys: - mortgageCompaniesid references MortgageCompanies - sellid references Sell
9. Owner ( id , number_of_listing, Personid) Primary Key: id Foreign Key: Personid references Person
10. Person ( id , first_name, last_name, phone_number, email, dob, Addressid) Primary Key: id Foreign Key: Addressid references Address
11. Rent ( id , ownerid, brokerid, lease_start_date, lease_end_date, listingid) Primary Key: id Foreign Keys: - brokerid references Broker - ownerid references Owner - listingid references Listing
12. Residential ( id , max_occupant, listingid, facilitiesid, sizeOfHouseid, houseTypeid) Primary Key: id Foreign Keys: - listingid references Listing - facilitiesid references Facilities - sizeOfHouseid references SizeOfHouse - houseTypeid references HouseType
13. Sell ( id , buying_price, mortgage_allowed, listingid, ownerid, brokerid) Primary Key: id Foreign Keys: - listingid references Listing - ownerid references Owner
- brokerid references Broker
14. SizeOfHouse ( id , rooms, bathrooms, balconies) Primary Key: id
15. Sublease ( id , rooms_available, rooms_occupied, mixed_gender, parking_available, listingid, ownerid) Primary Key: id Foreign Keys: - listingid references Listing - ownerid references Owner Data Sources


# Data Sources

The data for this project will primarily come from a curated dataset obtained from Kaggle , which is a popular platform for sharing datasets. However, we are planning to get data from various other places, such as web scraping, APIs, or in-house databases, depending on the project's specific requirements. 
Some potential sources are as follows – 
1. Websites like Zillow, Realtor.com, or Trulia often provide apartment listings with detailed information. We are considering scrapping these websites to obtain a large and diverse dataset of apartment listings.
2. Some real estate listing platforms provide APIs that allow us to access data programmatically. Some APIs we are currently considering are the Zillow API and Redfin API, and depending on the cost of use, we may consider using one of the APIs. ●
3. Manually adding data about apartment listings. Data from different platforms can vary in quality and cleanliness. Therefore, several pre-processing steps will be essential to clean and prepare the data for use in the back-end.
Some of them are as follows –
  a. Data Cleaning - Handling missing values, outliers and inconsistent data. It can also include standardizing data formats and handling data errors.
  b. Data Transformation - Normalization of tables, scaling and ensuring all attributes are on a suitable scale.
  c. Feature Engineering - Implement stored procedures/views to generate derived attributes from raw data.


# Libraries and Tools 

1. MySQL Database: Utilized for the storage and retrieval of data.
2. Visual Paradigm: Employed in the design of Entity-Relationship Diagrams (ERDs).
3. MySQL Connector Library: Facilitates the connection between Python and MySQL.
4. Numpy and Pandas Libraries: Applied for data examination and analysis.
5. Matplotlib Library: Utilized to generate visual representations of data
