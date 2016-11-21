SET search_path TO bnb, public;

/*question 7 bargainers*/

/*find the booking price per night*/
/*will operation division return me with double?*/
CREATE VIEW booking_price AS
    SELECT travelerId, listingID, startdate, price::float / numNights AS book_price
    FROM Booking;

/*find the average price per night per listing*/
CREATE VIEW avg_listing_price AS
    SELECT listingId, avg(book_price) AS avg_price
    FROM booking_price
    GROUP BY listingId;

/*compare booking price with those listing price, select those with 25% off or more*/
CREATE VIEW good_bargain AS
    SELECT booking_price.travelerId, booking_price.listingId, booking_price.startdate,
        1 - booking_price.book_price::float / avg_listing_price.avg_price AS discount
    FROM booking_price LEFT JOIN avg_listing_price
    ON booking_price.listingId = avg_listing_price.listingId
    WHERE booking_price.book_price <= 0.75 * avg_listing_price.avg_price;

/*find good bargainers' biggest discount*/
CREATE VIEW biggest_discount AS
    SELECT travelerId, max(discount) AS biggest_bargain
    FROM good_bargain
    GROUP BY travelerId;

/*what if the most bargain corresponds to two different listings*/
/*find most bargain*/
CREATE VIEW biggest_listing AS
    SELECT good_bargain.travelerId, good_bargain.listingId
    FROM good_bargain JOIN biggest_discount
    ON good_bargain.travelerId = biggest_discount.travelerId
    WHERE good_bargain.discount = biggest_discount.biggest_bargain;

/*combine the two tables*/
CREATE VIEW possible_result AS
    SELECT biggest_discount.travelerId AS travelerID,
        (biggest_discount.biggest_bargain * 100)::integer AS largestBargainPercentage,
        biggest_listing.listingId AS listingID
    FROM biggest_discount JOIN biggest_listing
    ON biggest_discount.travelerId = biggest_listing.travelerId;

/*filter out those unqualified*/
CREATE VIEW qualify AS
    SELECT travelerId
    FROM good_bargain
    GROUP BY travelerId
    HAVING count(*) >= 3; 	

/*only select those have appeared in qualify view */
CREATE VIEW result AS
	SELECT possible_result.travelerId AS travelerID,
		largestBargainPercentage,
		listingID
	FROM possible_result
	WHERE travelerId in(SELECT qualify.travelerId FROM qualify);	

/*return the final result*/
SELECT *
FROM result
ORDER BY
    largestBargainPercentage DESC,
    travelerID ASC;
