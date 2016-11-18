SET search_path TO bnb, public; 


/*Booking from last ten years*/
create view BookingLastTenYears as
	select *
	from(
	(
		select Booking.travelerID, date_part('year', Booking.startdate) as year, count(*) as numBooking
		from Booking
		where date_part('year', Booking.startdate) = (date_part('year', current_date) - 1)
		group by Booking.travelerID, date_part('year', Booking.startdate)
	)	
	union
	(
		select distinct Booking.travelerID, date_part('year', Booking.startdate) as year, count(*) as numBooking
		from Booking
		where date_part('year',Booking.startdate) = (date_part('year',current_date) - 2)
		group by Booking.travelerID, date_part('year', Booking.startdate)
	)
	union
	(
		select distinct Booking.travelerID, date_part('year', Booking.startdate) as year, count(*) as numBooking
		from Booking
		where date_part('year',Booking.startdate) = (date_part('year',current_date) - 3)
		group by Booking.travelerID, date_part('year', Booking.startdate)
	)
	union
	(
		select distinct Booking.travelerID, date_part('year', Booking.startdate) as year, count(*) as numBooking
		from Booking
		where date_part('year',Booking.startdate) = (date_part('year',current_date) - 4)
		group by Booking.travelerID, date_part('year', Booking.startdate)
	)
	union
	(
		select distinct Booking.travelerID, date_part('year', Booking.startdate) as year, count(*) as numBooking
		from Booking
		where date_part('year',Booking.startdate) = (date_part('year',current_date) - 5)
		group by Booking.travelerID, date_part('year', Booking.startdate)
	)
	union
	(
		select distinct Booking.travelerID, date_part('year', Booking.startdate) as year, count(*) as numBooking
		from Booking
		where date_part('year',Booking.startdate) = (date_part('year',current_date) - 6)
		group by Booking.travelerID, date_part('year', Booking.startdate)
	)
	union
	(
		select distinct Booking.travelerID, date_part('year', Booking.startdate) as year, count(*) as numBooking
		from Booking
		where date_part('year',Booking.startdate) = (date_part('year',current_date) - 7)
		group by Booking.travelerID, date_part('year', Booking.startdate)
	)
	union
	(
		select distinct Booking.travelerID, date_part('year', Booking.startdate) as year, count(*) as numBooking
		from Booking
		where date_part('year',Booking.startdate) = (date_part('year',current_date) - 8)
		group by Booking.travelerID, date_part('year', Booking.startdate)
	)
	union
	(
		select distinct Booking.travelerID, date_part('year', Booking.startdate) as year, count(*) as numBooking
		from Booking
		where date_part('year',Booking.startdate) = (date_part('year',current_date) - 9)
		group by Booking.travelerID, date_part('year', Booking.startdate)
	)
	union
	(
		select distinct Booking.travelerID, date_part('year', Booking.startdate) as year, count(*) as numBooking
		from Booking
		where date_part('year',Booking.startdate) = (date_part('year',current_date) - 10)
		group by Booking.travelerID, date_part('year', Booking.startdate)
	)) as foo;


