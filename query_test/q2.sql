SET search_path TO bnb, public; 

/*first find all the scrapers, according to the definition*/
/*those who has made more than 10 times the average requests and never booked*/ 
/*number of requests for each traveler*/
CREATE VIEW traveler_request_num AS
    SELECT travelerId, count(*) AS num
    FROM BookingRequest
    GROUP BY travelerId;

CREATE VIEW all_traveler_num AS
	SELECT count(*) AS traveler_num
	FROM Traveler;

CREATE VIEW all_request_num AS
	SELECT count(*) AS total_request
	FROM BookingRequest;

CREATE VIEW avg_request AS
	SELECT total_request::float / traveler_num::float AS avg_request_num
	FROM all_request_num, all_traveler_num;

/*where someone hasn't even requested*/
/*find those requests number > 10 * average requests*/
CREATE VIEW suspicious AS
    SELECT travelerId
    FROM traveler_request_num
    WHERE num > 10 * (
        SELECT *
        FROM avg_request
    );
  
/*those traveler who has made a booking*/
CREATE VIEW booking_traveler AS
    SELECT Booking.travelerId AS travelerId
    FROM Booking;
    
/*find the scrapers: subtract those who has made a booking from suspicious*/
CREATE VIEW scraper AS
    (
        SELECT travelerId 
        FROM suspicious
    )
        EXCEPT
    (
        SELECT travelerID
        FROM booking_traveler
    );
    
/*finding the max occurences of requested city per scraper*/
/*find all the requests from each*/
CREATE VIEW scraper_requests AS
    SELECT scraper.travelerId, BookingRequest.listingId
    FROM BookingRequest, scraper
    WHERE BookingRequest.travelerId = scraper.travelerId; 
          
/*according to the request's listingId find the corresponding city*/
CREATE VIEW scraper_city AS
    SELECT scraper_requests.travelerId, scraper_requests.listingId, Listing.city
    FROM scraper_requests, Listing
    WHERE scraper_requests.listingId = Listing.listingId;

/*find the most requested city for each scraper*/
CREATE VIEW scraper_city_num AS
    SELECT travelerId, city, count(listingId) AS city_num 
    FROM scraper_city
    GROUP BY travelerId, city
    ORDER BY city;
	    
/*only preserve those city num greater than or equal to max city_num per traveler*/
CREATE VIEW scraper_max_city AS
    SELECT s1.travelerId, s1.city, s1.city_num
    FROM scraper_city_num AS s1
    WHERE s1.city_num >= all(
        SELECT s2.city_num 
        FROM scraper_city_num AS s2
        WHERE s1.travelerId = s2.travelerId
        ORDER BY city
    );

/*append the number of requests for each scraper*/
CREATE VIEW scraper_city_requests AS
    SELECT scraper_max_city.travelerId, scraper_max_city.city, traveler_request_num.num
    FROM scraper_max_city, traveler_request_num
    WHERE scraper_max_city.travelerId = traveler_request_num.travelerId;

/*append more personal information such as name and email*/
CREATE VIEW scraper_all_info AS
    SELECT Traveler.travelerId, 
    	   Traveler.firstname || ' ' ||  Traveler.surname AS name, 
           Traveler.email, 
           scraper_city_requests.city AS mostRequestedCity, 
           scraper_city_requests.num AS numRequests
    FROM scraper_city_requests, Traveler
    WHERE scraper_city_requests.travelerId = Traveler.travelerId;

/*modify unknown email to 'unknown'*/
/*
UPDATE scraper_all_info
SET email = 'unknown'
WHERE email = NULL;*/

/*sort in the requested fashion*/
SELECT travelerId, name, email::text, 
	   mostRequestedCity::text, 
	   numRequests::integer
FROM scraper_all_info
ORDER BY numRequests DESC,
         travelerId ASC;


/*reference for sorting in different layers: */
/* http://www.postgresqltutorial.com/postgresql-order-by/ */   
