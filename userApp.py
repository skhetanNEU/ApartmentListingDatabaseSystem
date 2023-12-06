# -*- coding: utf-8 -*-
"""
Created on Tue Dec  5 17:46:21 2023

@author: goswamyrishi
"""

import mysql.connector

conn = None
try: 
    conn = mysql.connector.connect(
        host='localhost',
        user='root',
        password='',
        database='apartments_db'
    )
         
    if conn.is_connected():
        print("Connected to the database")


    '''
    *********************************
    *********************************
                SELECT
    *********************************
    *********************************
    '''
    
    # Fetching data from the broker_rent_view
    query = 'SELECT * FROM broker_rent_view;'    
    with conn.cursor() as cursor:
        cursor.execute(query)
        result = cursor.fetchall()
        for row in result:
            print(row)
    
    
    print("Detailed layout of owner with the properties sold")       
    query = '''
            SELECT se.buying_price, se.mortgage_allowed, pr.first_name, pr.last_name, pr.email, pr.phone_number,  
            ad.building, ad.street, ad.city, ad.state, ad.country, ad.zipcode  FROM
            sell AS se
            INNER JOIN owner AS ow
            ON se.ownerid = ow.id
            INNER JOIN person AS pr
            ON ow.personid = pr.id
            INNER JOIN listing AS li
            ON se.listingid = li.id
            INNER JOIN address AS ad
            ON ad.id = li.addressid;
     
            '''
    with conn.cursor() as cursor:
        cursor.execute(query)
        result = cursor.fetchall()
        for row in result:
            print(row)
            
    # Taking the month interval as user input
    month_interval = input("Enter the number of months for the lease end date interval: ")

    # SQL Select Query
    select_query = """
                    SELECT *
                    FROM broker_rent_view
                    WHERE lease_end_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL %s MONTH);
                   """
    with conn.cursor() as cursor:
        cursor.execute(select_query, (month_interval,))
        result = cursor.fetchall()
        for row in result:
            print(row)
 
    
    '''
    *********************************
    *********************************
            CALL PROCEDURE
    *********************************
    *********************************
    '''
    
    procedure_name = 'AddMortgageCompany'
    # Taking the mortgage company name as user input
    company_name = input("Enter the name of the mortgage company: ")
    procedure_args = (company_name,)
    # Calling the stored procedure
    with conn.cursor() as cursor:
        cursor.callproc(procedure_name, procedure_args)
        conn.commit()
    
    
    # Fetching data to verify the insertion for the input name
    select_query = "SELECT * FROM mortgageCompanies WHERE name = %s"
    with conn.cursor() as cursor:
        cursor.execute(select_query, (company_name,))

        results = cursor.fetchall()
        for row in results:
            print(row)
    
    '''
    *********************************
    *********************************
            CALL FUNCTION
    *********************************
    *********************************
    '''
    
    # Taking the state as user input
    state_input = input("Enter the state: ")
    
    # SQL Query to call the function
    query = "SELECT TotalListingsInCity(%s)"
    with conn.cursor() as cursor:
        cursor.execute(query, (state_input,))
        result = cursor.fetchone()
        if result:
            print(f"Total listings in {state_input}: {result[0]}")
        else:
            print("No data found.")
    
    # SQL Query to call the function
    query = "SELECT AverageBrokerRating()"
    with conn.cursor() as cursor:
        cursor.execute(query)
        result = cursor.fetchone()
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
    
    print("Provide values to add an address")
    # Inserting data into the Address table
    building = input("Enter building: ")
    street = input("Enter street: ")
    city = input("Enter city: ")
    state = input("Enter state: ")
    country = input("Enter country: ")
    zipcode = input("Enter zipcode: ")[:5]  # Trimming zipcode to 5 characters

    sql = "INSERT INTO Address (building, street, city, state, country, zipcode) VALUES (%s, %s, %s, %s, %s, %s)"
    with conn.cursor() as cursor:
        cursor.execute(sql, (building, street, city, state, country, zipcode))
        conn.commit()
        print("Address added successfully.")
        
    '''
    *********************************
    *********************************
                DELETE
    *********************************
    *********************************
    '''
      
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

    with conn.cursor() as cursor:
        cursor.execute(delete_query, values_to_delete)
        conn.commit()
        if cursor.rowcount > 0:
            print("Address deleted successfully.")
        else:
            print("No address found with name.")
    
    '''
    *********************************
    *********************************
                UPDATE
    *********************************
    *********************************
    '''
    
    
    # SQL Update Query
    update_query = """
                    UPDATE sell
                    SET buying_price = %s
                    WHERE listingid = %s;
                    """
    
    # Taking new buying price as user input
    new_price = input("Enter new buying price: ")

    # Taking listingid for the row to be updated
    listing_id = input("Enter listing ID to update: ")
    
    values_for_update = (new_price, listing_id)
    with conn.cursor() as cursor:
        cursor.execute(update_query, values_for_update)
        conn.commit()
        if cursor.rowcount > 0:
            print("Property price updated successfully.")
        else:
            print("No property found with the id.")
    
    query = 'SELECT * FROM sell;'    
    with conn.cursor() as cursor:
        cursor.execute(query)
        result = cursor.fetchall()
        for row in result:
            print(row)
   

except mysql.connector.Error as err:
    print(f"Failed to connect: {err}")

finally:
    if conn and conn.is_connected():
        conn.close()
        print("Connection closed.")