/*Request within last ten years*/
create view RequestLastTenYears as
	select *
	from(
	(
		select distinct BookingRequest.travelerId, date_part('year', BookingRequest.startdate) as year, count(*) as numRequests
		from BookingRequest
		where date_part('year',BookingRequest.startdate) = (date_part('year',current_date) - 1)
		group by BookingRequest.travelerID, date_part('year', BookingRequest.startdate)
	)
	union
	(
		select distinct BookingRequest.travelerId, date_part('year', BookingRequest.startdate) as year, count(*) as numRequests
		from BookingRequest
		where date_part('year',BookingRequest.startdate) = (date_part('year',current_date) - 2)
		group by BookingRequest.travelerID, date_part('year', BookingRequest.startdate)
	)
	union
	(
		select distinct BookingRequest.travelerId, date_part('year', BookingRequest.startdate) as year, count(*) as numRequests
		from BookingRequest
		where date_part('year',BookingRequest.startdate) = (date_part('year',current_date) - 3)
		group by BookingRequest.travelerID, date_part('year', BookingRequest.startdate)
	)
	union
	(
		select distinct BookingRequest.travelerId, date_part('year', BookingRequest.startdate) as year, count(*) as numRequests
		from BookingRequest
		where date_part('year',BookingRequest.startdate) = (date_part('year',current_date) - 4)
		group by BookingRequest.travelerID, date_part('year', BookingRequest.startdate)
	)
	union
	(
		select distinct BookingRequest.travelerId, date_part('year', BookingRequest.startdate) as year, count(*) as numRequests
		from BookingRequest
		where date_part('year',BookingRequest.startdate) = (date_part('year',current_date) - 5)
		group by BookingRequest.travelerID, date_part('year', BookingRequest.startdate)
	)
	union
	(
		select distinct BookingRequest.travelerId, date_part('year', BookingRequest.startdate) as year, count(*) as numRequests
		from BookingRequest
		where date_part('year',BookingRequest.startdate) = (date_part('year',current_date) - 6)
		group by BookingRequest.travelerID, date_part('year', BookingRequest.startdate)
	)
	union
	(
		select distinct BookingRequest.travelerId, date_part('year', BookingRequest.startdate) as year, count(*) as numRequests
		from BookingRequest
		where date_part('year',BookingRequest.startdate) = (date_part('year',current_date) - 7)
		group by BookingRequest.travelerID, date_part('year', BookingRequest.startdate)
	)
	union
	(
		select distinct BookingRequest.travelerId, date_part('year', BookingRequest.startdate) as year, count(*) as numRequests
		from BookingRequest
		where date_part('year',BookingRequest.startdate) = (date_part('year',current_date) - 8)
		group by BookingRequest.travelerID, date_part('year', BookingRequest.startdate)
	)
	union
	(
		select distinct BookingRequest.travelerId, date_part('year', BookingRequest.startdate) as year, count(*) as numRequests
		from BookingRequest
		where date_part('year',BookingRequest.startdate) = (date_part('year',current_date) - 9)
		group by BookingRequest.travelerID, date_part('year', BookingRequest.startdate)
	)
	union
	(
		select distinct BookingRequest.travelerId, date_part('year', BookingRequest.startdate) as year, count(*) as numRequests
		from BookingRequest
		where date_part('year',BookingRequest.startdate) = (date_part('year',current_date) - 10)
		group by BookingRequest.travelerID, date_part('year', BookingRequest.startdate)
	)) as foo;

/*Those who made request but no booking*/
create view NoBooking as
	select travelerID, year
	from(
	(
		select RequestLastTenYears.travelerId, RequestLastTenYears.year
		from RequestLastTenYears
	)
	except
	(
		select BookingLastTenYears.travelerId, BookingLastTenYears.year
		from BookingLastTenYears
	)) as foo;

/*Dummy view has only one element 0*/
create view dummy as
	select count(*) as dum
	from NoBooking
	where travelerID < 0;

/*Update NoBooking*/
create view RequestNoBooking as
	select travelerID, year, dum as numBooking
	from NoBooking, dummy;

/*Update BookingLastTenYears*/
create view BookingLastTenYearsUP as
	select *
	from (select * from RequestNoBooking union select * from BookingLastTenYears) as foo;

/*Combine booking and request*/
create view BookingNRequest as
	select BookingLastTenYearsUP.travelerID, BookingLastTenYearsUP.year, BookingLastTenYearsUP.numBooking, RequestLastTenYears.numRequests
	from BookingLastTenYearsUP inner join RequestLastTenYears
	on BookingLastTenYearsUP.travelerID = RequestLastTenYears.travelerID and BookingLastTenYearsUP.year = RequestLastTenYears.year;

/*Those have neither booking nor request*/
create view Neither as
	select travelerID, cast(null as integer) as year, integer '0' as numBooking, integer '0' as numRequests
	from(
	(
		select travelerID
		from Traveler
	)
	except
	(
		select BookingNRequest.travelerID
		from BookingNRequest
	)) as foo;


/*Result*/
select t1.travelerID, Traveler.email, t1.year::integer, t1.numRequests, t1.numBooking
from 
(
	select * from Neither union select * from BookingNRequest
) as t1
inner join Traveler on t1.travelerID = Traveler.travelerID
order by t1.year DESC, t1.travelerID ASC;







