TRUNCATE TABLE Traveler CASCADE;
TRUNCATE TABLE Homeowner CASCADE;
TRUNCATE TABLE Listing CASCADE;
TRUNCATE TABLE BookingRequest CASCADE;
TRUNCATE TABLE Booking CASCADE;
TRUNCATE TABLE HomeownerRating CASCADE;
TRUNCATE TABLE CityRegulation CASCADE;
TRUNCATE TABLE TravelerRating CASCADE;

INSERT INTO Traveler VALUES (1000, 'n1', 'f1', 'fn1@domain.com');
INSERT INTO Traveler VALUES (1001, 'n2', 'f2', 'fn2@domain.com');
INSERT INTO Traveler VALUES (1002, 'n3', 'f3', 'fn3@domain.com');
INSERT INTO Traveler VALUES (1003, 'n4', 'f4', 'fn4@domain.com');
INSERT INTO Traveler VALUES (1004, 'n5', 'f5', 'fn5@domain.com');
INSERT INTO Traveler VALUES (1005, 'n6', 'f6', 'fn6@domain.com');
INSERT INTO Traveler VALUES (1006, 'n7', 'f7', 'fn7@domain.com');
INSERT INTO Traveler VALUES (1007, 'n8', 'f8', 'fn8@domain.com');
INSERT INTO Traveler VALUES (1008, 'n9', 'f9', 'fn9@domain.com');
INSERT INTO Traveler VALUES (1009, 'n10', 'f10', 'fn10@domain.com');
INSERT INTO Traveler VALUES (1010, 'n11', 'f11', 'fn11@domain.com');

INSERT INTO Homeowner VALUES (4000, 'hn1', 'hf1', 'hfn1@domain.com');
INSERT INTO Homeowner VALUES (4001, 'hn2', 'hf2', 'hfn2@domain.com');
INSERT INTO Homeowner VALUES (4002, 'hn3', 'hf3', 'hfn3@domain.com');
INSERT INTO Homeowner VALUES (4003, 'hn4', 'hf4', 'hfn4@domain.com');
INSERT INTO Homeowner VALUES (4004, 'hn5', 'hf5', 'hfn5@domain.com');
INSERT INTO Homeowner VALUES (4005, 'hn5', 'hf5', 'hfn5@domain.com');




INSERT INTO Listing VALUES (3000, 'condo', 2, 4, 'gym', 'c1', 4000);
INSERT INTO Listing VALUES (3001, 'house', 2, 4, 'gym', 'c2', 4001);
INSERT INTO Listing VALUES (3002, 'house', 2, 4, 'gym', 'c2', 4002);
INSERT INTO Listing VALUES (3003, 'house', 2, 4, 'gym', 'c2', 4003);
INSERT INTO Listing VALUES (3004, 'house', 2, 4, 'gym', 'c2', 4004);
INSERT INTO Listing VALUES (3005, 'house', 2, 4, 'gym', 'c2', 4005);


INSERT INTO BookingRequest VALUES (6000, 1000, 3000, '2016-10-05', 2, 1, 100);
INSERT INTO BookingRequest VALUES (6001, 1001, 3001, '2015-01-05', 4, 1, 120);
INSERT INTO BookingRequest VALUES (6002, 1002, 3002, '2016-01-03', 10, 1, 75);
INSERT INTO BookingRequest VALUES (6003, 1003, 3004, '2016-01-04', 10, 1, 75);
INSERT INTO BookingRequest VALUES (6004, 1000, 3001, '2016-01-10', 10, 1, 75);
INSERT INTO BookingRequest VALUES (6005, 1001, 3001, '2016-01-06', 10, 1, 75);
INSERT INTO BookingRequest VALUES (6006, 1006, 3001, '2016-01-07', 10, 1, 75);
INSERT INTO BookingRequest VALUES (6007, 1007, 3001, '2016-01-08', 10, 1, 75);
INSERT INTO BookingRequest VALUES (6008, 1001, 3002, '2016-01-16', 10, 1, 75);
INSERT INTO BookingRequest VALUES (6009, 1001, 3003, '2016-01-17', 10, 1, 75);
INSERT INTO BookingRequest VALUES (6010, 1001, 3004, '2016-01-18', 10, 1, 75);
INSERT INTO BookingRequest VALUES (6011, 1001, 3005, '2016-01-19', 10, 1, 75);


INSERT INTO Booking VALUES (3000, '2016-10-05', 1000, 2, 1, 90);
INSERT INTO Booking VALUES (3001, '2015-01-05', 1001, 5, 1, 20);
INSERT INTO Booking VALUES (3002, '2016-01-03', 1002, 5, 1, 1000);
INSERT INTO Booking VALUES (3004, '2016-01-04', 1003, 5, 1, 1000);
INSERT INTO Booking VALUES (3001, '2016-01-10', 1000, 5, 1, 1000);
INSERT INTO Booking VALUES (3004, '2016-01-18', 1001, 5, 1, 20);
INSERT INTO Booking VALUES (3002, '2016-01-16', 1001, 5, 1, 20);
INSERT INTO Booking VALUES (3001, '2016-01-08', 1007, 5, 1, 1000);


INSERT INTO TravelerRating VALUES (3000, '2016-10-05', 5, 'cmt1');
INSERT INTO TravelerRating VALUES (3001, '2015-01-05', 4, 'cmt2');
INSERT INTO TravelerRating VALUES (3002, '2016-01-03', 3, 'cmt2');
INSERT INTO TravelerRating VALUES (3004, '2016-01-04', 3, 'cmt2');
INSERT INTO TravelerRating VALUES (3001, '2016-01-10', 3, 'cmt2');
INSERT INTO TravelerRating VALUES (3004, '2016-01-18', 5, 'cmt2');
INSERT INTO TravelerRating VALUES (3002, '2016-01-16', 3, 'cmt2');
INSERT INTO TravelerRating VALUES (3001, '2016-01-08', 3, 'cmt2');

INSERT INTO CityRegulation VALUES ('c1', 'condo', 'min', 30);
INSERT INTO CityRegulation VALUES ('c2', 'house', 'max', 90);

INSERT INTO HomeownerRating VALUES (3000, '2016-10-05', 3, 'cmt3');
INSERT INTO HomeownerRating VALUES (3001, '2015-01-05', 4, 'cmt2');






