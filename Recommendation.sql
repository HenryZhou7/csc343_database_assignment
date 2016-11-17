create view TR as
	select Booking.travelerID, TravelerRating.listingID, TravelerRating.rating
	from TravelerRating inner join Booking
	on TravelerRating.listingID = Booking.listingID and TravelerRating.startDate = Booking.startDate;
	
create view TRH as 
	select TR.travelerID, Listing.owner, TR.rating
	from TR inner join Listing on TR.listingID = Listing.listingID;

create view Rate as 
	select travelerID, owner, avg(rating) as rating
	from TRH
	group by travelerID, owner;
	
create view Recommendation as
	select t2.owner, sum(t1.rating * t2.rating) as similarity
	from Rate as t1 inner join Rate as t2
	on t1.travelerID = t2.travelerID
	where t1.owner = string and t2.owner <> string
	group by t2.owner
	order by similarity DESC;