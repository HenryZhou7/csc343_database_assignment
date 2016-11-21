SET search_path TO bnb, public;

CREATE VIEW book_log AS
    SELECT DISTINCT travelerId, listingId
    FROM Booking;

CREATE VIEW request_log AS
    SELECT DISTINCT travelerId, listingId
    FROM BookingRequest;

/*non-committed travelers are essentially those who has requested but not booked*/
CREATE VIEW non_committed AS
    (
        SELECT travelerid
        FROM request_log
    )
        EXCEPT
    (
        SELECT travelerid
        FROM book_log
    );





