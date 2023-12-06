-- Details of property sold along with address.
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

select * from owner;
select * from rent;