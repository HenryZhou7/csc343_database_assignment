/*contain the sql code for the implementation of the java method*/

/*
* param int requestId
* param Date start 
* param int numNights
* param int param
*/

/*first find out if the booking request has been made*/
CREATE VIEW exist_in_booking_request AS
    SELECT *
    FROM BookingRequest
    WHERE BookingRequest = requestId;

/*check the result in java, if it is NULL then return false*/
/*If there exists a booking request already in the table*/
/*get the listingid, startdate, numnights*/

/*need to satisfy two conditions*/
/*all the bookings with the same listingid's enddate should be smaller than current start*/
/*all the bookings with the same listingid's startdate should be larger than current start + numnights*/

CREATE VIEW violation AS
	SELECT * 
	FROM
	((
	SELECT listingID
	FROM Booking
	WHERE listingID = <my_listing_value>
		AND startdate + numnights::integer <= <my_start_date>
	)
		UNION
	(
	SELECT listingId
	FROM Booking
	WHERE listingID = <my_listing_value>
		AND startdate <= <my_start_date> + <my_numnights>
	))AS foo;

/*check to see if there is any violation in the table, if violation is non-empty, then return false*/
/*otherwise insert the new entry into the table booking*/

/*check whether the same entry is already in the booking table*/
CREATE VIEW exist_in_booking AS
    SELECT *
    FROM Booking
    WHERE Booking.listingId = listing_value
        AND Booking.startdate = start
        AND Booking.numNights = numNights
        AND Booking.price = price;

/*if the above sql returns me with a not null value, then the booking info exists*/
/*otherwise move on to inserting the entry in booking table*/

INSERT INTO Booking VALUES ();
