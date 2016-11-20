SET search_path TO bnb, public;

/*question 6 committed travelers*/

/*
* heuristic: subtract booked traveler-booked from traveler-requested to find non-committed
* subtract non-committed and those who has never booked from all travelers
* generate required information
*/

/*find non-committed travelers*/
CREATE VIEW book_log AS
    SELECT DISTINCT travelerId, listingId
    FROM Booking;

CREATE VIEW request_log AS
    SELECT DISTINCT travelerId, listingId
    FROM BookingRequest;

/*non-committed travelers are essentially those who has requested but not booked*/
CREATE VIEW non_committed AS
    (
        SELECT *
        FROM request_log
    )
        EXCEPT
    (
        SELECT *
        FROM book_log
    );

CREATE VIEW all_travelers AS
    SELECT travelerId
    FROM Traveler;

CREATE VIEW never_request_traveler AS
    SELECT travelerId
    FROM
    ((
        SELECT travelerId
        FROM all_travelers
    )
        EXCEPT
    (
        SELECT travelerId
        FROM BookingRequest
    )) AS foo;

/*subtract non_committed and never_request traveler from all travelers to get the id of committed*/
CREATE VIEW committed_id AS
    (
        SELECT travelerId
        FROM Booking 
    )
        EXCEPT
    (
        SELECT travelerId
        FROM never_request_traveler
    )
        EXCEPT
    (
        SELECT travelerId
        FROM non_committed
    );

/*based on the assumptions that the we have found all the committed travelers. generate needed info*/
CREATE VIEW committed_surname AS
    SELECT committed_id.travelerId AS travelerId, Traveler.surname AS surname
    FROM committed_id, Traveler
    WHERE committed_id.travelerId = Traveler.travelerId;

CREATE VIEW committed_info AS
    SELECT Booking.travelerId, committed_surname.surname::text, 
        count(DISTINCT listingId)::bigint AS numListings
    FROM committed_surname INNER JOIN Booking
    ON committed_surname.travelerId = Booking.travelerId 
    GROUP BY Booking.travelerId, committed_surname.surname;

/*print the table*/
SELECT *
FROM committed_info
ORDER BY
    travelerId ASC;
