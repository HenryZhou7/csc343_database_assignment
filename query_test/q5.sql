SET search_path TO bnb, public;

/*question 5 rating histogram*/

/*given each traveler rating, match with the homeowner with listingId*/
CREATE VIEW ho_rating_list AS
    SELECT Listing.owner, TravelerRating.listingId, TravelerRating.startDate,
           TravelerRating.rating
    FROM TravelerRating, Listing
    WHERE TravelerRating.listingId = Listing.listingId;


/*find the number of 5/4/3/2/1 ratings for each homeowner respectively*/
/*then use left join to preserve the identity of each homeowner and fill the rating with NULL*/

/*all homeowners*/
CREATE VIEW all_homeowner AS
    SELECT homeownerId AS homeowner
    FROM Homeowner;

/*create 5-star rating*/
/*homeowner_id and it 5-star rating occurrences*/
/*for each table, need to update the NULL value to 0*/
CREATE VIEW ho_5_rate AS
    SELECT *
    FROM all_homeowner LEFT JOIN (
		SELECT ho_rating_list.owner , count(rating)::integer AS rate_num
		FROM ho_rating_list
		WHERE rating = 5
		GROUP BY ho_rating_list.owner
    ) AS foo
    ON all_homeowner.homeowner = foo.owner;    
/*update value for occurrences*/


/*iterate the process 4 times to create 4 separate tables*/
CREATE VIEW ho_4_rate AS
    SELECT *
    FROM all_homeowner LEFT JOIN (
		SELECT ho_rating_list.owner , count(rating)::bigint AS rate_num
		FROM ho_rating_list
		WHERE rating = 4
		GROUP BY ho_rating_list.owner
    ) AS foo
    ON all_homeowner.homeowner = foo.owner;
/*update value for occurrences*/

/*create table for 3-star rating*/
CREATE VIEW ho_3_rate AS
    SELECT *
    FROM all_homeowner LEFT JOIN (
		SELECT ho_rating_list.owner , count(rating)::bigint AS rate_num
		FROM ho_rating_list
		WHERE rating = 3
		GROUP BY ho_rating_list.owner
    ) AS foo
    ON all_homeowner.homeowner = foo.owner;
/*update value for occurrences*/

/*create table for 2 star rating*/
CREATE VIEW ho_2_rate AS
    SELECT *
    FROM all_homeowner LEFT JOIN (
		SELECT ho_rating_list.owner , count(rating)::bigint AS rate_num
		FROM ho_rating_list
		WHERE rating = 2
		GROUP BY ho_rating_list.owner
    ) AS foo
    ON all_homeowner.homeowner = foo.owner;

/*create table for 1 star rating*/
CREATE VIEW ho_1_rate AS
    SELECT *
    FROM all_homeowner LEFT JOIN (
		SELECT ho_rating_list.owner , count(rating)::bigint AS rate_num
		FROM ho_rating_list
		WHERE rating = 1
		GROUP BY ho_rating_list.owner
    ) AS foo
    ON all_homeowner.homeowner = foo.owner;
/*update value for occurrences*/

/*join the different tables respectively*/
CREATE VIEW table_54 AS
    SELECT ho_5_rate.homeowner AS homeownerID, ho_5_rate.rate_num AS r5, 
           ho_4_rate.rate_num AS r4
    FROM ho_5_rate, ho_4_rate
    WHERE ho_5_rate.homeowner = ho_4_rate.homeowner;
    
CREATE VIEW table_543 AS
    SELECT table_54.homeownerID, table_54.r5, table_54.r4, 
           ho_3_rate.rate_num AS r3
    FROM table_54, ho_3_rate
    WHERE table_54.homeownerID = ho_3_rate.homeowner;

CREATE VIEW table_5432 AS
    SELECT table_543.homeownerID, table_543.r5, table_543.r4, table_543.r3,
           ho_2_rate.rate_num AS r2
    FROM table_543, ho_2_rate
    WHERE table_543.homeownerID = ho_2_rate.homeowner;
    
CREATE VIEW table_54321 AS
    SELECT table_5432.homeownerID, table_5432.r5, table_5432.r4, table_5432.r3, table_5432.r2,
           ho_1_rate.rate_num AS r1
    FROM table_5432, ho_1_rate
    WHERE table_5432.homeownerID = ho_1_rate.homeowner;
    
/*list all the result in the manner the question required*/
SELECT homeownerID, r5::bigint, r4::bigint, r3::bigint, r2::bigint, r1::bigint
FROM table_54321
ORDER BY
    r5 DESC,
    r4 DESC,
    r3 DESC,
    r2 DESC,
    r1 DESC,
    homeownerID ASC;
