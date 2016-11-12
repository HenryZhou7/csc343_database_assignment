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


/*get the corresponding listing id given the request id*/
CREATE VIEW listing_value AS
    SELECT listingId
    FROM BookingRequest
    WHERE requestId = requestId;


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