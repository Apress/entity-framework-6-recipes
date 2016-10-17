create table Chapter3.Job (
  JobID int primary key not null identity,
  JobDetails varchar(max))
go

create table Chapter3.Bid (
  BidID int primary key not null identity,
  JobID int not null,
  Amount Decimal,
  Bidder varchar(max))
go

alter table Chapter3.Bid add foreign key (JobID) references Chapter3.Job (JobID)
go

create procedure Chapter3.GetBidDetails
as
begin
 select * from Chapter3.Job
 select * from Chapter3.Bid
end
