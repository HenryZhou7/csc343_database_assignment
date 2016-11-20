SET search_path TO bnb, public;

/*Find every invalid listing*/
create view Invalid as
	select t1.listingID, t1.startdate, t1.numNights
	from Booking as t1 inner join Booking as t2
	on t1.listingID = t2.listingID
	where t1.startdate > t2.startdate and t1.startdate < (t2.startdate + t2.numNights);


/*Valid listings*/
create view Valid as
	select *
	from 
	(
		select listingID, startdate, numNights
		from Booking
	) as foo
	except (select * from Invalid);

/*Update the valid view with the property type and city*/
create view ValidUP as
	select Valid.listingID, Valid.startdate, Valid.numNights, Listing.propertytype, Listing.city, Listing.owner
	from Valid inner join Listing on Valid.listingID = Listing.listingID;

/*Update the valid with regulation*/
create view ValidReg as
	select ValidUP.listingID, ValidUP.startdate, ValidUP.numNights, ValidUP.owner, ValidUP.city, CityRegulation.regulationType, CityRegulation.days
	from ValidUP inner join CityRegulation 
	on ValidUP.city = CityRegulation.city and (ValidUP.propertytype = CityRegulation.propertytype or CityRegulation.propertytype is null);

/*Violate the minimum regulation*/
create view VioMin as
	select distinct ValidReg.owner, ValidReg.listingID, extract(year from ValidReg.startdate) as year, ValidReg.city
	from ValidReg
	where regulationType = 'min' and numNights < days;

/*Four tables to count total days per year*/
create view WithinAYear as
	select ValidReg.owner, ValidReg.listingID, extract(year from ValidReg.startdate) as year, ValidReg.city, ValidReg.numNights as stay, 
		ValidReg.days
	from ValidReg
	where extract(year from (ValidReg.startdate + numNights)) = extract(year from ValidReg.startdate) and ValidReg.regulationType = 'max';

create view StartBefore as
	select ValidReg.owner, ValidReg.listingID, extract(year from ValidReg.startdate) as year, ValidReg.city, 
		(to_date(extract(year from ValidReg.startdate)::text || text '-12-31', 'YYYY-MM-DD') - ValidReg.startdate) as stay, 
		ValidReg.days
	from ValidReg
	where extract(year from (ValidReg.startdate + numNights)) = (extract(year from ValidReg.startdate) + 1) and ValidReg.regulationType = 'max';

create view EndAfter as
	select ValidReg.owner, ValidReg.listingID, (extract(year from ValidReg.startdate) + 1) as year, ValidReg.city, 
		(ValidReg.numNights - (to_date(extract(year from ValidReg.startdate)::text || text '-12-31', 'YYYY-MM-DD') - ValidReg.startdate)) as stay, 
		ValidReg.days
	from ValidReg
	where extract(year from (ValidReg.startdate + numNights)) = (extract(year from ValidReg.startdate) + 1) and ValidReg.regulationType = 'max';

create view Total as
	select owner, listingID, year, city, sum(stay) as period, days
	from ((select * from WithinAYear) union (select * from StartBefore) union (select * from EndAfter)) as foo
	group by owner, listingID, year, city, days;

/*Violate the maximum regulation*/
create view VioMax as
	select distinct owner, listingID, year, city
	from Total
	where period > days;

/*Result*/
select owner as homeowner, listingID, year::integer, city::text
from ((select * from VioMax) union (select * from VioMin)) as foo
order by homeowner ASC, listingID ASC, year ASC;
