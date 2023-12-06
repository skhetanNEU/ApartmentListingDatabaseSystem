# -*- coding: utf-8 -*-
"""
Created on Tue Dec  5 20:27:27 2023

@author: goswa
"""

import mysql.connector
from mysql.connector import Error
import json

class DatabaseManager:
    def __init__(self, config_file, profile='local'):
        """
        Initialize the DatabaseManager with database connection parameters from a JSON config file.
        :param config_file: Path to the JSON configuration file.
        :param profile: Profile name ('local' or 'dev') to use from the configuration file.
        """
        self.config_file = config_file
        self.profile = profile
        self.conn = None
        self.load_config()

    def load_config(self):
        """
        Load database configuration from the config file for the specified profile.
        """
        with open(self.config_file, 'r') as file:
            config = json.load(file)
            profile_config = config[self.profile]
            self.host = profile_config['host']
            self.user = profile_config['user']
            self.password = profile_config['password']
            self.database = profile_config['database']

    def connect(self):
        """
        Establish a connection to the database using loaded configuration.
        """
        try:
            self.conn = mysql.connector.connect(
                host=self.host,
                user=self.user,
                password=self.password,
                database=self.database
            )
            if self.conn.is_connected():
                print("Connected to the database")
        except Error as e:
            print(f"Error: {e}")
            self.conn = None


    def close(self):
        """
        Close the database connection.
        """
        if self.conn is not None and self.conn.is_connected():
            self.conn.close()
            print("Database connection closed")           

    def fetch_data(self, query, params=None):
        """
        Fetch and return data from the database using the provided query.
        :param query: SQL query to execute
        :param params: Optional parameters for the query
        """
        if self.conn is not None and self.conn.is_connected():
            with self.conn.cursor() as cursor:
                cursor.execute(query, params)
                return cursor.fetchall()
        else:
            print("Not connected to the database")
            return None

        
    def cleanSpace(self):
        for i in range(0,5):
            print("**********************")

    '''
    *********************************
    *********************************
                SELECT
    *********************************
    *********************************
    '''

    def fetch_broker_rent_view(self):
        """
        Fetch and print data from the broker_rent_view.
        """
        query = 'SELECT * FROM broker_rent_view;'
        results = self.fetch_data(query)
        if results:
            for row in results:
                print(row)



    def fetch_owner_property_details(self):
        """
        Fetch and print the detailed layout of owners with the properties sold.
        """
        query = '''
        SELECT se.buying_price, se.mortgage_allowed, pr.first_name, pr.last_name, pr.email, pr.phone_number,  
        ad.building, ad.street, ad.city, ad.state, ad.country, ad.zipcode
        FROM sell AS se
        INNER JOIN owner AS ow ON se.ownerid = ow.id
        INNER JOIN person AS pr ON ow.personid = pr.id
        INNER JOIN listing AS li ON se.listingid = li.id
        INNER JOIN address AS ad ON ad.id = li.addressid;
        '''
        results = self.fetch_data(query)
        if results:
            for row in results:
                print(row)
                

    def fetch_lease_end_data(self):
        """
        Fetch and print data from the broker_rent_view based on lease end date interval specified by user input.
        """
        month_interval = input("Enter the number of months for the lease end date interval: ")

        select_query = """
                       SELECT *
                       FROM broker_rent_view
                       WHERE lease_end_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL %s MONTH);
                       """
        results = self.fetch_data(select_query, (month_interval,))
        if results:
            for row in results:
                print(row)
 
    '''
    *********************************
    *********************************
            CALL PROCEDURE
    *********************************
    *********************************
    '''                

    def call_procedure(self, proc_name, proc_args):
        """
        Call a stored procedure with the given name and arguments.
        :param proc_name: Name of the stored procedure
        :param proc_args: Arguments for the stored procedure
        """
        if self.conn is not None and self.conn.is_connected():
            with self.conn.cursor() as cursor:
                cursor.callproc(proc_name, proc_args)
                self.conn.commit()
        else:
            print("Not connected to the database")

    def fetch_specific_data(self, query, params):
        """
        Fetch and print data from the database using a provided query and parameters.
        :param query: SQL query to execute
        :param params: Parameters for the query
        """
        results = self.fetch_data(query, params)
        if results:
            for row in results:
                print(row)

    '''
    *********************************
    *********************************
            CALL FUNCTION
    *********************************
    *********************************
    '''
                

    def call_total_listings_in_city(self):
        """
        Call the TotalListingsInCity function with a user-provided state and print the result.
        """
        state_input = input("Enter the state: ")
        query = "SELECT TotalListingsInCity(%s)"
        result = self.fetch_data(query, (state_input,))
        if result:
            print(f"Total listings in {state_input}: {result[0]}")
        else:
            print("No data found.")

    def call_average_broker_rating(self):
        """
        Call the AverageBrokerRating function and print the result.
        """
        query = "SELECT AverageBrokerRating()"
        result = self.fetch_data(query)
        if result:
            print(f"Average broker rating: {result[0]}")
        else:
            print("No data found.")

    '''
    *********************************
    *********************************
                INSERT
    *********************************
    *********************************
    '''

    def insert_address(self):
        """
        Insert a new address into the Address table based on user input.
        """
        print("Provide values to add an address")
        building = input("Enter building: ")
        street = input("Enter street: ")
        city = input("Enter city: ")
        state = input("Enter state: ")
        country = input("Enter country: ")
        zipcode = input("Enter zipcode: ")[:5]  # Trimming zipcode to 5 characters

        sql = "INSERT INTO Address (building, street, city, state, country, zipcode) VALUES (%s, %s, %s, %s, %s, %s)"
        if self.conn is not None and self.conn.is_connected():
            with self.conn.cursor() as cursor:
                cursor.execute(sql, (building, street, city, state, country, zipcode))
                self.conn.commit()
                print("Address added successfully.")
        else:
            print("Not connected to the database")

    '''
    *********************************
    *********************************
                DELETE
    *********************************
    *********************************
    '''

    def delete_address(self):
        """
        Delete an address from the Address table based on user input.
        """
        print("Provide values to delete an address")
        delete_query = """
                        DELETE FROM Address 
                        WHERE building = %s AND street = %s AND city = %s AND state = %s AND country = %s AND zipcode = %s
                    """

        # Taking values as user input
        building_value = input("Enter building name: ")
        street_value = input("Enter street: ")
        city_value = input("Enter city: ")
        state_value = input("Enter state: ")
        country_value = input("Enter country: ")
        zipcode_value = input("Enter zipcode: ")

        values_to_delete = (building_value, street_value, city_value, state_value, country_value, zipcode_value)

        if self.conn is not None and self.conn.is_connected():
            with self.conn.cursor() as cursor:
                cursor.execute(delete_query, values_to_delete)
                self.conn.commit()
                if cursor.rowcount > 0:
                    print("Address deleted successfully.")
                else:
                    print("No address found with those details.")
        else:
            print("Not connected to the database")

    '''
    *********************************
    *********************************
                UPDATE
    *********************************
    *********************************
    '''

    def update_sell_price(self):
        """
        Update the buying price for a property in the sell table based on user input.
        """
        # SQL Update Query
        update_query = """
                        UPDATE sell
                        SET buying_price = %s
                        WHERE listingid = %s;
                        """

        # Taking new buying price and listingid as user input
        new_price = input("Enter new buying price: ")
        listing_id = input("Enter listing ID to update: ")

        values_for_update = (new_price, listing_id)
        if self.conn is not None and self.conn.is_connected():
            with self.conn.cursor() as cursor:
                cursor.execute(update_query, values_for_update)
                self.conn.commit()
                if cursor.rowcount > 0:
                    print("Property price updated successfully.")
                else:
                    print("No property found with the id.")

        # Optionally fetching and displaying updated data from sell table
        self.display_all_records("sell")

    def display_all_records(self, table_name):
        """
        Display all records from a specified table.
        :param table_name: Name of the table to fetch records from
        """
        query = f'SELECT * FROM {table_name};'
        results = self.fetch_data(query)
        if results:
            for row in results:
                print(row)


