-- views

-- Details of rented property that are brokered by brokers 
CREATE VIEW broker_rent_view AS
SELECT re.lease_start_date, re.lease_end_date, 
br.broker_permit, br.rating, br.agency_name, 
pe.first_name, pe.last_name, pe.email, pe.phone_number, 
ad.building, ad.street, ad.city, ad.state, ad.country, ad.zipcode 
FROM rent AS re
INNER JOIN broker AS br
ON re.brokerid = br.id
INNER JOIN person AS pe
ON pe.id = br.personid
INNER JOIN listing AS li
ON re.listingid = li.id
INNER JOIN address AS ad
ON ad.id = li.addressid;
 
 /*
SELECT * FROM broker_rent_view;

-- Properties with lease termination within next 6 months.
SELECT *
FROM broker_rent_view
WHERE lease_end_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 6 MONTH);
*/

-- Details of property sold along with address.
CREATE VIEW broker_sell_view AS
SELECT se.buying_price, se.mortgage_allowed, pr.first_name, pr.last_name, pr.email, pr.phone_number, br.broker_permit, br.rating,
br.agency_name, ad.building, ad.street, ad.city, ad.state, ad.country, ad.zipcode  FROM
sell AS se
INNER JOIN broker AS br
ON se.brokerid = br.id
INNER JOIN person AS pr
ON br.personid = pr.id
INNER JOIN listing AS li
ON se.listingid = li.id
INNER JOIN address AS ad
ON ad.id = li.addressid;

/*
SELECT * FROM broker_sell_view;

SELECT * FROM broker_sell_view where buying_price > 400000;
*/