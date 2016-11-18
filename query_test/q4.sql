SET search_path TO bnb, public;

/*create homeowner last_n_year rating table. a total of 10 tables*/

/*associate each owner with its corresponding rating*/
CREATE VIEW owner_rating AS 
    SELECT Listing.owner AS homeownerId,
        TravelerRating.listingID AS listingId,
        TravelerRating.startDate AS startdate,
        TravelerRating.rating AS rating
    FROM Listing, TravelerRating
    WHERE Listing.listingId = TravelerRating.listingID;

/*all of the homeowner list*/
CREATE VIEW all_owners AS
    SELECT homeownerId
    FROM homeowner;

/*a table of homeowner with all the corresponding ratings*/
CREATE VIEW all_owners_rating AS
    SELECT 
        all_owners.homeownerId AS homeownerId,
        owner_rating.listingId AS listingId,
        owner_rating.startdate AS startdate,
        owner_rating.rating AS rating
    FROM all_owners LEFT JOIN owner_rating
    ON all_owners.homeownerId = owner_rating.homeownerId;

/*10 separate tables for past n year rating*/
CREATE VIEW last_0_rating AS
    SELECT homeownerId, 
        avg(rating) AS avg_rating
    FROM all_owners_rating
    WHERE date_part('year', startdate) <= date_part('year', current_date) - 0
        AND date_part('year', startdate) > date_part('year', current_date) - 1
    GROUP BY homeownerId;

CREATE VIEW last_1_rating AS
    SELECT homeownerId, 
        avg(rating) AS avg_rating
    FROM all_owners_rating
    WHERE date_part('year', startdate) <= date_part('year', current_date) - 1
        AND date_part('year', startdate) > date_part('year', current_date) - 2
    GROUP BY homeownerId;

CREATE VIEW last_2_rating AS
    SELECT homeownerId, 
        avg(rating) AS avg_rating
    FROM all_owners_rating
    WHERE date_part('year', startdate) <= date_part('year', current_date) - 2
        AND date_part('year', startdate) > date_part('year', current_date) - 3
    GROUP BY homeownerId;

CREATE VIEW last_3_rating AS
    SELECT homeownerId, 
        avg(rating) AS avg_rating
    FROM all_owners_rating
    WHERE date_part('year', startdate) <= date_part('year', current_date) - 3
        AND date_part('year', startdate) > date_part('year', current_date) - 4
    GROUP BY homeownerId;

CREATE VIEW last_4_rating AS
    SELECT homeownerId, 
        avg(rating) AS avg_rating
    FROM all_owners_rating
    WHERE date_part('year', startdate) <= date_part('year', current_date) - 4
        AND date_part('year', startdate) > date_part('year', current_date) - 5
    GROUP BY homeownerId;

CREATE VIEW last_5_rating AS
    SELECT homeownerId, 
        avg(rating) AS avg_rating
    FROM all_owners_rating
    WHERE date_part('year', startdate) <= date_part('year', current_date) - 5
        AND date_part('year', startdate) > date_part('year', current_date) - 6
    GROUP BY homeownerId;

CREATE VIEW last_6_rating AS
    SELECT homeownerId, 
        avg(rating) AS avg_rating
    FROM all_owners_rating
    WHERE date_part('year', startdate) <= date_part('year', current_date) - 6
        AND date_part('year', startdate) > date_part('year', current_date) - 7
    GROUP BY homeownerId;

CREATE VIEW last_7_rating AS
    SELECT homeownerId, 
        avg(rating) AS avg_rating
    FROM all_owners_rating
    WHERE date_part('year', startdate) <= date_part('year', current_date) - 7
        AND date_part('year', startdate) > date_part('year', current_date) - 8
    GROUP BY homeownerId;

CREATE VIEW last_8_rating AS
    SELECT homeownerId, 
        avg(rating) AS avg_rating
    FROM all_owners_rating
    WHERE date_part('year', startdate) <= date_part('year', current_date) - 8
        AND date_part('year', startdate) > date_part('year', current_date) - 9
    GROUP BY homeownerId;