def main():
    # Initialize DatabaseManager with the configuration file and profile
    db_manager = DatabaseManager('settings.json', 'local')
    db_manager.connect()

    db_manager.fetch_broker_rent_view()
    db_manager.cleanSpace()

    db_manager.fetch_owner_property_details()
    db_manager.cleanSpace()

    db_manager.fetch_lease_end_data()
    db_manager.cleanSpace()

    # Call the AddMortgageCompany stored procedure
    procedure_name = 'AddMortgageCompany'
    company_name = input("Enter the name of the mortgage company: ")
    db_manager.call_procedure(procedure_name, (company_name,))
    db_manager.cleanSpace()

    # Fetch and print data to verify the insertion
    select_query = "SELECT * FROM mortgageCompanies WHERE name = %s"
    db_manager.fetch_specific_data(select_query, (company_name,))
    db_manager.cleanSpace()

    # Call and print the total listings in a specified city
    db_manager.call_total_listings_in_city()
    db_manager.cleanSpace()

    # Call and print the average broker rating
    db_manager.call_average_broker_rating()
    db_manager.cleanSpace()

    # Insert an address
    db_manager.insert_address()
    db_manager.cleanSpace()

    # Delete an address
    db_manager.delete_address()
    db_manager.cleanSpace()

    # Update property price and display updated data
    db_manager.update_sell_price()

    # Close the database connection
    db_manager.close()

if __name__ == "__main__":
    main()