CREATE VIEW last_9_rating AS
    SELECT homeownerId, 
        avg(rating) AS avg_rating
    FROM all_owners_rating
    WHERE date_part('year', startdate) <= date_part('year', current_date) - 9
        AND date_part('year', startdate) > date_part('year', current_date) - 10
    GROUP BY homeownerId;

CREATE VIEW last_10_rating AS
    SELECT homeownerId, 
        avg(rating) AS avg_rating
    FROM all_owners_rating
    WHERE date_part('year', startdate) <= date_part('year', current_date) - 10
        AND date_part('year', startdate) > date_part('year', current_date) - 11
    GROUP BY homeownerId;

/*start from the beginning last_10_rating compare all the way to the end*/
/*make a very big table and select those satisfied tuples*/
CREATE VIEW satisfy_condition AS
    SELECT *
    FROM
    ((
        SELECT homeownerId
	FROM all_owners
    )
	EXCEPT
    (
        SELECT last_10_rating.homeownerId
        FROM last_10_rating JOIN last_9_rating
	ON last_10_rating.homeownerId = last_9_rating.homeownerId
        WHERE last_10_rating.avg_rating > last_9_rating.avg_rating
    )
        EXCEPT
    (
        SELECT last_9_rating.homeownerId
        FROM last_9_rating JOIN last_8_rating
	ON last_9_rating.homeownerId = last_8_rating.homeownerId
        WHERE last_9_rating.avg_rating > last_8_rating.avg_rating
    )
        EXCEPT
    (
        SELECT last_8_rating.homeownerId
        FROM last_8_rating JOIN last_7_rating
	ON last_8_rating.homeownerId = last_7_rating.homeownerId
        WHERE last_8_rating.avg_rating > last_7_rating.avg_rating
    )
        EXCEPT
    (
        SELECT last_7_rating.homeownerId
        FROM last_7_rating JOIN last_6_rating
	ON last_7_rating.homeownerId = last_6_rating.homeownerId
        WHERE last_7_rating.avg_rating > last_6_rating.avg_rating
    )
        EXCEPT
    (
        SELECT last_6_rating.homeownerId
        FROM last_6_rating JOIN last_5_rating
	ON last_6_rating.homeownerId = last_5_rating.homeownerId
        WHERE last_6_rating.avg_rating > last_5_rating.avg_rating
    )
        EXCEPT
    (
        SELECT last_5_rating.homeownerId
        FROM last_5_rating JOIN last_4_rating
	ON last_5_rating.homeownerId = last_4_rating.homeownerId
        WHERE last_5_rating.avg_rating > last_4_rating.avg_rating
    )
        EXCEPT
    (
        SELECT last_4_rating.homeownerId
        FROM last_4_rating JOIN last_3_rating
	ON last_4_rating.homeownerId = last_3_rating.homeownerId
        WHERE last_4_rating.avg_rating > last_3_rating.avg_rating
    )
        EXCEPT
    (
        SELECT last_3_rating.homeownerId
        FROM last_3_rating JOIN last_2_rating
	ON last_3_rating.homeownerId = last_2_rating.homeownerId
        WHERE last_3_rating.avg_rating > last_2_rating.avg_rating
    )
        EXCEPT
    (
        SELECT last_2_rating.homeownerId
        FROM last_2_rating JOIN last_1_rating
	ON last_2_rating.homeownerId = last_1_rating.homeownerId
        WHERE last_2_rating.avg_rating > last_1_rating.avg_rating
    )
	EXCEPT
    (
        SELECT last_1_rating.homeownerId
        FROM last_1_rating JOIN last_0_rating
	ON last_1_rating.homeownerId = last_0_rating.homeownerId
        WHERE last_1_rating.avg_rating > last_0_rating.avg_rating
    )) AS foo;

CREATE VIEW qualify_sum AS
    SELECT count(*)::float AS qualify_num
    FROM satisfy_condition;

CREATE VIEW total_sum AS
    SELECT count(*)::float AS total_num
    FROM all_owners;

/*return the result*/
/*always initialize the data before running this query, otherwise there will be division by 0*/
SELECT (qualify_sum.qualify_num / total_sum.total_num * 100)::integer AS percentage
FROM qualify_sum, total_sum;
