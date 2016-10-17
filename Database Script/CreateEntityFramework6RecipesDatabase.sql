USE [master]
GO
/****** Object:  Database [EFRecipes]    Script Date: 12/24/2013 11:03:33 AM ******/
CREATE DATABASE [EFRecipes]
GO
USE [EFRecipes]
GO
/****** Object:  Schema [Chapter1]    Script Date: 12/24/2013 11:03:33 AM ******/
CREATE SCHEMA [Chapter1]
GO
/****** Object:  Schema [Chapter10]    Script Date: 12/24/2013 11:03:33 AM ******/
CREATE SCHEMA [Chapter10]
GO
/****** Object:  Schema [Chapter11]    Script Date: 12/24/2013 11:03:33 AM ******/
CREATE SCHEMA [Chapter11]
GO
/****** Object:  Schema [Chapter12]    Script Date: 12/24/2013 11:03:33 AM ******/
CREATE SCHEMA [Chapter12]
GO
/****** Object:  Schema [Chapter13]    Script Date: 12/24/2013 11:03:33 AM ******/
CREATE SCHEMA [Chapter13]
GO
/****** Object:  Schema [Chapter14]    Script Date: 12/24/2013 11:03:33 AM ******/
CREATE SCHEMA [Chapter14]
GO
/****** Object:  Schema [Chapter15]    Script Date: 12/24/2013 11:03:33 AM ******/
CREATE SCHEMA [Chapter15]
GO
/****** Object:  Schema [Chapter2]    Script Date: 12/24/2013 11:03:33 AM ******/
CREATE SCHEMA [Chapter2]
GO
/****** Object:  Schema [Chapter3]    Script Date: 12/24/2013 11:03:33 AM ******/
CREATE SCHEMA [Chapter3]
GO
/****** Object:  Schema [Chapter4]    Script Date: 12/24/2013 11:03:33 AM ******/
CREATE SCHEMA [Chapter4]
GO
/****** Object:  Schema [Chapter5]    Script Date: 12/24/2013 11:03:33 AM ******/
CREATE SCHEMA [Chapter5]
GO
/****** Object:  Schema [Chapter6]    Script Date: 12/24/2013 11:03:33 AM ******/
CREATE SCHEMA [Chapter6]
GO
/****** Object:  Schema [Chapter7]    Script Date: 12/24/2013 11:03:33 AM ******/
CREATE SCHEMA [Chapter7]
GO
/****** Object:  Schema [Chapter8]    Script Date: 12/24/2013 11:03:33 AM ******/
CREATE SCHEMA [Chapter8]
GO
/****** Object:  Schema [chapter9]    Script Date: 12/24/2013 11:03:33 AM ******/
CREATE SCHEMA [chapter9]
GO
/****** Object:  StoredProcedure [Chapter10].[DeleteAthlete]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter10].[DeleteAthlete]
(@AthleteId int)
as
begin
	delete from Chapter10.Athlete where AthleteId = @AthleteId
end

GO
/****** Object:  StoredProcedure [Chapter10].[DeleteAuthorBook]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [Chapter10].[DeleteAuthorBook]
(@AuthorId int,@BookId int)
as
begin
	delete chapter10.AuthorBook where AuthorId = @AuthorId and BookId = @BookId
end

GO
/****** Object:  StoredProcedure [Chapter10].[DeleteBook]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter10].[DeleteBook]
(@ProductId int)
as
begin
	delete from Chapter10.Product where ProductId = @ProductId
end

GO
/****** Object:  StoredProcedure [Chapter10].[DeleteDVD]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter10].[DeleteDVD]
(@ProductId int)
as
begin
	delete from Chapter10.Product where ProductId = @ProductId
end

GO
/****** Object:  StoredProcedure [Chapter10].[GetAllMedia]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [Chapter10].[GetAllMedia]
as
begin
select m.MediaId,c.Title,m.PublicationDate, null PlayTime,'Magazine' MediaType
from chapter10.Media c join chapter10.Magazine m on c.MediaId = m.MediaId
union
select d.MediaId,c.Title,null,d.PlayTime,'DVD'
from chapter10.Media c join chapter10.DVD d on c.MediaId = d.MediaId
end

GO
/****** Object:  StoredProcedure [Chapter10].[GetAllPeople]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter10].[GetAllPeople]
as
begin
select * from chapter10.Person
end

GO
/****** Object:  StoredProcedure [Chapter10].[GetCustomers]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [Chapter10].[GetCustomers]
(@Company varchar(50),@ContactTitle varchar(50))
as
begin
select * from 
chapter10.Customer where 
(@Company is null or Company = @Company) and
(@ContactTitle is null or ContactTitle = @ContactTitle)
End

GO
/****** Object:  StoredProcedure [Chapter10].[GetEmployeeAddresses]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [Chapter10].[GetEmployeeAddresses]
(@city varchar(50))
as
begin
	select [address], city, [state], ZIP
	from Chapter10.Employee where city = @city
end

GO
/****** Object:  StoredProcedure [Chapter10].[GetVehiclesWithRentals]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [Chapter10].[GetVehiclesWithRentals]
(@date date,
@TotalRentals int output,
@TotalPayments decimal(18,2) output
)
as
begin
select @TotalRentals = COUNT(*), @TotalPayments = SUM(payment)
from chapter10.Rental
where RentalDate = @date

select distinct v.*
from chapter10.Vehicle v join chapter10.Rental r
on v.VehicleId = r.VehicleId
end

GO
/****** Object:  StoredProcedure [Chapter10].[GetWithdrawals]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [Chapter10].[GetWithdrawals]
(@ATMId int, @WithdrawalDate date)
as
begin
	select SUM(amount) TotalWithdrawals
	from Chapter10.ATMWithdrawal
	where ATMId = @ATMId and [date] = @WithdrawalDate
end

GO
/****** Object:  StoredProcedure [Chapter10].[InsertAthlete]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter10].[InsertAthlete]
(@Name varchar(50), @Height int, @Weight int)
as
begin
	insert into Chapter10.Athlete values (@Name, @Height, @Weight)
	select SCOPE_IDENTITY() as AthleteId
end

GO
/****** Object:  StoredProcedure [Chapter10].[InsertAuthorBook]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter10].[InsertAuthorBook]
(@AuthorId int,@BookId int)
as
begin
	insert into chapter10.AuthorBook(AuthorId,BookId) values (@AuthorId,@BookId)
end

GO
/****** Object:  StoredProcedure [Chapter10].[InsertBook]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter10].[InsertBook]
(@Title varchar(50), @Publisher varchar(50))
as
begin
	insert into Chapter10.Product (Title, Publisher, ProductType) values
	   (@Title,@Publisher, 'Book')
	select SCOPE_IDENTITY() as ProductId
end

GO
/****** Object:  StoredProcedure [Chapter10].[InsertDVD]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter10].[InsertDVD]
(@Title varchar(50), @Rating varchar(50))
as
begin
	insert into Chapter10.Product (Title, Rating, ProductType) values
	   (@Title, @Rating, 'DVD')
	select SCOPE_IDENTITY() as ProductId
end

GO
/****** Object:  StoredProcedure [Chapter10].[UpdateAthlete]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter10].[UpdateAthlete]
(@AthleteId int, @Name varchar(50), @Height int, @Weight int)
as
begin
	update Chapter10.Athlete set Name = @Name, Height = @Height, [Weight] = @Weight 
	where AthleteId = @AthleteId
end

GO
/****** Object:  StoredProcedure [Chapter10].[UpdateBook]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter10].[UpdateBook]
(@Title varchar(50), @Publisher varchar(50), @ProductId int)
as
begin
	update Chapter10.Product set Title = @Title, Publisher = @Publisher
	  where ProductId = @ProductId
end

GO
/****** Object:  StoredProcedure [Chapter10].[UpdateDVD]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter10].[UpdateDVD]
(@Title varchar(50), @Rating varchar(50), @ProductId int)
as
begin
	update Chapter10.Product set Title = @Title, Rating = @Rating
	  where ProductId = @ProductId
end

GO
/****** Object:  StoredProcedure [Chapter14].[DeleteAccount]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter14].[DeleteAccount]
(@AccountNumber varchar(50), @TimeStamp TimeStamp, @RowsAffected int output)
as
begin
  delete Chapter14.Account where AccountNumber = @AccountNumber and TimeStamp = @TimeStamp
  set @RowsAffected = @@ROWCOUNT
end

GO
/****** Object:  StoredProcedure [Chapter14].[DeleteAction]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter14].[DeleteAction]
(@AccountNumber varchar(50), @TimeStamp TimeStamp, @RowsAffected int)
as
begin
  delete Chapter14.Account where AccountNumber = @AccountNumber and TimeStamp = @TimeStamp
  set @RowsAffected = @@ROWCOUNT
end

GO
/****** Object:  StoredProcedure [Chapter14].[DeleteAgent]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter14].[DeleteAgent]
(@Name varchar(50), @TimeStamp TimeStamp)
as
begin
  delete Chapter14.Agent where Name = @Name and TimeStamp = @TimeStamp
end

GO
/****** Object:  StoredProcedure [Chapter14].[InsertAccount]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter14].[InsertAccount]
(@AccountNumber varchar(50), @Name varchar(50), @Balance decimal, @RowsAffected int output)
as
begin
  insert into Chapter14.Account (AccountNumber, Name, Balance) values (@AccountNumber, @Name, @Balance)
  set @RowsAffected = @@ROWCOUNT 
  select TimeStamp from Chapter14.Account where AccountNumber = @AccountNumber
end

GO
/****** Object:  StoredProcedure [Chapter14].[InsertAction]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter14].[InsertAction]
(@AccountNumber varchar(50), @Name varchar(50), @Balance decimal, @RowsAffected int)
as
begin
  insert into Chapter14.Account (AccountNumber, Name, Balance) values (@AccountNumber, @Name, @Balance)
  set @RowsAffected = @@ROWCOUNT 
  select TimeStamp from Chapter14.Account where AccountNumber = @AccountNumber
end

GO
/****** Object:  StoredProcedure [Chapter14].[InsertAgent]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter14].[InsertAgent]
(@Name varchar(50), @Phone varchar(50))
as 
begin
  insert into Chapter14.Agent(Name, Phone) values (@Name, @Phone)
  select [TimeStamp] from Chapter14.Agent where Name = @Name and @@ROWCOUNT > 0
end

GO
/****** Object:  StoredProcedure [Chapter14].[UpdateAccount]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter14].[UpdateAccount]
(@AccountNumber varchar(50), @Name varchar(50), @Balance decimal, @TimeStamp TimeStamp, @RowsAffected int output)
as
begin
  update Chapter14.Account set Name = @Name, Balance = @Balance where AccountNumber = @AccountNumber and TimeStamp = @TimeStamp
  set @RowsAffected = @@ROWCOUNT
  select TimeStamp from Chapter14.Account where AccountNumber = @AccountNumber
end

GO
/****** Object:  StoredProcedure [Chapter14].[UpdateAction]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter14].[UpdateAction]
(@AccountNumber varchar(50), @Name varchar(50), @Balance decimal, @TimeStamp TimeStamp, @RowsAffected int)
as
begin
  update Chapter14.Account set Name = @Name, Balance = @Balance where AccountNumber = @AccountNumber and TimeStamp = @TimeStamp
  set @RowsAffected = @@ROWCOUNT
  select TimeStamp from Chapter14.Account where AccountNumber = @AccountNumber
end

GO
/****** Object:  StoredProcedure [Chapter14].[UpdateAgent]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter14].[UpdateAgent]
(@Name varchar(50), @Phone varchar(50), @TimeStamp TimeStamp)
as 
begin
  update Chapter14.Agent set Phone = @Phone where Name = @Name and [TimeStamp] = @TimeStamp
  select [TimeStamp] from Chapter14.Agent where Name = @Name and @@ROWCOUNT > 0
end

GO
/****** Object:  StoredProcedure [Chapter15].[DeleteCustomer]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [Chapter15].[DeleteCustomer]
 (@CustomerId int)
 as
 begin
 delete chapter15.Customer where CustomerId = @CustomerId
 end

GO
/****** Object:  StoredProcedure [Chapter15].[DeleteEmployee]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter15].[DeleteEmployee]
(@EmployeeId int)
as
begin
	delete Chapter15.Employee where EmployeeId = @EmployeeId
end

GO
/****** Object:  StoredProcedure [Chapter15].[DeleteFriend]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter15].[DeleteFriend]
(@PersonId int)
as
begin
	delete Chapter15.Friend where PersonId = @PersonId
end

GO
/****** Object:  StoredProcedure [Chapter15].[DeleteMember]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter15].[DeleteMember]
(@ProjectId int, @EmployeeId int)
as
begin
	delete Chapter15.ProjectEmployee where ProjectId = @ProjectId and EmployeeId = @EmployeeId
end

GO
/****** Object:  StoredProcedure [Chapter15].[DeleteOrder]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [Chapter15].[DeleteOrder]
 (@OrderId int,
 @CustomerId int)
 as
 begin
 delete chapter15.[Order] where OrderId = @OrderId
 end

GO
/****** Object:  StoredProcedure [Chapter15].[DeleteProject]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter15].[DeleteProject]
(@ProjectId int)
as
begin
	delete Chapter15.Project where ProjectId = @ProjectId
end

GO
/****** Object:  StoredProcedure [Chapter15].[DeleteProjectManager]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter15].[DeleteProjectManager]
(@ProjectId int, @EmployeeId int)
as
begin
	delete Chapter15.ProjectEmployee where ProjectId = @ProjectId and EmployeeId = @EmployeeId
end

GO
/****** Object:  StoredProcedure [Chapter15].[DeleteRelative]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter15].[DeleteRelative]
(@PersonId int)
as
begin
	delete Chapter15.[Relative] where PersonId = @PersonId
end

GO
/****** Object:  StoredProcedure [Chapter15].[DeleteResidence]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter15].[DeleteResidence]
(@AddressId int, @FriendId int, @RelativeId int)
as
begin
	delete from Chapter15.Residence where AddressId = @AddressId
end

GO
/****** Object:  StoredProcedure [Chapter15].[InsertCustomer]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [Chapter15].[InsertCustomer]
(@FirstName varchar(50),
 @LastName varchar(50),
 @FullName varchar(50))
 as
 begin
 insert into chapter15.Customer(FirstName,LastName) values (@FirstName,@LastName)
 select SCOPE_IDENTITY() CustomerId
 end

GO
/****** Object:  StoredProcedure [Chapter15].[InsertEmployee]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter15].[InsertEmployee]
(@Name varchar(50))
as
begin
	insert Chapter15.Employee (Name) values (@Name)
	select SCOPE_IDENTITY() as EmployeeId
end

GO
/****** Object:  StoredProcedure [Chapter15].[InsertFriend]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter15].[InsertFriend]
(@Name varchar(50))
as
begin
	insert into Chapter15.Friend (Name) values (@Name)
	select SCOPE_IDENTITY() as PersonId
end

GO
/****** Object:  StoredProcedure [Chapter15].[InsertMember]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter15].[InsertMember]
(@ProjectId int, @EmployeeId int)
as
begin
	insert into Chapter15.ProjectEmployee values (@ProjectId, @EmployeeId, 'MM')
end

GO
/****** Object:  StoredProcedure [Chapter15].[InsertOrder]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [Chapter15].[InsertOrder]
 (@OrderDate date,
 @CustomerId int,
 @OrderStatusTypeId int,
 @ShippingTypeId int,
 @OrderStatus varchar(50),
 @ShippingType varchar(50))
 as
 begin
 insert into chapter15.[Order](OrderDate,CustomerId,OrderStatusTypeId,ShippingTypeId)
 values (@OrderDate,@CustomerId,@OrderStatusTypeId,@ShippingTypeId)
  select SCOPE_IDENTITY() OrderId
 end

GO
/****** Object:  StoredProcedure [Chapter15].[InsertProject]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter15].[InsertProject]
(@Name varchar(50))
as 
begin
	insert into Chapter15.Project(Name) values (@Name)
	select SCOPE_IDENTITY() as ProjectId
end

GO
/****** Object:  StoredProcedure [Chapter15].[InsertProjectManager]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter15].[InsertProjectManager]
(@ProjectId int, @EmployeeId int)
as
begin
	insert into Chapter15.ProjectEmployee values (@ProjectId, @EmployeeId, 'PM')
end

GO
/****** Object:  StoredProcedure [Chapter15].[InsertRelative]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter15].[InsertRelative]
(@Name varchar(50))
as
begin
	insert into Chapter15.[Relative](Name) values (@Name)
	select SCOPE_IDENTITY() as PersonId
end

GO
/****** Object:  StoredProcedure [Chapter15].[InsertResidence]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter15].[InsertResidence]
(@Address varchar, @City varchar, @State varchar, @Zip varchar, @FriendId int, @RelativeId int)
as
begin
	declare @personid int, @persontype varchar(50)
	if @FriendId is not null
	begin
		set @personid = @FriendId
		set @persontype = 'Friend'
	end
	else
	begin
		set @personid = @RelativeId
		set @persontype = 'Relative'
	end
	insert into Chapter15.Residence ([Address],City, State, ZIP, PersonId, PersonType)
	values (@Address,@City,@State,@Zip,@personid,@persontype)
	select SCOPE_IDENTITY() as AddressId
end

GO
/****** Object:  StoredProcedure [Chapter15].[UpdateCustomer]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [Chapter15].[UpdateCustomer]
 (@FirstName varchar(50),
 @LastName varchar(50),
 @FullName varchar(50),
 @CustomerId int
 )
 as
 begin
 update chapter15.Customer set
 FirstName = @FirstName,
 LastName = @LastName
 where CustomerId = @CustomerId
 end

GO
/****** Object:  StoredProcedure [Chapter15].[UpdateEmployee]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter15].[UpdateEmployee]
(@Name varchar(50), @EmployeeId int)
as
begin
	update Chapter15.Employee set Name = @Name where EmployeeId = @EmployeeId
end

GO
/****** Object:  StoredProcedure [Chapter15].[UpdateFriend]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter15].[UpdateFriend]
(@Name varchar(50), @PersonId int)
as
begin
	update Chapter15.Friend set Name = @Name where PersonId = @PersonId
end

GO
/****** Object:  StoredProcedure [Chapter15].[UpdateOrder]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [Chapter15].[UpdateOrder]
 (@OrderID int,
 @OrderDate date,
 @CustomerId int,
 @OrderStatusTypeId int,
 @ShippingTypeId int,
 @OrderStatus varchar(50),
 @ShippingType varchar(50))
 as
 begin
 update chapter15.[Order] set
 OrderDate = @OrderDate,
 CustomerId = @CustomerId,
 OrderStatusTypeId = @OrderStatusTypeId,
 ShippingTypeId = @ShippingTypeId
 where OrderId = @OrderId
 end

GO
/****** Object:  StoredProcedure [Chapter15].[UpdateProject]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter15].[UpdateProject]
(@Name varchar(50), @ProjectId int)
as
begin
	update Chapter15.Project set Name = @Name where ProjectId = @ProjectId
end

GO
/****** Object:  StoredProcedure [Chapter15].[UpdateRelative]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter15].[UpdateRelative]
(@Name varchar(50), @PersonId int)
as
begin
	Update Chapter15.[Relative] set Name = @Name where PersonId = @PersonId
end

GO
/****** Object:  StoredProcedure [Chapter15].[UpdateResidence]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter15].[UpdateResidence]
(@AddressId int, @Address varchar, @City varchar, @State varchar, @Zip varchar, @FriendId int, @RelativeId int)
as
begin
	update Chapter15.Residence set [Address] = @Address, 
	City = @City, [State] = @State, ZIP = @Zip
	where AddressId = @AddressId
end

GO
/****** Object:  StoredProcedure [Chapter3].[GetBidDetails]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [Chapter3].[GetBidDetails]
as
begin
 select * from Chapter3.Job
 select * from Chapter3.Bid
end

GO
/****** Object:  StoredProcedure [Chapter6].[DeleteInstructor]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter6].[DeleteInstructor]
(@StaffId int)
as
begin
	delete Chapter6.Staff where StaffId = @StaffId
	delete Chapter6.Instructor where StaffId = @StaffId
end

GO
/****** Object:  StoredProcedure [Chapter6].[DeleteMember]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter6].[DeleteMember]
(@MemberId int)
as
begin
	delete from Chapter6.Member where MemberId = @MemberId
end

GO
/****** Object:  StoredProcedure [Chapter6].[DeleteOrder]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter6].[DeleteOrder]
(@OrderId int)
as
begin
	delete from Chapter6.WebOrder where OrderId = @OrderId
end

GO
/****** Object:  StoredProcedure [Chapter6].[DeletePrincipal]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter6].[DeletePrincipal]
(@StaffId int)
as
begin
	delete Chapter6.Staff where StaffId = @StaffId
	delete Chapter6.Principal where StaffId = @StaffId
end

GO
/****** Object:  StoredProcedure [Chapter6].[GetSubCategories]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [Chapter6].[GetSubCategories]
(@categoryid int)
as
begin
with cats as
	(
	select c1.*
	from chapter6.Category c1
	where CategoryId = @categoryid
	union all
	select c2.*
	from cats join  chapter6.Category c2 on cats.CategoryId = c2.ParentCategoryId
	)
	select * from cats where CategoryId != @categoryid
end

GO
/****** Object:  StoredProcedure [Chapter6].[InsertInstructor]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter6].[InsertInstructor]
(@Name varchar(50), @Salary decimal)
as
begin
	declare @staffid int
	insert into Chapter6.Staff(Name) values (@Name)
	set @staffid = SCOPE_IDENTITY()
	insert into Chapter6.Instructor(Salary,StaffId) values (@Salary,@staffid)
	select @staffid as StaffId,SCOPE_IDENTITY() as InstructorId
end

GO
/****** Object:  StoredProcedure [Chapter6].[InsertMember]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter6].[InsertMember]
(@Name varchar(50), @Phone varchar(50), @Age int)
as
begin
	insert into Chapter6.Member (Name, Phone, Age) 
	values (@Name,@Phone,@Age)
	select SCOPE_IDENTITY() as MemberId
end

GO
/****** Object:  StoredProcedure [Chapter6].[InsertOrder]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter6].[InsertOrder]
(@CustomerName varchar(50),@OrderDate date,@IsDeleted bit,@Amount decimal)
as
begin
	insert into chapter6.WebOrder (CustomerName, OrderDate, IsDeleted, Amount)
	values (@CustomerName, @OrderDate, @IsDeleted, @Amount)
	select SCOPE_IDENTITY() as OrderId
end

GO
/****** Object:  StoredProcedure [Chapter6].[InsertPrincipal]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter6].[InsertPrincipal]
(@Name varchar(50),@Salary decimal,@Bonus decimal)
as
begin
	declare @staffid int
	insert into Chapter6.Staff(Name) values (@Name)
	set @staffid = SCOPE_IDENTITY()
	insert into Chapter6.Principal(Salary,Bonus,StaffId) values (@Salary,@Bonus,@staffid)
	select @staffid as StaffId, SCOPE_IDENTITY() as PrincipalId
end

GO
/****** Object:  StoredProcedure [Chapter6].[UpdateInstructor]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter6].[UpdateInstructor]
(@Name varchar(50), @Salary decimal, @StaffId int, @InstructorId int)
as
begin
	update Chapter6.Staff set Name = @Name where StaffId = @StaffId
	update Chapter6.Instructor set Salary = @Salary where InstructorId = @InstructorId
end

GO
/****** Object:  StoredProcedure [Chapter6].[UpdateMember]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter6].[UpdateMember]
(@Name varchar(50), @Phone varchar(50), @Age int, @MemberId int)
as
begin
	update Chapter6.Member set Name=@Name, Phone=@Phone, Age=@Age
	where MemberId = @MemberId
end

GO
/****** Object:  StoredProcedure [Chapter6].[UpdateOrder]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter6].[UpdateOrder]
(@CustomerName varchar(50),@OrderDate date,@IsDeleted bit,@Amount decimal, @OrderId int)
as 
begin
	update chapter6.WebOrder set CustomerName = @CustomerName, OrderDate = @OrderDate,
	  IsDeleted = @IsDeleted,Amount = @Amount
	where OrderId = @OrderId
end

GO
/****** Object:  StoredProcedure [Chapter6].[UpdatePrincipal]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Chapter6].[UpdatePrincipal]
(@Name varchar(50),@Salary decimal, @Bonus decimal, @StaffId int, @PrincipalId int)
as
begin
	update Chapter6.Staff set Name = @Name where StaffId = @StaffId
	update Chapter6.Principal set Salary = @Salary, Bonus = @Bonus where PrincipalId = @PrincipalId
end

GO
/****** Object:  Table [Chapter1].[Customer]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter1].[Customer](
	[CustomerId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Email] [varchar](1024) NOT NULL,
	[Phone] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Customer_10] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter1].[Order]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter1].[Order](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[DateOrdered] [datetime] NOT NULL,
	[DateShipped] [datetime] NULL,
	[InvoiceNumber] [int] NOT NULL,
	[CustomerId] [int] NOT NULL,
 CONSTRAINT [PK_Order_10] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter10].[Athlete]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter10].[Athlete](
	[AthleteId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Height] [int] NOT NULL,
	[Weight] [int] NOT NULL,
 CONSTRAINT [PK_Athlete] PRIMARY KEY CLUSTERED 
(
	[AthleteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter10].[ATMMachine]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter10].[ATMMachine](
	[ATMId] [int] NOT NULL,
	[Location] [varchar](50) NOT NULL,
 CONSTRAINT [PK_ATMMachine] PRIMARY KEY CLUSTERED 
(
	[ATMId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter10].[ATMWithdrawal]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter10].[ATMWithdrawal](
	[WithdrawalId] [int] IDENTITY(1,1) NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[Date] [datetime] NOT NULL,
	[ATMId] [int] NOT NULL,
 CONSTRAINT [PK_ATMWithdrawl] PRIMARY KEY CLUSTERED 
(
	[WithdrawalId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter10].[Author]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter10].[Author](
	[AuthorId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Author_1] PRIMARY KEY CLUSTERED 
(
	[AuthorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter10].[AuthorBook]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter10].[AuthorBook](
	[AuthorId] [int] NOT NULL,
	[BookId] [int] NOT NULL,
 CONSTRAINT [PK_AuthorBook_1] PRIMARY KEY CLUSTERED 
(
	[AuthorId] ASC,
	[BookId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter10].[Book]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter10].[Book](
	[BookId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[ISBN] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Book_1] PRIMARY KEY CLUSTERED 
(
	[BookId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter10].[Claim]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter10].[Claim](
	[ClaimId] [int] IDENTITY(1,1) NOT NULL,
	[CreditorName] [varchar](50) NOT NULL,
	[AmountClaimed] [decimal](18, 2) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Claim] PRIMARY KEY CLUSTERED 
(
	[ClaimId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter10].[Customer]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter10].[Customer](
	[CustomerId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Company] [varchar](50) NOT NULL,
	[ContactTitle] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Customer_2] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter10].[DVD]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter10].[DVD](
	[MediaId] [int] NOT NULL,
	[PlayTime] [varchar](50) NOT NULL,
 CONSTRAINT [PK_DVD] PRIMARY KEY CLUSTERED 
(
	[MediaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter10].[Employee]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter10].[Employee](
	[EmployeeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Address] [varchar](50) NOT NULL,
	[City] [varchar](50) NOT NULL,
	[State] [varchar](2) NOT NULL,
	[ZIP] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Employee_3] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter10].[Magazine]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter10].[Magazine](
	[MediaId] [int] NOT NULL,
	[PublicationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Magazine] PRIMARY KEY CLUSTERED 
(
	[MediaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter10].[Media]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter10].[Media](
	[MediaId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Catalogue] PRIMARY KEY CLUSTERED 
(
	[MediaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter10].[Member]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter10].[Member](
	[MemberId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Member_2] PRIMARY KEY CLUSTERED 
(
	[MemberId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter10].[Message]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter10].[Message](
	[MessageId] [int] IDENTITY(1,1) NOT NULL,
	[MemberId] [int] NOT NULL,
	[DateSent] [datetime] NOT NULL,
	[Subject] [varchar](50) NOT NULL,
	[MessageBody] [varchar](8000) NOT NULL,
 CONSTRAINT [PK_Message] PRIMARY KEY CLUSTERED 
(
	[MessageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter10].[Person]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter10].[Person](
	[PersonId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Degree] [varchar](50) NULL,
	[Salary] [decimal](18, 2) NULL,
	[PersonType] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter10].[Product]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter10].[Product](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[ProductType] [varchar](50) NOT NULL,
	[Publisher] [varchar](50) NULL,
	[Rating] [varchar](50) NULL,
 CONSTRAINT [PK_Product_4] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter10].[Rental]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter10].[Rental](
	[RentalId] [int] IDENTITY(1,1) NOT NULL,
	[RentalDate] [datetime] NOT NULL,
	[Payment] [decimal](18, 2) NOT NULL,
	[VehicleId] [int] NOT NULL,
 CONSTRAINT [PK_Rental] PRIMARY KEY CLUSTERED 
(
	[RentalId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter10].[Vehicle]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter10].[Vehicle](
	[VehicleId] [int] IDENTITY(1,1) NOT NULL,
	[Model] [varchar](50) NOT NULL,
	[Manufacturer] [varchar](50) NOT NULL,
	[Year] [int] NOT NULL,
 CONSTRAINT [PK_Vehicle] PRIMARY KEY CLUSTERED 
(
	[VehicleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter11].[Appointment]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter11].[Appointment](
	[AppointmentId] [int] IDENTITY(1,1) NOT NULL,
	[StartsAt] [datetime] NOT NULL,
	[GoesTo] [datetime] NOT NULL,
 CONSTRAINT [PK_Appointment_1] PRIMARY KEY CLUSTERED 
(
	[AppointmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter11].[Associate]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter11].[Associate](
	[AssociateId] [int] IDENTITY(1,1) NOT NULL,
	[AssociateType] [varchar](50) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[ReportsTo] [int] NULL,
 CONSTRAINT [PK_Associate_1] PRIMARY KEY CLUSTERED 
(
	[AssociateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter11].[Category]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter11].[Category](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Category_2] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter11].[Customer]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter11].[Customer](
	[CustomerId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[City] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Customer_3] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter11].[Employee]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter11].[Employee](
	[EmployeeId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[Birthdate] [datetime] NOT NULL,
 CONSTRAINT [PK_Employee_4] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter11].[Event]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter11].[Event](
	[EventId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[SponsorId] [int] NOT NULL,
 CONSTRAINT [PK_Event_2] PRIMARY KEY CLUSTERED 
(
	[EventId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter11].[Hotel]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter11].[Hotel](
	[HotelId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Hotel_1] PRIMARY KEY CLUSTERED 
(
	[HotelId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter11].[Invoice]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter11].[Invoice](
	[InvoiceId] [int] IDENTITY(1,1) NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[Description] [varchar](50) NOT NULL,
	[Date] [datetime] NOT NULL,
	[CustomerId] [int] NOT NULL,
 CONSTRAINT [PK_Invoice_1] PRIMARY KEY CLUSTERED 
(
	[InvoiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter11].[MovieRental]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter11].[MovieRental](
	[RentalId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[RentalDate] [datetime] NOT NULL,
	[ReturnedDate] [datetime] NOT NULL,
	[LateFees] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_MovieRental] PRIMARY KEY CLUSTERED 
(
	[RentalId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter11].[Order]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter11].[Order](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[OrderAmount] [decimal](18, 2) NOT NULL,
	[CustomerId] [int] NOT NULL,
 CONSTRAINT [PK_Order_4] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter11].[Patient]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter11].[Patient](
	[PatientId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Age] [int] NOT NULL,
 CONSTRAINT [PK_Patient_1] PRIMARY KEY CLUSTERED 
(
	[PatientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter11].[PatientVisit]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter11].[PatientVisit](
	[VisitId] [int] IDENTITY(1,1) NOT NULL,
	[Cost] [decimal](18, 2) NOT NULL,
	[Hospital] [varchar](50) NOT NULL,
	[PatientId] [int] NOT NULL,
 CONSTRAINT [PK_PatientVisit] PRIMARY KEY CLUSTERED 
(
	[VisitId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter11].[Product]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter11].[Product](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [varchar](50) NOT NULL,
	[UnitPrice] [decimal](18, 2) NOT NULL,
	[CategoryId] [int] NOT NULL,
 CONSTRAINT [PK_Product_3] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter11].[Reservation]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter11].[Reservation](
	[ReservationId] [int] IDENTITY(1,1) NOT NULL,
	[RoomNumber] [int] NOT NULL,
	[Cost] [decimal](18, 2) NOT NULL,
	[ReservationDate] [datetime] NOT NULL,
	[VisitorId] [int] NOT NULL,
	[HotelId] [int] NOT NULL,
 CONSTRAINT [PK_Reservation_1] PRIMARY KEY CLUSTERED 
(
	[ReservationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter11].[Sponsor]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter11].[Sponsor](
	[SponsorId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[SponsorTypeId] [int] NOT NULL,
 CONSTRAINT [PK_Sponser] PRIMARY KEY CLUSTERED 
(
	[SponsorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter11].[SponsorType]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter11].[SponsorType](
	[SponsorTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](50) NOT NULL,
 CONSTRAINT [PK_SponsorType] PRIMARY KEY CLUSTERED 
(
	[SponsorTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter11].[Visitor]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter11].[Visitor](
	[VistorId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Vistor] PRIMARY KEY CLUSTERED 
(
	[VistorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter11].[WebCustomer]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter11].[WebCustomer](
	[CustomerId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Zip] [varchar](50) NOT NULL,
 CONSTRAINT [PK_WebCustomer] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter11].[WebProduct]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter11].[WebProduct](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](50) NULL,
 CONSTRAINT [PK_WebProduct] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter11].[Zip]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter11].[Zip](
	[ZipCode] [varchar](50) NOT NULL,
	[Latitude] [decimal](18, 0) NOT NULL,
	[Longitude] [decimal](18, 0) NOT NULL,
 CONSTRAINT [PK_Zip] PRIMARY KEY CLUSTERED 
(
	[ZipCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter12].[Applicant]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter12].[Applicant](
	[ApplicantId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[ResumePath] [varchar](255) NOT NULL,
 CONSTRAINT [PK_Applicant] PRIMARY KEY CLUSTERED 
(
	[ApplicantId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter12].[Candidate]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter12].[Candidate](
	[CandidateId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Resume] [xml] NOT NULL,
 CONSTRAINT [PK_Candidate] PRIMARY KEY CLUSTERED 
(
	[CandidateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter12].[Cart]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter12].[Cart](
	[CartId] [int] IDENTITY(1,1) NOT NULL,
	[CartTotal] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Cart] PRIMARY KEY CLUSTERED 
(
	[CartId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter12].[CartItem]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter12].[CartItem](
	[CartItemId] [int] IDENTITY(1,1) NOT NULL,
	[CartId] [int] NOT NULL,
	[SKU] [varchar](50) NOT NULL,
	[Quantity] [int] NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_CartItem] PRIMARY KEY CLUSTERED 
(
	[CartItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter12].[Class]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter12].[Class](
	[ClassId] [int] IDENTITY(1,1) NOT NULL,
	[CourseId] [int] NOT NULL,
	[Instructor] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Class] PRIMARY KEY CLUSTERED 
(
	[ClassId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter12].[Course]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter12].[Course](
	[CourseId] [int] IDENTITY(1,1) NOT NULL,
	[CourseName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Course_1] PRIMARY KEY CLUSTERED 
(
	[CourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter12].[Customer]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter12].[Customer](
	[CustomerId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Custerom] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter12].[Donation]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter12].[Donation](
	[DonationId] [int] IDENTITY(1,1) NOT NULL,
	[DonorName] [varchar](50) NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Donation] PRIMARY KEY CLUSTERED 
(
	[DonationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter12].[Employee]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter12].[Employee](
	[EmployeeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Salary] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Employee_5] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter12].[Enrollment]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter12].[Enrollment](
	[EnrollmentId] [int] IDENTITY(1,1) NOT NULL,
	[ClassId] [int] NOT NULL,
	[Student] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Enrollment] PRIMARY KEY CLUSTERED 
(
	[EnrollmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter12].[Ingredient]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter12].[Ingredient](
	[IngredientId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[RecipeId] [int] NOT NULL,
 CONSTRAINT [PK_Ingredient] PRIMARY KEY CLUSTERED 
(
	[IngredientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter12].[Order]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter12].[Order](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](50) NOT NULL,
	[OrderStatusId] [int] NOT NULL,
 CONSTRAINT [PK_Order_5] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter12].[OrderStatus]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter12].[OrderStatus](
	[OrderStatusId] [int] NOT NULL,
	[Status] [varchar](50) NOT NULL,
 CONSTRAINT [PK_OrderStatus] PRIMARY KEY CLUSTERED 
(
	[OrderStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter12].[ParkingTicket]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter12].[ParkingTicket](
	[TicketId] [int] IDENTITY(1,1) NOT NULL,
	[Amount] [money] NOT NULL,
	[CreateDate]  AS (getdate()),
	[Paid] [bit] NOT NULL,
	[PaidDate] [date] NULL,
	[TimeStamp] [timestamp] NOT NULL,
 CONSTRAINT [PK_ParkingTicket] PRIMARY KEY CLUSTERED 
(
	[TicketId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter12].[PurchaseOrder]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter12].[PurchaseOrder](
	[PurchaseOrderId] [uniqueidentifier] NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[Paid] [bit] NOT NULL,
	[Comments] [varchar](8000) NOT NULL,
 CONSTRAINT [PK_PurchaseOrder] PRIMARY KEY CLUSTERED 
(
	[PurchaseOrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter12].[Recipe]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter12].[Recipe](
	[RecipeId] [int] IDENTITY(1,1) NOT NULL,
	[RecipeName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Recipe] PRIMARY KEY CLUSTERED 
(
	[RecipeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter12].[SalesOrder]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter12].[SalesOrder](
	[SalesOrderId] [int] IDENTITY(1,1) NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[Status] [varchar](50) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[ShippedDate] [datetime] NULL,
	[Shipped] [bit] NULL,
	[ShippingCharge] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_SalesOrder] PRIMARY KEY CLUSTERED 
(
	[SalesOrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter12].[Step]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter12].[Step](
	[StepId] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](50) NOT NULL,
	[RecipeId] [int] NOT NULL,
 CONSTRAINT [PK_Step] PRIMARY KEY CLUSTERED 
(
	[StepId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter12].[User]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter12].[User](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [varchar](50) NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_User_1] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter13].[Account]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter13].[Account](
	[AccountId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Balance] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Account_3] PRIMARY KEY CLUSTERED 
(
	[AccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter13].[Accountant]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter13].[Accountant](
	[PersonId] [int] NOT NULL,
 CONSTRAINT [PK_Accountant] PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter13].[Appointment]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter13].[Appointment](
	[AppointmentId] [int] IDENTITY(1,1) NOT NULL,
	[AppointmentDate] [datetime] NOT NULL,
	[Patient] [varchar](50) NOT NULL,
	[DoctorId] [int] NOT NULL,
 CONSTRAINT [PK_Appointment_2] PRIMARY KEY CLUSTERED 
(
	[AppointmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter13].[Associate]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter13].[Associate](
	[AssociateId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[City] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Associate_3] PRIMARY KEY CLUSTERED 
(
	[AssociateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter13].[CD]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter13].[CD](
	[CDId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
 CONSTRAINT [PK_CD] PRIMARY KEY CLUSTERED 
(
	[CDId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter13].[Client]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter13].[Client](
	[ClientId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[AccountantId] [int] NOT NULL,
 CONSTRAINT [PK_Client_1] PRIMARY KEY CLUSTERED 
(
	[ClientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter13].[College]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter13].[College](
	[CollegeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_College] PRIMARY KEY CLUSTERED 
(
	[CollegeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter13].[Company]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter13].[Company](
	[CompanyId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Company_1] PRIMARY KEY CLUSTERED 
(
	[CompanyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter13].[CourtDate]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter13].[CourtDate](
	[AppointmentId] [int] IDENTITY(1,1) NOT NULL,
	[CourtDate] [datetime] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[LawyerId] [int] NOT NULL,
 CONSTRAINT [PK_CourtDate] PRIMARY KEY CLUSTERED 
(
	[AppointmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter13].[CreditCard]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter13].[CreditCard](
	[CardNumber] [varchar](50) NOT NULL,
	[Type] [varchar](50) NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
	[CustomerId] [int] NOT NULL,
 CONSTRAINT [PK_CreditCard] PRIMARY KEY CLUSTERED 
(
	[CardNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter13].[Customer]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter13].[Customer](
	[CustomerId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[City] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Customer_6] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter13].[CustomerComplaint]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter13].[CustomerComplaint](
	[CustomerComplaintId] [int] IDENTITY(1,1) NOT NULL,
	[Comment] [varchar](1024) NOT NULL,
	[ReportedBy] [varchar](50) NOT NULL,
	[ActionTaken] [varchar](50) NULL,
 CONSTRAINT [PK_CustomerComplaint] PRIMARY KEY CLUSTERED 
(
	[CustomerComplaintId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter13].[Doctor]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter13].[Doctor](
	[DoctorId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[CompanyId] [int] NOT NULL,
 CONSTRAINT [PK_Doctor_1] PRIMARY KEY CLUSTERED 
(
	[DoctorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter13].[Employee]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter13].[Employee](
	[EmployeeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Employee_7] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter13].[HourlyEmployee]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter13].[HourlyEmployee](
	[EmployeeId] [int] NOT NULL,
	[Rate] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_HourlyEmployee] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter13].[Lawyer]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter13].[Lawyer](
	[PersonId] [int] NOT NULL,
 CONSTRAINT [PK_Lawyer_1] PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter13].[Member]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter13].[Member](
	[MemberId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Salary] [decimal](18, 2) NULL,
 CONSTRAINT [PK_Member_3] PRIMARY KEY CLUSTERED 
(
	[MemberId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter13].[Painting]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter13].[Painting](
	[AccessionNumber] [varchar](50) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Artist] [varchar](50) NOT NULL,
	[LastSalePrice] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Painting] PRIMARY KEY CLUSTERED 
(
	[AccessionNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter13].[Paycheck]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter13].[Paycheck](
	[PayCheckId] [int] IDENTITY(1,1) NOT NULL,
	[AssociateId] [int] NOT NULL,
	[PayDate] [datetime] NOT NULL,
	[Gross] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Pay] PRIMARY KEY CLUSTERED 
(
	[PayCheckId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter13].[Payment]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter13].[Payment](
	[PaymentId] [int] IDENTITY(1,1) NOT NULL,
	[PaidTo] [varchar](50) NOT NULL,
	[Paid] [decimal](18, 2) NOT NULL,
	[AccountId] [int] NOT NULL,
 CONSTRAINT [PK_Payment_1] PRIMARY KEY CLUSTERED 
(
	[PaymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter13].[Person]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter13].[Person](
	[PersonId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[CollegeId] [int] NOT NULL,
 CONSTRAINT [PK_Person_4] PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter13].[Reservation]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter13].[Reservation](
	[ReservationId] [int] IDENTITY(1,1) NOT NULL,
	[ResDate] [datetime] NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Reservation_2] PRIMARY KEY CLUSTERED 
(
	[ReservationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter13].[Resume]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter13].[Resume](
	[ResumeId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Body] [varchar](max) NOT NULL,
 CONSTRAINT [PK_Resume] PRIMARY KEY CLUSTERED 
(
	[ResumeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter13].[SalariedEmployee]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter13].[SalariedEmployee](
	[EmployeeId] [int] NOT NULL,
	[Salary] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_SalariedEmployee] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter13].[Track]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter13].[Track](
	[Title] [varchar](50) NOT NULL,
	[Artist] [varchar](50) NOT NULL,
	[CDId] [int] NOT NULL,
 CONSTRAINT [PK_Track] PRIMARY KEY CLUSTERED 
(
	[Title] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter13].[Transaction]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter13].[Transaction](
	[TransactionId] [int] IDENTITY(1,1) NOT NULL,
	[CardNumber] [varchar](50) NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Transaction] PRIMARY KEY CLUSTERED 
(
	[TransactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter14].[Account]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter14].[Account](
	[AccountNumber] [varchar](50) NOT NULL,
	[Balance] [decimal](18, 2) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[TimeStamp] [timestamp] NOT NULL,
 CONSTRAINT [PK_Account_4] PRIMARY KEY CLUSTERED 
(
	[AccountNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter14].[Agent]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter14].[Agent](
	[Name] [varchar](50) NOT NULL,
	[Phone] [varchar](50) NOT NULL,
	[TimeStamp] [timestamp] NOT NULL,
 CONSTRAINT [PK_Agent_2] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter14].[Employee]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter14].[Employee](
	[EmployeeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Employee_9] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter14].[ForumPost]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter14].[ForumPost](
	[PostingId] [int] IDENTITY(1,1) NOT NULL,
	[Post] [varchar](8000) NOT NULL,
	[ForumUser] [varchar](50) NOT NULL,
	[TimeStamp] [timestamp] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_ForumPost] PRIMARY KEY CLUSTERED 
(
	[PostingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter14].[Instructor]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter14].[Instructor](
	[PersonId] [int] NOT NULL,
	[HireDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Instructor_2] PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter14].[Person]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter14].[Person](
	[PersonId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[TimeStamp] [timestamp] NOT NULL,
 CONSTRAINT [PK_Person_5] PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter14].[Product]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter14].[Product](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[TimeStamp] [timestamp] NOT NULL,
	[UnitPrice] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Product_8] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter14].[Student]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter14].[Student](
	[PersonId] [int] NOT NULL,
	[EnrollmentDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Student_3] PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter15].[Account]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter15].[Account](
	[AccountId] [int] IDENTITY(1,1) NOT NULL,
	[Balance] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Account_1] PRIMARY KEY CLUSTERED 
(
	[AccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter15].[Article]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter15].[Article](
	[ArticleId] [int] NOT NULL,
	[ArticleContent] [varchar](50) NOT NULL,
	[ArticleType] [varchar](50) NOT NULL,
	[Comments] [varchar](50) NULL,
	[Author] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Article] PRIMARY KEY CLUSTERED 
(
	[ArticleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter15].[Author]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter15].[Author](
	[AuthorId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Author] PRIMARY KEY CLUSTERED 
(
	[AuthorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter15].[AuthorBook]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter15].[AuthorBook](
	[BookId] [int] NOT NULL,
	[AuthorId] [int] NOT NULL,
	[IsPrimary] [bit] NOT NULL,
 CONSTRAINT [PK_AuthorBook] PRIMARY KEY CLUSTERED 
(
	[BookId] ASC,
	[AuthorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter15].[Book]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter15].[Book](
	[BookId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[ISBN] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Book] PRIMARY KEY CLUSTERED 
(
	[BookId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter15].[Client]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter15].[Client](
	[ClientId] [int] IDENTITY(2,2) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Client] PRIMARY KEY CLUSTERED 
(
	[ClientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter15].[Contact]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter15].[Contact](
	[ContactId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Phone] [varchar](20) NOT NULL,
	[AccountId] [int] NULL,
 CONSTRAINT [PK_Contact] PRIMARY KEY CLUSTERED 
(
	[ContactId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter15].[CreditReport]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter15].[CreditReport](
	[ReportId] [int] IDENTITY(1,1) NOT NULL,
	[CreditRating] [int] NOT NULL,
	[CustomerId] [int] NOT NULL,
 CONSTRAINT [PK_CreditReport] PRIMARY KEY CLUSTERED 
(
	[ReportId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter15].[CreditRiskCustomer]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter15].[CreditRiskCustomer](
	[CustomerId] [int] IDENTITY(1,2) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_CreditRiskCustomer] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter15].[CreditRiskOrder]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter15].[CreditRiskOrder](
	[OrderId] [int] IDENTITY(1,2) NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[CustomerId] [int] NOT NULL,
 CONSTRAINT [PK_CreditRiskOrder] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter15].[Customer]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter15].[Customer](
	[CustomerId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Customer_1] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter15].[CustomerDiscount]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter15].[CustomerDiscount](
	[CustomerId] [int] NOT NULL,
	[PurchaseDiscount] [int] NOT NULL,
 CONSTRAINT [PK_CustomerDiscount] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter15].[Employee]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter15].[Employee](
	[EmployeeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Member_1] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter15].[Friend]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter15].[Friend](
	[PersonId] [int] IDENTITY(1,2) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Friend] PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter15].[Invoice]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter15].[Invoice](
	[InvoiceId] [int] IDENTITY(1,2) NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[ClientId] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Invoice] PRIMARY KEY CLUSTERED 
(
	[InvoiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter15].[Media]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter15].[Media](
	[MediaId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Media] PRIMARY KEY CLUSTERED 
(
	[MediaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter15].[Order]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter15].[Order](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[CustomerId] [int] NOT NULL,
	[OrderStatusTypeId] [int] NOT NULL,
	[ShippingTypeId] [int] NOT NULL,
 CONSTRAINT [PK_Order_3] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter15].[OrderStatusType]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter15].[OrderStatusType](
	[OrderStatusTypeId] [int] NOT NULL,
	[Description] [varchar](100) NOT NULL,
 CONSTRAINT [PK_OrderStatusType] PRIMARY KEY CLUSTERED 
(
	[OrderStatusTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter15].[Person]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter15].[Person](
	[PersonId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[EnrollmentDate] [datetime] NULL,
	[HireDate] [datetime] NULL,
	[Salary] [decimal](18, 2) NULL,
	[Role] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Person_2] PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter15].[PreferredCustomer]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter15].[PreferredCustomer](
	[CustomerId] [int] IDENTITY(2,2) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_PreferredCustomer] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter15].[PreferredOrder]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter15].[PreferredOrder](
	[OrderId] [int] IDENTITY(2,2) NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[CustomerId] [int] NOT NULL,
 CONSTRAINT [PK_PreferredOrder] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter15].[PriorityWorkOrder]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter15].[PriorityWorkOrder](
	[WorkOrderId] [int] IDENTITY(2,2) NOT NULL,
	[RequestDate] [datetime] NOT NULL,
	[Problem] [varchar](1024) NOT NULL,
 CONSTRAINT [PK_PriorityWorkOrder] PRIMARY KEY CLUSTERED 
(
	[WorkOrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter15].[Product]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter15].[Product](
	[ProductId] [int] NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Description] [varchar](50) NULL,
	[StockCount] [int] NULL,
	[Discontinued] [int] NOT NULL,
	[SupplierId] [int] NULL,
 CONSTRAINT [PK_Product_2] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter15].[Project]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter15].[Project](
	[ProjectId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Project_1] PRIMARY KEY CLUSTERED 
(
	[ProjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter15].[ProjectEmployee]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter15].[ProjectEmployee](
	[ProjectId] [int] NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[Role] [varchar](50) NOT NULL,
 CONSTRAINT [PK_ProjectEmployee] PRIMARY KEY CLUSTERED 
(
	[ProjectId] ASC,
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter15].[Relative]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter15].[Relative](
	[PersonId] [int] IDENTITY(0,2) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Relative] PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter15].[Residence]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter15].[Residence](
	[AddressId] [int] IDENTITY(1,1) NOT NULL,
	[Address] [varchar](50) NOT NULL,
	[City] [varchar](50) NOT NULL,
	[State] [varchar](2) NOT NULL,
	[ZIP] [varchar](10) NOT NULL,
	[PersonId] [int] NOT NULL,
	[PersonType] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Residence] PRIMARY KEY CLUSTERED 
(
	[AddressId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter15].[ShippingType]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter15].[ShippingType](
	[ShippingTypeId] [int] NOT NULL,
	[Description] [varchar](100) NOT NULL,
 CONSTRAINT [PK_ShippingType] PRIMARY KEY CLUSTERED 
(
	[ShippingTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter15].[Supplier]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter15].[Supplier](
	[SupplierId] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Supplier] PRIMARY KEY CLUSTERED 
(
	[SupplierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter15].[User]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter15].[User](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter15].[Video]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter15].[Video](
	[VideoId] [int] NOT NULL,
	[VideoType] [varchar](50) NOT NULL,
	[Instructor] [varchar](50) NULL,
	[Rating] [int] NULL,
	[ResourcePath] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Video] PRIMARY KEY CLUSTERED 
(
	[VideoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter15].[WorkOrder]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter15].[WorkOrder](
	[WorkOrderId] [int] IDENTITY(1,2) NOT NULL,
	[RequestDate] [datetime] NOT NULL,
	[Problem] [varchar](1024) NOT NULL,
 CONSTRAINT [PK_WorkOrder] PRIMARY KEY CLUSTERED 
(
	[WorkOrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter2].[Account]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter2].[Account](
	[AccountId] [int] IDENTITY(1,1) NOT NULL,
	[DeletedOn] [datetime] NULL,
	[AccountHolderId] [int] NOT NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[AccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter2].[Agent]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter2].[Agent](
	[AgentId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[AddressLine1] [varchar](255) NOT NULL,
	[AddressLine2] [varchar](255) NOT NULL,
	[City] [varchar](255) NOT NULL,
	[State] [varchar](2) NOT NULL,
	[ZIPCode] [varchar](5) NOT NULL,
 CONSTRAINT [PK_Agent] PRIMARY KEY CLUSTERED 
(
	[AgentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter2].[Album]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter2].[Album](
	[AlbumId] [int] IDENTITY(1,1) NOT NULL,
	[AlbumName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Album] PRIMARY KEY CLUSTERED 
(
	[AlbumId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter2].[Artist]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter2].[Artist](
	[ArtistId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NULL,
	[MiddleName] [varchar](50) NULL,
	[LastName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Artist] PRIMARY KEY CLUSTERED 
(
	[ArtistId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter2].[Business]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter2].[Business](
	[BusinessId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[LicenseNumber] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Business] PRIMARY KEY CLUSTERED 
(
	[BusinessId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter2].[eCommerce]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter2].[eCommerce](
	[BusinessId] [int] NOT NULL,
	[URL] [varchar](1024) NULL,
 CONSTRAINT [PK_eCommerce] PRIMARY KEY CLUSTERED 
(
	[BusinessId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter2].[Employee]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter2].[Employee](
	[EmployeeId] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeType] [int] NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[Salary] [decimal](18, 2) NULL,
	[Wage] [decimal](18, 2) NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter2].[Item]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter2].[Item](
	[SKU] [int] NOT NULL,
	[Description] [varchar](50) NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Item] PRIMARY KEY CLUSTERED 
(
	[SKU] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter2].[LinkTable]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter2].[LinkTable](
	[ArtistId] [int] NOT NULL,
	[AlbumId] [int] NOT NULL,
 CONSTRAINT [PK_LinkTable] PRIMARY KEY CLUSTERED 
(
	[ArtistId] ASC,
	[AlbumId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter2].[Location]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter2].[Location](
	[LocationId] [int] IDENTITY(1,1) NOT NULL,
	[Address] [varchar](50) NOT NULL,
	[City] [varchar](50) NOT NULL,
	[State] [varchar](2) NOT NULL,
	[ZIPCode] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED 
(
	[LocationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter2].[Meter]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter2].[Meter](
	[MeterId] [int] IDENTITY(1,1) NOT NULL,
	[MeterName] [varchar](30) NOT NULL,
 CONSTRAINT [PK_Meter] PRIMARY KEY CLUSTERED 
(
	[MeterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter2].[Order]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter2].[Order](
	[OrderId] [int] NOT NULL,
	[OrderDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter2].[OrderItem]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter2].[OrderItem](
	[OrderId] [int] NOT NULL,
	[SKU] [int] NOT NULL,
	[Count] [int] NOT NULL,
 CONSTRAINT [PK_OrderItem] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC,
	[SKU] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter2].[Park]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter2].[Park](
	[ParkId] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[OfficeLocationId] [int] NOT NULL,
 CONSTRAINT [PK_Park] PRIMARY KEY CLUSTERED 
(
	[ParkId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter2].[People]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter2].[People](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](max) NOT NULL,
	[MiddleName] [nvarchar](max) NOT NULL,
	[LastName] [nvarchar](max) NOT NULL,
	[PhoneNumber] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_People] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [Chapter2].[Photograph]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter2].[Photograph](
	[PhotoId] [int] NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[ThumbnailBits] [image] NOT NULL,
	[HighResolutionBits] [image] NOT NULL,
 CONSTRAINT [PK_Photograph] PRIMARY KEY CLUSTERED 
(
	[PhotoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter2].[PictureCategory]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter2].[PictureCategory](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[ParentCategoryId] [int] NULL,
 CONSTRAINT [PK_PictureCategory] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter2].[Poem]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter2].[Poem](
	[PoemId] [int] IDENTITY(1,1) NOT NULL,
	[PoetId] [int] NOT NULL,
	[Title] [varchar](255) NOT NULL,
	[MeterId] [int] NOT NULL,
 CONSTRAINT [PK_Poem] PRIMARY KEY CLUSTERED 
(
	[PoemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter2].[Poet]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter2].[Poet](
	[PoetId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[MiddleName] [varchar](50) NULL,
	[LastName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Poet] PRIMARY KEY CLUSTERED 
(
	[PoetId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter2].[Product]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter2].[Product](
	[SKU] [int] NOT NULL,
	[Description] [varchar](50) NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[SKU] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter2].[ProductWebInfo]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter2].[ProductWebInfo](
	[SKU] [int] NOT NULL,
	[ImageURL] [varchar](1024) NULL,
 CONSTRAINT [PK_ProductWebInfo] PRIMARY KEY CLUSTERED 
(
	[SKU] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter2].[Retail]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter2].[Retail](
	[BusinessId] [int] NOT NULL,
	[Address] [varchar](50) NOT NULL,
	[City] [varchar](50) NOT NULL,
	[State] [varchar](2) NOT NULL,
	[ZIPCode] [varchar](9) NOT NULL,
 CONSTRAINT [PK_Retail] PRIMARY KEY CLUSTERED 
(
	[BusinessId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter3].[Accident]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter3].[Accident](
	[AccidentId] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](50) NOT NULL,
	[Severity] [int] NOT NULL,
	[WorkerId] [int] NOT NULL,
 CONSTRAINT [PK_Accident] PRIMARY KEY CLUSTERED 
(
	[AccidentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter3].[Account]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter3].[Account](
	[AccountId] [int] IDENTITY(1,1) NOT NULL,
	[City] [varchar](50) NOT NULL,
	[State] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Account_2] PRIMARY KEY CLUSTERED 
(
	[AccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter3].[Associate]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter3].[Associate](
	[AssociateId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Associate_2] PRIMARY KEY CLUSTERED 
(
	[AssociateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter3].[AssociateSalary]    Script Date: 12/24/2013 11:03:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter3].[AssociateSalary](
	[SalaryId] [int] IDENTITY(1,1) NOT NULL,
	[AssociateId] [int] NOT NULL,
	[Salary] [decimal](18, 2) NOT NULL,
	[SalaryDate] [datetime] NOT NULL,
 CONSTRAINT [PK_AssociateSalary] PRIMARY KEY CLUSTERED 
(
	[SalaryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter3].[Bid]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter3].[Bid](
	[BidId] [int] IDENTITY(1,1) NOT NULL,
	[JobId] [int] NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[Bidder] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Bid] PRIMARY KEY CLUSTERED 
(
	[BidId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter3].[BlogPost]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter3].[BlogPost](
	[PostId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[Description] [varchar](50) NOT NULL,
 CONSTRAINT [PK_BlogPost] PRIMARY KEY CLUSTERED 
(
	[PostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter3].[Book]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter3].[Book](
	[BookId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[CategoryId] [int] NULL,
 CONSTRAINT [PK_Book_2] PRIMARY KEY CLUSTERED 
(
	[BookId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter3].[Category]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter3].[Category](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
 CONSTRAINT [PK_Category_3] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter3].[Comment]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter3].[Comment](
	[CommentId] [int] IDENTITY(1,1) NOT NULL,
	[Comments] [varchar](8000) NOT NULL,
	[PostId] [int] NOT NULL,
 CONSTRAINT [PK_Comment] PRIMARY KEY CLUSTERED 
(
	[CommentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter3].[Customer]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter3].[Customer](
	[CustomerId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Customer_4] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter3].[Employee]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter3].[Employee](
	[EmployeeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[YearsWorked] [int] NULL,
 CONSTRAINT [PK_Employee_6] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter3].[Event]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter3].[Event](
	[EventId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[State] [varchar](2) NOT NULL,
	[City] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Event_3] PRIMARY KEY CLUSTERED 
(
	[EventId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter3].[Job]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter3].[Job](
	[JobId] [int] IDENTITY(1,1) NOT NULL,
	[JobDetails] [varchar](1024) NOT NULL,
 CONSTRAINT [PK_Job] PRIMARY KEY CLUSTERED 
(
	[JobId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter3].[Lawyer]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter3].[Lawyer](
	[PersonId] [int] NOT NULL,
	[Cases] [int] NOT NULL,
 CONSTRAINT [PK_Lawyer] PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter3].[Media]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter3].[Media](
	[MediaId] [int] IDENTITY(1,1) NOT NULL,
	[MediaType] [int] NOT NULL,
	[Title] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Media_1] PRIMARY KEY CLUSTERED 
(
	[MediaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter3].[Order]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter3].[Order](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[AccountId] [int] NOT NULL,
	[ShipCity] [varchar](50) NOT NULL,
	[ShipState] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Order_6] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter3].[Organization]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter3].[Organization](
	[OrganizationId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[City] [varchar](50) NOT NULL,
	[State] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Organization] PRIMARY KEY CLUSTERED 
(
	[OrganizationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter3].[Patient]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter3].[Patient](
	[PatientId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[City] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Patient_2] PRIMARY KEY CLUSTERED 
(
	[PatientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter3].[Patron]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter3].[Patron](
	[PatronId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[SponsorType] [int] NOT NULL,
 CONSTRAINT [PK_Patron] PRIMARY KEY CLUSTERED 
(
	[PatronId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter3].[Payment]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter3].[Payment](
	[PaymentId] [int] IDENTITY(1,1) NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[Vendor] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Payment] PRIMARY KEY CLUSTERED 
(
	[PaymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter3].[Person]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter3].[Person](
	[PersonId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Person_3] PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter3].[Product]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter3].[Product](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Product_5] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter3].[Registration]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter3].[Registration](
	[RegistrationId] [int] IDENTITY(1,1) NOT NULL,
	[StudentName] [varchar](50) NOT NULL,
	[RegistrationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Registration] PRIMARY KEY CLUSTERED 
(
	[RegistrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter3].[Student]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter3].[Student](
	[StudentId] [int] IDENTITY(1,1) NOT NULL,
	[Degree] [varchar](50) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Student_1] PRIMARY KEY CLUSTERED 
(
	[StudentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter3].[Teacher]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter3].[Teacher](
	[PersonId] [int] NOT NULL,
	[IsProfessor] [bit] NOT NULL,
 CONSTRAINT [PK_Teacher] PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter3].[TopSelling]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter3].[TopSelling](
	[ProductId] [int] NOT NULL,
	[Rating] [int] NOT NULL,
 CONSTRAINT [PK_TopSelling] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter3].[Worker]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter3].[Worker](
	[WorkerId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Worker_1] PRIMARY KEY CLUSTERED 
(
	[WorkerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter4].[Category]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter4].[Category](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Category_4] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter4].[Contact]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter4].[Contact](
	[ContactId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Email] [varchar](1024) NULL,
	[HireDate] [datetime] NULL,
	[ContactType] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Contact_1] PRIMARY KEY CLUSTERED 
(
	[ContactId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter4].[Customer]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter4].[Customer](
	[CustomerId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[City] [varchar](50) NOT NULL,
	[State] [varchar](2) NOT NULL,
 CONSTRAINT [PK_Customer_7] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter4].[Hotel]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter4].[Hotel](
	[HotelId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Hotel_2] PRIMARY KEY CLUSTERED 
(
	[HotelId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter4].[Item]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter4].[Item](
	[ItemId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[ItemCategoryId] [int] NOT NULL,
 CONSTRAINT [PK_Item_2] PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter4].[ItemCategory]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter4].[ItemCategory](
	[ItemCategoryId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_ItemCategory] PRIMARY KEY CLUSTERED 
(
	[ItemCategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter4].[Member]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter4].[Member](
	[MemberId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Email] [varchar](1024) NOT NULL,
 CONSTRAINT [PK_Member_4] PRIMARY KEY CLUSTERED 
(
	[MemberId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter4].[Movie]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter4].[Movie](
	[MovieId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[Director] [varchar](50) NOT NULL,
	[Budget] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Movie_1] PRIMARY KEY CLUSTERED 
(
	[MovieId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter4].[Order]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter4].[Order](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[CustomerId] [int] NOT NULL,
 CONSTRAINT [PK_Order_8] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter4].[OrderDetail]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter4].[OrderDetail](
	[OrderDetailId] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NOT NULL,
	[UnitPrice] [decimal](18, 2) NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_OrderDetail_1] PRIMARY KEY CLUSTERED 
(
	[OrderDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter4].[Product]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter4].[Product](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [varchar](50) NOT NULL,
	[ProductDescription] [varchar](255) NOT NULL,
	[SupplierId] [int] NOT NULL,
	[CategoryId] [int] NOT NULL,
	[ProductDetailid] [int] NOT NULL,
	[UnitsInStock] [int] NOT NULL,
	[Discontinued] [bit] NOT NULL,
 CONSTRAINT [PK_Product_7] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter4].[ProductDetail]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter4].[ProductDetail](
	[ProductId] [int] NOT NULL,
	[UnitPrice] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_ProductDetail] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter4].[PurchaseOrder]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter4].[PurchaseOrder](
	[OrderNumber] [int] IDENTITY(1,1) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[Company] [varchar](50) NOT NULL,
	[Amount] [decimal](18, 2) NULL,
 CONSTRAINT [PK_PurchaseOrder_1] PRIMARY KEY CLUSTERED 
(
	[OrderNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter4].[Reservation]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter4].[Reservation](
	[ReservationId] [int] IDENTITY(1,1) NOT NULL,
	[ReservationDate] [datetime] NOT NULL,
	[Rate] [decimal](18, 2) NOT NULL,
	[HotelId] [int] NOT NULL,
	[TimeStamp] [timestamp] NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Reservation_3] PRIMARY KEY CLUSTERED 
(
	[ReservationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter4].[Supplier]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter4].[Supplier](
	[SupplierId] [int] IDENTITY(1,1) NOT NULL,
	[CompanyName] [varchar](50) NOT NULL,
	[Country] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Supplier_1] PRIMARY KEY CLUSTERED 
(
	[SupplierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter4].[WebCustomer]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter4].[WebCustomer](
	[CustomerId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_WebCustomer_1] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter5].[Appointment]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter5].[Appointment](
	[AppointmentId] [int] IDENTITY(1,1) NOT NULL,
	[Date] [date] NOT NULL,
	[Reason] [varchar](50) NOT NULL,
	[Fee] [decimal](18, 2) NOT NULL,
	[DoctorId] [int] NOT NULL,
	[PatientId] [int] NOT NULL,
 CONSTRAINT [PK_Appointment] PRIMARY KEY CLUSTERED 
(
	[AppointmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter5].[Associate]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter5].[Associate](
	[AssociateId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[ReportsTo] [int] NULL,
 CONSTRAINT [PK_Associate] PRIMARY KEY CLUSTERED 
(
	[AssociateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter5].[Category]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter5].[Category](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[ReleaseType] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Category_1] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter5].[CEO]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter5].[CEO](
	[AssociateId] [int] NOT NULL,
 CONSTRAINT [PK_CEO] PRIMARY KEY CLUSTERED 
(
	[AssociateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter5].[Client]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter5].[Client](
	[ClientId] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Client_3] PRIMARY KEY CLUSTERED 
(
	[ClientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter5].[Club]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter5].[Club](
	[ClubId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[City] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Club] PRIMARY KEY CLUSTERED 
(
	[ClubId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter5].[Company]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter5].[Company](
	[CompanyId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED 
(
	[CompanyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter5].[Contractor]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter5].[Contractor](
	[ContracterID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[ProjectID] [int] NOT NULL,
 CONSTRAINT [PK_Contractor] PRIMARY KEY CLUSTERED 
(
	[ContracterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter5].[Course]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter5].[Course](
	[CourseId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED 
(
	[CourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter5].[Customer]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter5].[Customer](
	[CustomerId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[CustomerTypeId] [int] NOT NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter5].[CustomerEmail]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter5].[CustomerEmail](
	[CustomerEmailId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[Email] [varchar](1024) NOT NULL,
 CONSTRAINT [PK_CustomerEmail] PRIMARY KEY CLUSTERED 
(
	[CustomerEmailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter5].[CustomerType]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter5].[CustomerType](
	[CustomerTypeId] [int] NOT NULL,
	[Description] [varchar](50) NOT NULL,
 CONSTRAINT [PK_CustomerType] PRIMARY KEY CLUSTERED 
(
	[CustomerTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter5].[Department]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter5].[Department](
	[DepartmentId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[CompanyId] [int] NOT NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[DepartmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter5].[Doctor]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter5].[Doctor](
	[DoctorId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Doctor] PRIMARY KEY CLUSTERED 
(
	[DoctorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter5].[Employee]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter5].[Employee](
	[EmployeeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[DepartmentId] [int] NOT NULL,
 CONSTRAINT [PK_Employee_2] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter5].[Event]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter5].[Event](
	[EventId] [int] IDENTITY(1,1) NOT NULL,
	[EventName] [varchar](50) NOT NULL,
	[EventDate] [date] NOT NULL,
	[ClubId] [int] NOT NULL,
 CONSTRAINT [PK_Event_1] PRIMARY KEY CLUSTERED 
(
	[EventId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter5].[ExecutiveSuite]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter5].[ExecutiveSuite](
	[RoomId] [int] NOT NULL,
 CONSTRAINT [PK_ExecutiveSuite] PRIMARY KEY CLUSTERED 
(
	[RoomId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter5].[Foreman]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter5].[Foreman](
	[ForemanId] [int] IDENTITY(1,1) NOT NULL,
	[LocationId] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Foreman] PRIMARY KEY CLUSTERED 
(
	[ForemanId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter5].[Hotel]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter5].[Hotel](
	[HotelId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Hotel] PRIMARY KEY CLUSTERED 
(
	[HotelId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter5].[Instructor]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter5].[Instructor](
	[InstructorId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Instructor_1] PRIMARY KEY CLUSTERED 
(
	[InstructorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter5].[Invoice]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter5].[Invoice](
	[InvoiceId] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceDate] [datetime] NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[ClientId] [int] NOT NULL,
 CONSTRAINT [PK_Invocie] PRIMARY KEY CLUSTERED 
(
	[InvoiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter5].[JobSite]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter5].[JobSite](
	[LocationId] [int] NOT NULL,
	[JobSiteName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_JobSite] PRIMARY KEY CLUSTERED 
(
	[LocationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter5].[Location]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter5].[Location](
	[LocationId] [int] IDENTITY(1,1) NOT NULL,
	[Address] [varchar](50) NOT NULL,
	[City] [varchar](50) NOT NULL,
	[State] [varchar](2) NOT NULL,
	[ZIPCode] [varchar](10) NOT NULL,
	[PhoneId] [int] NOT NULL,
 CONSTRAINT [PK_Location_1] PRIMARY KEY CLUSTERED 
(
	[LocationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter5].[Manager]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter5].[Manager](
	[ManagerID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Manager] PRIMARY KEY CLUSTERED 
(
	[ManagerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter5].[Movie]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter5].[Movie](
	[MovieId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Rating] [varchar](5) NOT NULL,
	[CategoryId] [int] NOT NULL,
 CONSTRAINT [PK_Movie] PRIMARY KEY CLUSTERED 
(
	[MovieId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter5].[Order]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter5].[Order](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[CustomerName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Order_2] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter5].[OrderItem]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter5].[OrderItem](
	[OrderItemId] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NOT NULL,
	[SKU] [int] NOT NULL,
	[Shipped] [int] NOT NULL,
	[UnitPrice] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_OrderItem_1] PRIMARY KEY CLUSTERED 
(
	[OrderItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter5].[Patient]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter5].[Patient](
	[PatientId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Patient] PRIMARY KEY CLUSTERED 
(
	[PatientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter5].[Phone]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter5].[Phone](
	[PhoneId] [int] IDENTITY(1,1) NOT NULL,
	[Number] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Phone] PRIMARY KEY CLUSTERED 
(
	[PhoneId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter5].[Plumber]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter5].[Plumber](
	[TradesmanId] [int] NOT NULL,
	[IsCertified] [bit] NOT NULL,
	[LocationId] [int] NOT NULL,
 CONSTRAINT [PK_Plumber] PRIMARY KEY CLUSTERED 
(
	[TradesmanId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter5].[Project]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter5].[Project](
	[ProjectID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[ManagerID] [int] NOT NULL,
 CONSTRAINT [PK_Project] PRIMARY KEY CLUSTERED 
(
	[ProjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter5].[ProjectManager]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter5].[ProjectManager](
	[AssociateId] [int] NOT NULL,
 CONSTRAINT [PK_ProjectManager] PRIMARY KEY CLUSTERED 
(
	[AssociateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter5].[Reservation]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter5].[Reservation](
	[ReservationId] [int] IDENTITY(1,1) NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[ContactName] [varchar](50) NOT NULL,
	[RoomId] [int] NOT NULL,
 CONSTRAINT [PK_Reservation] PRIMARY KEY CLUSTERED 
(
	[ReservationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter5].[Room]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter5].[Room](
	[RoomId] [int] IDENTITY(1,1) NOT NULL,
	[Rate] [decimal](18, 2) NOT NULL,
	[HotelId] [int] NOT NULL,
 CONSTRAINT [PK_Room] PRIMARY KEY CLUSTERED 
(
	[RoomId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter5].[Section]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter5].[Section](
	[SectionId] [int] IDENTITY(1,1) NOT NULL,
	[InstructorId] [int] NOT NULL,
	[CourseId] [int] NOT NULL,
 CONSTRAINT [PK_Section] PRIMARY KEY CLUSTERED 
(
	[SectionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter5].[SectionStudent]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter5].[SectionStudent](
	[SectionId] [int] NOT NULL,
	[StudentId] [int] NOT NULL,
 CONSTRAINT [PK_SectionStudent] PRIMARY KEY CLUSTERED 
(
	[SectionId] ASC,
	[StudentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter5].[Student]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter5].[Student](
	[StudentId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[StudentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter5].[Supervisor]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter5].[Supervisor](
	[AssociateId] [int] NOT NULL,
 CONSTRAINT [PK_Supervisor] PRIMARY KEY CLUSTERED 
(
	[AssociateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter5].[Tradesman]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter5].[Tradesman](
	[TradesmanId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Email] [varchar](1024) NULL,
 CONSTRAINT [PK_Tradesman] PRIMARY KEY CLUSTERED 
(
	[TradesmanId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter6].[BMW]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter6].[BMW](
	[CarId] [int] IDENTITY(1,2) NOT NULL,
	[Model] [varchar](50) NOT NULL,
	[Year] [varchar](4) NOT NULL,
	[Color] [varchar](50) NOT NULL,
	[CollisionAvoidance] [bit] NOT NULL,
 CONSTRAINT [PK_BMW_1] PRIMARY KEY CLUSTERED 
(
	[CarId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter6].[CarDealer]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter6].[CarDealer](
	[CarId] [int] NOT NULL,
	[DealerId] [int] NOT NULL,
 CONSTRAINT [PK_CarDealer_1] PRIMARY KEY CLUSTERED 
(
	[CarId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter6].[Category]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter6].[Category](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[ParentCategoryId] [int] NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter6].[Dealer]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter6].[Dealer](
	[DealerId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Dealer_1] PRIMARY KEY CLUSTERED 
(
	[DealerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter6].[Drug]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter6].[Drug](
	[DrugId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[TargetPrice] [decimal](18, 2) NULL,
	[PrincipalResearcher] [varchar](50) NULL,
	[AcceptedDate] [datetime] NULL,
 CONSTRAINT [PK_Drug] PRIMARY KEY CLUSTERED 
(
	[DrugId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter6].[Employee]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter6].[Employee](
	[EmployeeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Rate] [decimal](18, 2) NULL,
	[Hours] [int] NULL,
	[Salary] [decimal](18, 2) NULL,
	[Commission] [decimal](18, 2) NULL,
	[EmployeeType] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Employee_1] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter6].[Event]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter6].[Event](
	[EventId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Event] PRIMARY KEY CLUSTERED 
(
	[EventId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter6].[EventOrganizer]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter6].[EventOrganizer](
	[EventId] [int] NOT NULL,
	[OrganizerId] [int] NOT NULL,
 CONSTRAINT [PK_EventOrganizer] PRIMARY KEY CLUSTERED 
(
	[EventId] ASC,
	[OrganizerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter6].[Instructor]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter6].[Instructor](
	[InstructorId] [int] IDENTITY(1,1) NOT NULL,
	[Salary] [decimal](18, 2) NOT NULL,
	[StaffId] [int] NOT NULL,
 CONSTRAINT [PK_Instructor] PRIMARY KEY CLUSTERED 
(
	[InstructorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter6].[Invoice]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter6].[Invoice](
	[InvoiceId] [int] IDENTITY(1,1) NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[Description] [varchar](255) NOT NULL,
	[Date] [datetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Invoice_3] PRIMARY KEY CLUSTERED 
(
	[InvoiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter6].[Lookup]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter6].[Lookup](
	[LookupId] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Value] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Lookup] PRIMARY KEY CLUSTERED 
(
	[LookupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter6].[Member]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter6].[Member](
	[MemberId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Phone] [varchar](20) NOT NULL,
	[Age] [int] NOT NULL,
 CONSTRAINT [PK_Member] PRIMARY KEY CLUSTERED 
(
	[MemberId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter6].[Order]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter6].[Order](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[OrderStatusId] [int] NOT NULL,
	[TransactionTypeId] [int] NOT NULL,
	[ShippingTypeId] [int] NOT NULL,
 CONSTRAINT [PK_Order_1] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter6].[Organizer]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter6].[Organizer](
	[OrganizerId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Organizer] PRIMARY KEY CLUSTERED 
(
	[OrganizerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter6].[Person]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter6].[Person](
	[PersonId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[FireStation] [varchar](50) NULL,
	[School] [varchar](50) NULL,
	[FullTimeHobby] [varchar](50) NULL,
	[Role] [char](1) NULL,
	[HeroId] [int] NULL,
 CONSTRAINT [PK_Person_1] PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter6].[Principal]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter6].[Principal](
	[PrincipalId] [int] IDENTITY(1,1) NOT NULL,
	[Salary] [decimal](18, 2) NOT NULL,
	[Bonus] [decimal](18, 2) NOT NULL,
	[StaffId] [int] NOT NULL,
 CONSTRAINT [PK_Principal] PRIMARY KEY CLUSTERED 
(
	[PrincipalId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter6].[Product]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter6].[Product](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Product_1] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter6].[RefurbishedToy]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter6].[RefurbishedToy](
	[ToyId] [int] NOT NULL,
	[Quality] [varchar](50) NOT NULL,
 CONSTRAINT [PK_RefurbishedToy] PRIMARY KEY CLUSTERED 
(
	[ToyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter6].[RelatedProduct]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter6].[RelatedProduct](
	[ProductId] [int] NOT NULL,
	[RelatedProductId] [int] NOT NULL,
 CONSTRAINT [PK_RelatedProduct] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC,
	[RelatedProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter6].[Staff]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter6].[Staff](
	[StaffId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Staff] PRIMARY KEY CLUSTERED 
(
	[StaffId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter6].[Task]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter6].[Task](
	[TaskId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Task] PRIMARY KEY CLUSTERED 
(
	[TaskId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter6].[Ticket]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter6].[Ticket](
	[TicketId] [int] IDENTITY(1,1) NOT NULL,
	[IssueDate] [datetime] NOT NULL,
	[Violation] [varchar](255) NOT NULL,
	[LicenseNumber] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Ticket_1] PRIMARY KEY CLUSTERED 
(
	[TicketId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter6].[Toy]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter6].[Toy](
	[ToyId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Price] [decimal](18, 2) NULL,
	[ForDonationOnly] [int] NOT NULL,
 CONSTRAINT [PK_Toy] PRIMARY KEY CLUSTERED 
(
	[ToyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter6].[Toyota]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter6].[Toyota](
	[CarId] [int] IDENTITY(2,2) NOT NULL,
	[Model] [varchar](50) NOT NULL,
	[Year] [varchar](4) NOT NULL,
	[Color] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Toyota_1] PRIMARY KEY CLUSTERED 
(
	[CarId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter6].[Vehicle]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter6].[Vehicle](
	[LicenseNumber] [varchar](50) NOT NULL,
	[Model] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Vehicle_2] PRIMARY KEY CLUSTERED 
(
	[LicenseNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter6].[WebOrder]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter6].[WebOrder](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerName] [varchar](50) NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_WebOrder] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter6].[Worker]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter6].[Worker](
	[WorkerId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Worker] PRIMARY KEY CLUSTERED 
(
	[WorkerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter6].[WorkerTask]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter6].[WorkerTask](
	[WorkerId] [int] NOT NULL,
	[TaskId] [int] NOT NULL,
 CONSTRAINT [PK_WorkerTask] PRIMARY KEY CLUSTERED 
(
	[WorkerId] ASC,
	[TaskId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter7].[Customer]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter7].[Customer](
	[CustomerId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Customer_9] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter7].[Definitions]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter7].[Definitions](
	[Id] [int] NOT NULL,
	[SSDL] [xml] NOT NULL,
	[CSDL] [xml] NOT NULL,
	[MSL] [xml] NOT NULL,
 CONSTRAINT [PK_Definitions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [Chapter7].[Employee]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter7].[Employee](
	[EmployeeNumber] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Salary] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Employee_11] PRIMARY KEY CLUSTERED 
(
	[EmployeeNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter7].[Employees]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter7].[Employees](
	[EmployeeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Employee_10] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter7].[Invoice]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter7].[Invoice](
	[InvoiceNumber] [int] IDENTITY(1,1) NOT NULL,
	[BilledTo] [varchar](50) NOT NULL,
	[InvoiceDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Invoice_4] PRIMARY KEY CLUSTERED 
(
	[InvoiceNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter7].[LineItem]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter7].[LineItem](
	[InvoiceNumber] [int] NOT NULL,
	[ItemNumber] [int] IDENTITY(1,1) NOT NULL,
	[Cost] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_LineItem] PRIMARY KEY CLUSTERED 
(
	[InvoiceNumber] ASC,
	[ItemNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter7].[Product]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter7].[Product](
	[SKU] [varchar](50) NOT NULL,
	[ShortDesription] [varchar](1024) NOT NULL,
	[Description] [varchar](8000) NOT NULL,
	[UnitPrice] [decimal](18, 2) NOT NULL,
	[StockCount] [int] NOT NULL,
 CONSTRAINT [PK_Product_9] PRIMARY KEY CLUSTERED 
(
	[SKU] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter7].[ServiceCall]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter7].[ServiceCall](
	[CallId] [int] IDENTITY(1,1) NOT NULL,
	[ContactName] [varchar](50) NOT NULL,
	[Issue] [varchar](1024) NOT NULL,
	[TechId] [int] NOT NULL,
 CONSTRAINT [PK_ServiceCall] PRIMARY KEY CLUSTERED 
(
	[CallId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter7].[Task]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter7].[Task](
	[TaskId] [int] IDENTITY(1,1) NOT NULL,
	[AssignedId] [int] NOT NULL,
	[Description] [varchar](255) NOT NULL,
 CONSTRAINT [PK_Task_2] PRIMARY KEY CLUSTERED 
(
	[TaskId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter7].[Tasks]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter7].[Tasks](
	[TaskId] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](1024) NOT NULL,
	[EmployeeId] [int] NOT NULL,
 CONSTRAINT [PK_Task_1] PRIMARY KEY CLUSTERED 
(
	[TaskId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter7].[Technician]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter7].[Technician](
	[TechId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Technician] PRIMARY KEY CLUSTERED 
(
	[TechId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter8].[Book]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter8].[Book](
	[BookId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[PublishDate] [datetime] NOT NULL,
	[Author] [varchar](50) NOT NULL,
	[CategoryId] [int] NOT NULL,
 CONSTRAINT [PK_Book_3] PRIMARY KEY CLUSTERED 
(
	[BookId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter8].[Category]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter8].[Category](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Category_5] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter8].[Competitor]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter8].[Competitor](
	[CompetitorId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[EventId] [int] NOT NULL,
 CONSTRAINT [PK_Competitor] PRIMARY KEY CLUSTERED 
(
	[CompetitorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter8].[Customer]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter8].[Customer](
	[CustomerId] [int] IDENTITY(1,1) NOT NULL,
	[ContactName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Customer_5] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter8].[Donation]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter8].[Donation](
	[DonationId] [int] IDENTITY(1,1) NOT NULL,
	[DonorId] [int] NULL,
	[Amount] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Donation_1] PRIMARY KEY CLUSTERED 
(
	[DonationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter8].[Donor]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter8].[Donor](
	[DonorId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Donor] PRIMARY KEY CLUSTERED 
(
	[DonorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter8].[Employee]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter8].[Employee](
	[EmployeeId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[Email] [varchar](1024) NOT NULL,
 CONSTRAINT [PK_Employee_8] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter8].[Event]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter8].[Event](
	[EventId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[VenueId] [int] NOT NULL,
 CONSTRAINT [PK_Event_4] PRIMARY KEY CLUSTERED 
(
	[EventId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter8].[Item]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter8].[Item](
	[ItemId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[UnitPrice] [decimal](18, 2) NULL,
 CONSTRAINT [PK_Item_1] PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter8].[Order]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter8].[Order](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[OrderDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Order_7] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter8].[OrderDetail]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter8].[OrderDetail](
	[OrderId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[UnitPrice] [decimal](18, 2) NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC,
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter8].[Product]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter8].[Product](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [varchar](50) NOT NULL,
	[UnitPrice] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Product_6] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter8].[Reservation]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter8].[Reservation](
	[ReservationId] [int] NOT NULL,
	[ScheduleId] [int] NOT NULL,
	[Passenger] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Reservation_4] PRIMARY KEY CLUSTERED 
(
	[ReservationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter8].[Schedule]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter8].[Schedule](
	[ScheduleId] [int] NOT NULL,
	[TrainId] [int] NOT NULL,
	[ArrivalDate] [datetime] NOT NULL,
	[DepartureDate] [datetime] NOT NULL,
	[LeavesFrom] [varchar](50) NOT NULL,
	[ArrivesAt] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Schedule] PRIMARY KEY CLUSTERED 
(
	[ScheduleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter8].[Speaker]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter8].[Speaker](
	[SpeakerId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Speaker] PRIMARY KEY CLUSTERED 
(
	[SpeakerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter8].[SpeakerTalk]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter8].[SpeakerTalk](
	[SpeakerId] [int] NOT NULL,
	[TalkId] [int] NOT NULL,
 CONSTRAINT [PK_SpeakerTalk] PRIMARY KEY CLUSTERED 
(
	[SpeakerId] ASC,
	[TalkId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter8].[Talk]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter8].[Talk](
	[TalkId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[CreateDate] [datetime] NULL,
	[RevisedDate] [datetime] NULL,
 CONSTRAINT [PK_Talk] PRIMARY KEY CLUSTERED 
(
	[TalkId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter8].[Ticket]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Chapter8].[Ticket](
	[TicketId] [int] IDENTITY(1,1) NOT NULL,
	[VehicleId] [int] NOT NULL,
	[IssueDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Ticket] PRIMARY KEY CLUSTERED 
(
	[TicketId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Chapter8].[Train]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter8].[Train](
	[TrainId] [int] NOT NULL,
	[TrainName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Train] PRIMARY KEY CLUSTERED 
(
	[TrainId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter8].[Vehicle]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter8].[Vehicle](
	[VehicleId] [int] IDENTITY(1,1) NOT NULL,
	[LicenseNo] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Vehicle_1] PRIMARY KEY CLUSTERED 
(
	[VehicleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter8].[Venue]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter8].[Venue](
	[VenueId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Venue] PRIMARY KEY CLUSTERED 
(
	[VenueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Chapter8].[Violation]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Chapter8].[Violation](
	[ViolationId] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](255) NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[TicketId] [int] NOT NULL,
 CONSTRAINT [PK_Violation] PRIMARY KEY CLUSTERED 
(
	[ViolationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [chapter9].[Booking]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [chapter9].[Booking](
	[BookingId] [int] IDENTITY(1,1) NOT NULL,
	[AgentId] [int] NOT NULL,
	[Customer] [varchar](50) NOT NULL,
	[BookingDate] [datetime] NOT NULL,
	[Paid] [bit] NOT NULL,
 CONSTRAINT [PK_Booking] PRIMARY KEY CLUSTERED 
(
	[BookingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [chapter9].[Category]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [chapter9].[Category](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Category_6] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [chapter9].[Client]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [chapter9].[Client](
	[ClientId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Email] [varchar](1024) NOT NULL,
 CONSTRAINT [PK_Client_2] PRIMARY KEY CLUSTERED 
(
	[ClientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [chapter9].[Comment]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [chapter9].[Comment](
	[CommentId] [int] IDENTITY(1,1) NOT NULL,
	[PostId] [int] NOT NULL,
	[CommentText] [varchar](1024) NOT NULL,
 CONSTRAINT [PK_Comment_1] PRIMARY KEY CLUSTERED 
(
	[CommentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [chapter9].[Course]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [chapter9].[Course](
	[CourseId] [int] NOT NULL,
	[Title] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Course_2] PRIMARY KEY CLUSTERED 
(
	[CourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [chapter9].[Customer]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [chapter9].[Customer](
	[CustomerId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Company] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Customer_8] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [chapter9].[Enrollment]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [chapter9].[Enrollment](
	[EnrollmentId] [int] IDENTITY(1,1) NOT NULL,
	[StudentId] [int] NOT NULL,
	[CourseId] [int] NOT NULL,
	[Paid] [bit] NOT NULL,
 CONSTRAINT [PK_Enrollment_1] PRIMARY KEY CLUSTERED 
(
	[EnrollmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [chapter9].[Invoice]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [chapter9].[Invoice](
	[InvoiceId] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Invoice_2] PRIMARY KEY CLUSTERED 
(
	[InvoiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [chapter9].[Job]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [chapter9].[Job](
	[JobId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[Salary] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Job_1] PRIMARY KEY CLUSTERED 
(
	[JobId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [chapter9].[Media]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [chapter9].[Media](
	[MediaId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[MediaTypeId] [int] NOT NULL,
 CONSTRAINT [PK_Media_2] PRIMARY KEY CLUSTERED 
(
	[MediaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [chapter9].[MediaCategory]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [chapter9].[MediaCategory](
	[CategoryId] [int] NOT NULL,
	[MediaId] [int] NOT NULL,
 CONSTRAINT [PK_MediaCategory] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC,
	[MediaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [chapter9].[MediaType]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [chapter9].[MediaType](
	[MediaTypeId] [int] NOT NULL,
	[Description] [varchar](50) NOT NULL,
 CONSTRAINT [PK_MediaType] PRIMARY KEY CLUSTERED 
(
	[MediaTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [chapter9].[Order]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [chapter9].[Order](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[Product] [varchar](50) NOT NULL,
	[Quantity] [int] NOT NULL,
	[Status] [varchar](50) NOT NULL,
	[TimeStamp] [timestamp] NOT NULL,
 CONSTRAINT [PK_Order_9] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [chapter9].[Payment]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [chapter9].[Payment](
	[PaymentId] [int] IDENTITY(1,1) NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[TimeStamp] [timestamp] NOT NULL,
	[InvoiceId] [int] NOT NULL,
 CONSTRAINT [PK_Payment_2] PRIMARY KEY CLUSTERED 
(
	[PaymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [chapter9].[Phone]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [chapter9].[Phone](
	[PhoneId] [int] IDENTITY(1,1) NOT NULL,
	[Number] [varchar](50) NOT NULL,
	[PhoneType] [varchar](50) NOT NULL,
	[CustomerId] [int] NOT NULL,
 CONSTRAINT [PK_Phone_1] PRIMARY KEY CLUSTERED 
(
	[PhoneId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [chapter9].[Post]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [chapter9].[Post](
	[PostId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Post] PRIMARY KEY CLUSTERED 
(
	[PostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [chapter9].[Project]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [chapter9].[Project](
	[ProjectId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[AmountAllocated] [decimal](18, 2) NOT NULL,
	[PercentComplete] [int] NOT NULL,
	[TimeStamp] [timestamp] NOT NULL,
 CONSTRAINT [PK_Project_2] PRIMARY KEY CLUSTERED 
(
	[ProjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [chapter9].[Student]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [chapter9].[Student](
	[StudentId] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Student_2] PRIMARY KEY CLUSTERED 
(
	[StudentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [chapter9].[TravelAgent]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [chapter9].[TravelAgent](
	[AgentId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TravelAgent] PRIMARY KEY CLUSTERED 
(
	[AgentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [Chapter15].[vwAuthorBook]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [Chapter15].[vwAuthorBook]
as 
select BookId, AuthorId from Chapter15.AuthorBook

GO
/****** Object:  View [Chapter15].[vwCustomer]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [Chapter15].[vwCustomer]
as
select c.*,c.FirstName + ' ' + c.LastName as FullName,
(select COUNT(*) from Chapter15.[Order] where CustomerId = c.CustomerId) TotalOrders
from chapter15.Customer c

GO
/****** Object:  View [Chapter15].[vwOrder]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [Chapter15].[vwOrder]
as
select o.*,os.Description OrderStatus,s.Description ShippingType
from chapter15.[Order] o
join chapter15.OrderStatusType os on os.OrderStatusTypeId = o.OrderStatusTypeId
join chapter15.ShippingType s on s.ShippingTypeId = o.OrderStatusTypeId

GO
/****** Object:  View [Chapter15].[vwResidence]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [Chapter15].[vwResidence]
as
select r.AddressId,r.[Address],r.City,r.[State],r.Zip,r.PersonId FriendId,null RelativeId
from chapter15.Residence as r
where r.PersonType = 'Friend'
union
select r.AddressId,r.[Address],r.City,r.[State],r.Zip,null FriendId,r.PersonId RelativeId
from chapter15.Residence as r
where r.PersonType = 'Relative'

GO
/****** Object:  View [Chapter2].[vwLibrary]    Script Date: 12/24/2013 11:03:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Chapter2].[vwLibrary]
AS
SELECT     Chapter2.Poet.FirstName, Chapter2.Poet.MiddleName, Chapter2.Poet.LastName, Chapter2.Poem.Title, Chapter2.Meter.MeterName
FROM         Chapter2.Meter INNER JOIN
                      Chapter2.Poem ON Chapter2.Meter.MeterID = Chapter2.Poem.MeterID INNER JOIN
                      Chapter2.Poet ON Chapter2.Poem.PoetID = Chapter2.Poet.PoetID

GO
SET IDENTITY_INSERT [Chapter13].[Associate] ON 

INSERT [Chapter13].[Associate] ([AssociateId], [Name], [City]) VALUES (2012, N'Robert Stevens', N'Raytown')
INSERT [Chapter13].[Associate] ([AssociateId], [Name], [City]) VALUES (2013, N'Karen Thorp', N'Gladstone')
SET IDENTITY_INSERT [Chapter13].[Associate] OFF
SET IDENTITY_INSERT [Chapter13].[Paycheck] ON 

INSERT [Chapter13].[Paycheck] ([PayCheckId], [AssociateId], [PayDate], [Gross]) VALUES (2022, 2012, CAST(0x00009D2C00000000 AS DateTime), CAST(1802.83 AS Decimal(18, 2)))
INSERT [Chapter13].[Paycheck] ([PayCheckId], [AssociateId], [PayDate], [Gross]) VALUES (2023, 2012, CAST(0x00009D3A00000000 AS DateTime), CAST(1924.91 AS Decimal(18, 2)))
INSERT [Chapter13].[Paycheck] ([PayCheckId], [AssociateId], [PayDate], [Gross]) VALUES (2024, 2013, CAST(0x00009D2C00000000 AS DateTime), CAST(2102.34 AS Decimal(18, 2)))
INSERT [Chapter13].[Paycheck] ([PayCheckId], [AssociateId], [PayDate], [Gross]) VALUES (2025, 2013, CAST(0x00009D3A00000000 AS DateTime), CAST(1992.18 AS Decimal(18, 2)))
SET IDENTITY_INSERT [Chapter13].[Paycheck] OFF
SET IDENTITY_INSERT [Chapter3].[Accident] ON 

INSERT [Chapter3].[Accident] ([AccidentId], [Description], [Severity], [WorkerId]) VALUES (51, N'Cuts and contusions', 3, 31)
INSERT [Chapter3].[Accident] ([AccidentId], [Description], [Severity], [WorkerId]) VALUES (52, N'Broken foot', 4, 31)
INSERT [Chapter3].[Accident] ([AccidentId], [Description], [Severity], [WorkerId]) VALUES (53, N'Fall, no injuries', 1, 32)
INSERT [Chapter3].[Accident] ([AccidentId], [Description], [Severity], [WorkerId]) VALUES (54, N'Minor burn', 3, 32)
INSERT [Chapter3].[Accident] ([AccidentId], [Description], [Severity], [WorkerId]) VALUES (55, N'Back strain', 2, 33)
SET IDENTITY_INSERT [Chapter3].[Accident] OFF
SET IDENTITY_INSERT [Chapter3].[Associate] ON 

INSERT [Chapter3].[Associate] ([AssociateId], [Name]) VALUES (1, N'Janis Roberts')
INSERT [Chapter3].[Associate] ([AssociateId], [Name]) VALUES (2, N'Kevin Hodges')
INSERT [Chapter3].[Associate] ([AssociateId], [Name]) VALUES (3, N'Bill Jordan')
SET IDENTITY_INSERT [Chapter3].[Associate] OFF
SET IDENTITY_INSERT [Chapter3].[AssociateSalary] ON 

INSERT [Chapter3].[AssociateSalary] ([SalaryId], [AssociateId], [Salary], [SalaryDate]) VALUES (1, 1, CAST(39500.00 AS Decimal(18, 2)), CAST(0x00009C5B00000000 AS DateTime))
INSERT [Chapter3].[AssociateSalary] ([SalaryId], [AssociateId], [Salary], [SalaryDate]) VALUES (2, 2, CAST(41900.00 AS Decimal(18, 2)), CAST(0x00009D1400000000 AS DateTime))
INSERT [Chapter3].[AssociateSalary] ([SalaryId], [AssociateId], [Salary], [SalaryDate]) VALUES (3, 3, CAST(33500.00 AS Decimal(18, 2)), CAST(0x00009C9C00000000 AS DateTime))
SET IDENTITY_INSERT [Chapter3].[AssociateSalary] OFF
SET IDENTITY_INSERT [Chapter3].[Worker] ON 

INSERT [Chapter3].[Worker] ([WorkerId], [Name]) VALUES (31, N'John Kearney')
INSERT [Chapter3].[Worker] ([WorkerId], [Name]) VALUES (32, N'Nancy Roberts')
INSERT [Chapter3].[Worker] ([WorkerId], [Name]) VALUES (33, N'Karla Gibbons')
SET IDENTITY_INSERT [Chapter3].[Worker] OFF
SET IDENTITY_INSERT [Chapter5].[Appointment] ON 

INSERT [Chapter5].[Appointment] ([AppointmentId], [Date], [Reason], [Fee], [DoctorId], [PatientId]) VALUES (75, CAST(0x32370B00 AS Date), N'Checkup', CAST(109.92 AS Decimal(18, 2)), 54, 75)
INSERT [Chapter5].[Appointment] ([AppointmentId], [Date], [Reason], [Fee], [DoctorId], [PatientId]) VALUES (76, CAST(0x32370B00 AS Date), N'Arm Pain', CAST(129.87 AS Decimal(18, 2)), 55, 76)
INSERT [Chapter5].[Appointment] ([AppointmentId], [Date], [Reason], [Fee], [DoctorId], [PatientId]) VALUES (77, CAST(0x32370B00 AS Date), N'Back Pain', CAST(99.23 AS Decimal(18, 2)), 54, 77)
SET IDENTITY_INSERT [Chapter5].[Appointment] OFF
SET IDENTITY_INSERT [Chapter5].[Associate] ON 

INSERT [Chapter5].[Associate] ([AssociateId], [Name], [ReportsTo]) VALUES (35, N'Joan Miller', NULL)
INSERT [Chapter5].[Associate] ([AssociateId], [Name], [ReportsTo]) VALUES (36, N'Bill Mayer', 35)
INSERT [Chapter5].[Associate] ([AssociateId], [Name], [ReportsTo]) VALUES (37, N'Jill Williams', 36)
SET IDENTITY_INSERT [Chapter5].[Associate] OFF
SET IDENTITY_INSERT [Chapter5].[Category] ON 

INSERT [Chapter5].[Category] ([CategoryId], [Name], [ReleaseType]) VALUES (33, N'Science Fiction', N'DVD')
INSERT [Chapter5].[Category] ([CategoryId], [Name], [ReleaseType]) VALUES (34, N'Thriller', N'Blu-Ray')
SET IDENTITY_INSERT [Chapter5].[Category] OFF
INSERT [Chapter5].[CEO] ([AssociateId]) VALUES (35)
INSERT [Chapter5].[Client] ([ClientId], [Name]) VALUES (1, N'Karen Standfield')
INSERT [Chapter5].[Client] ([ClientId], [Name]) VALUES (2, N'Phil Marlowe')
SET IDENTITY_INSERT [Chapter5].[Club] ON 

INSERT [Chapter5].[Club] ([ClubId], [Name], [City]) VALUES (199, N'Star City Chess Club', N'New York')
SET IDENTITY_INSERT [Chapter5].[Club] OFF
SET IDENTITY_INSERT [Chapter5].[Company] ON 

INSERT [Chapter5].[Company] ([CompanyId], [Name]) VALUES (30, N'Acme Products')
SET IDENTITY_INSERT [Chapter5].[Company] OFF
SET IDENTITY_INSERT [Chapter5].[Course] ON 

INSERT [Chapter5].[Course] ([CourseId], [Title]) VALUES (22, N'Biology 101')
SET IDENTITY_INSERT [Chapter5].[Course] OFF
SET IDENTITY_INSERT [Chapter5].[Customer] ON 

INSERT [Chapter5].[Customer] ([CustomerId], [Name], [CustomerTypeId]) VALUES (45, N'Joan Smith', 1)
INSERT [Chapter5].[Customer] ([CustomerId], [Name], [CustomerTypeId]) VALUES (46, N'Bill Meyers', 2)
SET IDENTITY_INSERT [Chapter5].[Customer] OFF
SET IDENTITY_INSERT [Chapter5].[CustomerEmail] ON 

INSERT [Chapter5].[CustomerEmail] ([CustomerEmailId], [CustomerId], [Email]) VALUES (67, 45, N'jsmith@gmail.com')
INSERT [Chapter5].[CustomerEmail] ([CustomerEmailId], [CustomerId], [Email]) VALUES (68, 45, N'joan@smith.com')
INSERT [Chapter5].[CustomerEmail] ([CustomerEmailId], [CustomerId], [Email]) VALUES (69, 46, N'bmeyers@gmail.com')
SET IDENTITY_INSERT [Chapter5].[CustomerEmail] OFF
INSERT [Chapter5].[CustomerType] ([CustomerTypeId], [Description]) VALUES (1, N'Web Customer')
INSERT [Chapter5].[CustomerType] ([CustomerTypeId], [Description]) VALUES (2, N'Retail Customer')
SET IDENTITY_INSERT [Chapter5].[Department] ON 

INSERT [Chapter5].[Department] ([DepartmentId], [Name], [CompanyId]) VALUES (59, N'Accounting', 30)
INSERT [Chapter5].[Department] ([DepartmentId], [Name], [CompanyId]) VALUES (60, N'Shipping', 30)
SET IDENTITY_INSERT [Chapter5].[Department] OFF
SET IDENTITY_INSERT [Chapter5].[Doctor] ON 

INSERT [Chapter5].[Doctor] ([DoctorId], [Name]) VALUES (54, N'Joan Meyers')
INSERT [Chapter5].[Doctor] ([DoctorId], [Name]) VALUES (55, N'Steven Mills')
SET IDENTITY_INSERT [Chapter5].[Doctor] OFF
SET IDENTITY_INSERT [Chapter5].[Employee] ON 

INSERT [Chapter5].[Employee] ([EmployeeId], [Name], [DepartmentId]) VALUES (59, N'Jill Carpenter', 59)
INSERT [Chapter5].[Employee] ([EmployeeId], [Name], [DepartmentId]) VALUES (60, N'Steven Hill', 60)
SET IDENTITY_INSERT [Chapter5].[Employee] OFF
SET IDENTITY_INSERT [Chapter5].[Event] ON 

INSERT [Chapter5].[Event] ([EventId], [EventName], [EventDate], [ClubId]) VALUES (173, N'Mid Cities Tournament', CAST(0x54320B00 AS Date), 199)
INSERT [Chapter5].[Event] ([EventId], [EventName], [EventDate], [ClubId]) VALUES (174, N'State Finals Tournament', CAST(0x76320B00 AS Date), 199)
INSERT [Chapter5].[Event] ([EventId], [EventName], [EventDate], [ClubId]) VALUES (175, N'Winter Classic', CAST(0x3E320B00 AS Date), 199)
SET IDENTITY_INSERT [Chapter5].[Event] OFF
INSERT [Chapter5].[ExecutiveSuite] ([RoomId]) VALUES (47)
INSERT [Chapter5].[ExecutiveSuite] ([RoomId]) VALUES (48)
SET IDENTITY_INSERT [Chapter5].[Foreman] ON 

INSERT [Chapter5].[Foreman] ([ForemanId], [LocationId], [Name]) VALUES (13, 7, N'Carl Ramsey')
INSERT [Chapter5].[Foreman] ([ForemanId], [LocationId], [Name]) VALUES (14, 7, N'Nancy Ortega')
SET IDENTITY_INSERT [Chapter5].[Foreman] OFF
SET IDENTITY_INSERT [Chapter5].[Hotel] ON 

INSERT [Chapter5].[Hotel] ([HotelId], [Name]) VALUES (26, N'Grand Seasons Hotel')
SET IDENTITY_INSERT [Chapter5].[Hotel] OFF
SET IDENTITY_INSERT [Chapter5].[Instructor] ON 

INSERT [Chapter5].[Instructor] ([InstructorId], [Name]) VALUES (23, N'Fred Jones')
INSERT [Chapter5].[Instructor] ([InstructorId], [Name]) VALUES (24, N'Julia Canfield')
SET IDENTITY_INSERT [Chapter5].[Instructor] OFF
SET IDENTITY_INSERT [Chapter5].[Invoice] ON 

INSERT [Chapter5].[Invoice] ([InvoiceId], [InvoiceDate], [Amount], [ClientId]) VALUES (15, CAST(0x00009D4D00000000 AS DateTime), CAST(102.95 AS Decimal(18, 2)), 2)
INSERT [Chapter5].[Invoice] ([InvoiceId], [InvoiceDate], [Amount], [ClientId]) VALUES (16, CAST(0x00009D4B00000000 AS DateTime), CAST(29.95 AS Decimal(18, 2)), 1)
INSERT [Chapter5].[Invoice] ([InvoiceId], [InvoiceDate], [Amount], [ClientId]) VALUES (17, CAST(0x00009D4C00000000 AS DateTime), CAST(49.95 AS Decimal(18, 2)), 1)
INSERT [Chapter5].[Invoice] ([InvoiceId], [InvoiceDate], [Amount], [ClientId]) VALUES (18, CAST(0x00009D4E00000000 AS DateTime), CAST(45.99 AS Decimal(18, 2)), 1)
SET IDENTITY_INSERT [Chapter5].[Invoice] OFF
INSERT [Chapter5].[JobSite] ([LocationId], [JobSiteName]) VALUES (7, N'City Arena')
SET IDENTITY_INSERT [Chapter5].[Location] ON 

INSERT [Chapter5].[Location] ([LocationId], [Address], [City], [State], [ZIPCode], [PhoneId]) VALUES (7, N'123 Main', N'Anytown', N'TX', N'76082', 7)
SET IDENTITY_INSERT [Chapter5].[Location] OFF
SET IDENTITY_INSERT [Chapter5].[Manager] ON 

INSERT [Chapter5].[Manager] ([ManagerID], [Name]) VALUES (7, N'Jill Stevens')
SET IDENTITY_INSERT [Chapter5].[Manager] OFF
SET IDENTITY_INSERT [Chapter5].[Movie] ON 

INSERT [Chapter5].[Movie] ([MovieId], [Name], [Rating], [CategoryId]) VALUES (61, N'Return to the Moon', N'PG-13', 33)
INSERT [Chapter5].[Movie] ([MovieId], [Name], [Rating], [CategoryId]) VALUES (62, N'Street Smarts', N'PG-13', 34)
INSERT [Chapter5].[Movie] ([MovieId], [Name], [Rating], [CategoryId]) VALUES (63, N'Alien Revenge', N'R', 33)
INSERT [Chapter5].[Movie] ([MovieId], [Name], [Rating], [CategoryId]) VALUES (64, N'Saturday Nights', N'PG-13', 33)
SET IDENTITY_INSERT [Chapter5].[Movie] OFF
SET IDENTITY_INSERT [Chapter5].[Order] ON 

INSERT [Chapter5].[Order] ([OrderId], [OrderDate], [CustomerName]) VALUES (7, CAST(0x00009D3700000000 AS DateTime), N'Jenny Craig')
SET IDENTITY_INSERT [Chapter5].[Order] OFF
SET IDENTITY_INSERT [Chapter5].[OrderItem] ON 

INSERT [Chapter5].[OrderItem] ([OrderItemId], [OrderId], [SKU], [Shipped], [UnitPrice]) VALUES (13, 7, 2827, 3, CAST(12.95 AS Decimal(18, 2)))
INSERT [Chapter5].[OrderItem] ([OrderItemId], [OrderId], [SKU], [Shipped], [UnitPrice]) VALUES (14, 7, 1918, 1, CAST(19.95 AS Decimal(18, 2)))
INSERT [Chapter5].[OrderItem] ([OrderItemId], [OrderId], [SKU], [Shipped], [UnitPrice]) VALUES (15, 7, 392, 3, CAST(8.95 AS Decimal(18, 2)))
SET IDENTITY_INSERT [Chapter5].[OrderItem] OFF
SET IDENTITY_INSERT [Chapter5].[Patient] ON 

INSERT [Chapter5].[Patient] ([PatientId], [Name]) VALUES (75, N'Bill Rivers')
INSERT [Chapter5].[Patient] ([PatientId], [Name]) VALUES (76, N'Susan Stevenson')
INSERT [Chapter5].[Patient] ([PatientId], [Name]) VALUES (77, N'Roland Marcy')
SET IDENTITY_INSERT [Chapter5].[Patient] OFF
SET IDENTITY_INSERT [Chapter5].[Phone] ON 

INSERT [Chapter5].[Phone] ([PhoneId], [Number]) VALUES (7, N'817 867-5309')
SET IDENTITY_INSERT [Chapter5].[Phone] OFF
INSERT [Chapter5].[Plumber] ([TradesmanId], [IsCertified], [LocationId]) VALUES (7, 0, 7)
SET IDENTITY_INSERT [Chapter5].[Project] ON 

INSERT [Chapter5].[Project] ([ProjectID], [Name], [ManagerID]) VALUES (7, N'City Riverfront Park', 7)
SET IDENTITY_INSERT [Chapter5].[Project] OFF
INSERT [Chapter5].[ProjectManager] ([AssociateId]) VALUES (37)
SET IDENTITY_INSERT [Chapter5].[Reservation] ON 

INSERT [Chapter5].[Reservation] ([ReservationId], [StartDate], [EndDate], [ContactName], [RoomId]) VALUES (37, CAST(0x6F320B00 AS Date), CAST(0x70320B00 AS Date), N'Robin Rosen', 46)
INSERT [Chapter5].[Reservation] ([ReservationId], [StartDate], [EndDate], [ContactName], [RoomId]) VALUES (38, CAST(0x92320B00 AS Date), CAST(0x94320B00 AS Date), N'Roberta Jones', 47)
INSERT [Chapter5].[Reservation] ([ReservationId], [StartDate], [EndDate], [ContactName], [RoomId]) VALUES (39, CAST(0x5D320B00 AS Date), CAST(0x67320B00 AS Date), N'Bill Meyers', 47)
SET IDENTITY_INSERT [Chapter5].[Reservation] OFF
SET IDENTITY_INSERT [Chapter5].[Room] ON 

INSERT [Chapter5].[Room] ([RoomId], [Rate], [HotelId]) VALUES (46, CAST(79.95 AS Decimal(18, 2)), 26)
INSERT [Chapter5].[Room] ([RoomId], [Rate], [HotelId]) VALUES (47, CAST(299.95 AS Decimal(18, 2)), 26)
INSERT [Chapter5].[Room] ([RoomId], [Rate], [HotelId]) VALUES (48, CAST(179.95 AS Decimal(18, 2)), 26)
SET IDENTITY_INSERT [Chapter5].[Room] OFF
SET IDENTITY_INSERT [Chapter5].[Section] ON 

INSERT [Chapter5].[Section] ([SectionId], [InstructorId], [CourseId]) VALUES (23, 23, 22)
INSERT [Chapter5].[Section] ([SectionId], [InstructorId], [CourseId]) VALUES (24, 24, 22)
SET IDENTITY_INSERT [Chapter5].[Section] OFF
INSERT [Chapter5].[SectionStudent] ([SectionId], [StudentId]) VALUES (23, 13)
INSERT [Chapter5].[SectionStudent] ([SectionId], [StudentId]) VALUES (23, 15)
INSERT [Chapter5].[SectionStudent] ([SectionId], [StudentId]) VALUES (24, 14)
INSERT [Chapter5].[SectionStudent] ([SectionId], [StudentId]) VALUES (24, 16)
SET IDENTITY_INSERT [Chapter5].[Student] ON 

INSERT [Chapter5].[Student] ([StudentId], [Name]) VALUES (13, N'Jim Roberts')
INSERT [Chapter5].[Student] ([StudentId], [Name]) VALUES (14, N'Jerry Jones')
INSERT [Chapter5].[Student] ([StudentId], [Name]) VALUES (15, N'Susan O''Reilly')
INSERT [Chapter5].[Student] ([StudentId], [Name]) VALUES (16, N'Cathy Ryan')
SET IDENTITY_INSERT [Chapter5].[Student] OFF
INSERT [Chapter5].[Supervisor] ([AssociateId]) VALUES (36)
SET IDENTITY_INSERT [Chapter5].[Tradesman] ON 

INSERT [Chapter5].[Tradesman] ([TradesmanId], [Name], [Email]) VALUES (7, N'Jill Nichols', N'JNichols@plumbers.com')
SET IDENTITY_INSERT [Chapter5].[Tradesman] OFF
SET IDENTITY_INSERT [chapter9].[Client] ON 

INSERT [chapter9].[Client] ([ClientId], [Name], [Email]) VALUES (8, N'Alex Park', N'AlexP@hotmail.com')
SET IDENTITY_INSERT [chapter9].[Client] OFF
SET IDENTITY_INSERT [chapter9].[Comment] ON 

INSERT [chapter9].[Comment] ([CommentId], [PostId], [CommentText]) VALUES (133, 68, N'I use ICollection<T> all the time')
SET IDENTITY_INSERT [chapter9].[Comment] OFF
INSERT [chapter9].[Course] ([CourseId], [Title]) VALUES (1, N'Mathematical Logic 101')
INSERT [chapter9].[Course] ([CourseId], [Title]) VALUES (2, N'Organic Chemistry 211')
SET IDENTITY_INSERT [chapter9].[Customer] ON 

INSERT [chapter9].[Customer] ([CustomerId], [Name], [Company]) VALUES (1049, N'Barrack Obama', N'Presdient')
SET IDENTITY_INSERT [chapter9].[Customer] OFF
SET IDENTITY_INSERT [chapter9].[Invoice] ON 

INSERT [chapter9].[Invoice] ([InvoiceId], [Description]) VALUES (20, N'Auto Repair')
SET IDENTITY_INSERT [chapter9].[Invoice] OFF
SET IDENTITY_INSERT [chapter9].[Order] ON 

INSERT [chapter9].[Order] ([OrderId], [Product], [Quantity], [Status]) VALUES (10062, N'Camping Tent', 10, N'Received')
SET IDENTITY_INSERT [chapter9].[Order] OFF
SET IDENTITY_INSERT [chapter9].[Phone] ON 

INSERT [chapter9].[Phone] ([PhoneId], [Number], [PhoneType], [CustomerId]) VALUES (1067, N'212 222-2222', N'White House Red Phone', 1049)
INSERT [chapter9].[Phone] ([PhoneId], [Number], [PhoneType], [CustomerId]) VALUES (1069, N'212 444-4444', N'Obama Mobile Phone', 1049)
SET IDENTITY_INSERT [chapter9].[Phone] OFF
SET IDENTITY_INSERT [chapter9].[Post] ON 

INSERT [chapter9].[Post] ([PostId], [Title]) VALUES (68, N'Change Tracking Proxies')
SET IDENTITY_INSERT [chapter9].[Post] OFF
SET IDENTITY_INSERT [chapter9].[Project] ON 

INSERT [chapter9].[Project] ([ProjectId], [Name], [AmountAllocated], [PercentComplete]) VALUES (2, N'Trim City Park Trees', CAST(8200.00 AS Decimal(18, 2)), 45)
SET IDENTITY_INSERT [chapter9].[Project] OFF
INSERT [chapter9].[Student] ([StudentId], [Name]) VALUES (1, N'Robin Rosen')
ALTER TABLE [Chapter12].[ParkingTicket] ADD  CONSTRAINT [DF_ParkingTicket_Paid]  DEFAULT ((0)) FOR [Paid]
GO
ALTER TABLE [Chapter1].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Customer] FOREIGN KEY([CustomerId])
REFERENCES [Chapter1].[Customer] ([CustomerId])
GO
ALTER TABLE [Chapter1].[Order] CHECK CONSTRAINT [FK_Order_Customer]
GO
ALTER TABLE [Chapter10].[ATMWithdrawal]  WITH CHECK ADD  CONSTRAINT [FK_ATMWithdrawal_ATMMachine] FOREIGN KEY([ATMId])
REFERENCES [Chapter10].[ATMMachine] ([ATMId])
GO
ALTER TABLE [Chapter10].[ATMWithdrawal] CHECK CONSTRAINT [FK_ATMWithdrawal_ATMMachine]
GO
ALTER TABLE [Chapter10].[AuthorBook]  WITH CHECK ADD  CONSTRAINT [FK_AuthorBook_Author] FOREIGN KEY([AuthorId])
REFERENCES [Chapter10].[Author] ([AuthorId])
GO
ALTER TABLE [Chapter10].[AuthorBook] CHECK CONSTRAINT [FK_AuthorBook_Author]
GO
ALTER TABLE [Chapter10].[AuthorBook]  WITH CHECK ADD  CONSTRAINT [FK_AuthorBook_Book] FOREIGN KEY([BookId])
REFERENCES [Chapter10].[Book] ([BookId])
GO
ALTER TABLE [Chapter10].[AuthorBook] CHECK CONSTRAINT [FK_AuthorBook_Book]
GO
ALTER TABLE [Chapter10].[DVD]  WITH CHECK ADD  CONSTRAINT [FK_DVD_Media] FOREIGN KEY([MediaId])
REFERENCES [Chapter10].[Media] ([MediaId])
GO
ALTER TABLE [Chapter10].[DVD] CHECK CONSTRAINT [FK_DVD_Media]
GO
ALTER TABLE [Chapter10].[Magazine]  WITH CHECK ADD  CONSTRAINT [FK_Magazine_Media] FOREIGN KEY([MediaId])
REFERENCES [Chapter10].[Media] ([MediaId])
GO
ALTER TABLE [Chapter10].[Magazine] CHECK CONSTRAINT [FK_Magazine_Media]
GO
ALTER TABLE [Chapter10].[Message]  WITH CHECK ADD  CONSTRAINT [FK_Message_Member] FOREIGN KEY([MemberId])
REFERENCES [Chapter10].[Member] ([MemberId])
GO
ALTER TABLE [Chapter10].[Message] CHECK CONSTRAINT [FK_Message_Member]
GO
ALTER TABLE [Chapter10].[Rental]  WITH CHECK ADD  CONSTRAINT [FK_Rental_Vehicle] FOREIGN KEY([VehicleId])
REFERENCES [Chapter10].[Vehicle] ([VehicleId])
GO
ALTER TABLE [Chapter10].[Rental] CHECK CONSTRAINT [FK_Rental_Vehicle]
GO
ALTER TABLE [Chapter11].[Associate]  WITH CHECK ADD  CONSTRAINT [FK_Associate_Associate] FOREIGN KEY([ReportsTo])
REFERENCES [Chapter11].[Associate] ([AssociateId])
GO
ALTER TABLE [Chapter11].[Associate] CHECK CONSTRAINT [FK_Associate_Associate]
GO
ALTER TABLE [Chapter11].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Event_Sponsor] FOREIGN KEY([SponsorId])
REFERENCES [Chapter11].[Sponsor] ([SponsorId])
GO
ALTER TABLE [Chapter11].[Event] CHECK CONSTRAINT [FK_Event_Sponsor]
GO
ALTER TABLE [Chapter11].[Invoice]  WITH CHECK ADD  CONSTRAINT [FK_Invoice_Customer] FOREIGN KEY([CustomerId])
REFERENCES [Chapter11].[Customer] ([CustomerId])
GO
ALTER TABLE [Chapter11].[Invoice] CHECK CONSTRAINT [FK_Invoice_Customer]
GO
ALTER TABLE [Chapter11].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Customer] FOREIGN KEY([CustomerId])
REFERENCES [Chapter11].[Customer] ([CustomerId])
GO
ALTER TABLE [Chapter11].[Order] CHECK CONSTRAINT [FK_Order_Customer]
GO
ALTER TABLE [Chapter11].[PatientVisit]  WITH CHECK ADD  CONSTRAINT [FK_PatientVisit_Patient] FOREIGN KEY([PatientId])
REFERENCES [Chapter11].[Patient] ([PatientId])
GO
ALTER TABLE [Chapter11].[PatientVisit] CHECK CONSTRAINT [FK_PatientVisit_Patient]
GO
ALTER TABLE [Chapter11].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category] FOREIGN KEY([CategoryId])
REFERENCES [Chapter11].[Category] ([CategoryId])
GO
ALTER TABLE [Chapter11].[Product] CHECK CONSTRAINT [FK_Product_Category]
GO
ALTER TABLE [Chapter11].[Reservation]  WITH CHECK ADD  CONSTRAINT [FK_Reservation_Hotel] FOREIGN KEY([HotelId])
REFERENCES [Chapter11].[Hotel] ([HotelId])
GO
ALTER TABLE [Chapter11].[Reservation] CHECK CONSTRAINT [FK_Reservation_Hotel]
GO
ALTER TABLE [Chapter11].[Reservation]  WITH CHECK ADD  CONSTRAINT [FK_Reservation_Visitor] FOREIGN KEY([VisitorId])
REFERENCES [Chapter11].[Visitor] ([VistorId])
GO
ALTER TABLE [Chapter11].[Reservation] CHECK CONSTRAINT [FK_Reservation_Visitor]
GO
ALTER TABLE [Chapter11].[Sponsor]  WITH CHECK ADD  CONSTRAINT [FK_Sponsor_SponsorType] FOREIGN KEY([SponsorTypeId])
REFERENCES [Chapter11].[SponsorType] ([SponsorTypeId])
GO
ALTER TABLE [Chapter11].[Sponsor] CHECK CONSTRAINT [FK_Sponsor_SponsorType]
GO
ALTER TABLE [Chapter12].[CartItem]  WITH CHECK ADD  CONSTRAINT [FK_CartItem_Cart] FOREIGN KEY([CartId])
REFERENCES [Chapter12].[Cart] ([CartId])
GO
ALTER TABLE [Chapter12].[CartItem] CHECK CONSTRAINT [FK_CartItem_Cart]
GO
ALTER TABLE [Chapter12].[Class]  WITH CHECK ADD  CONSTRAINT [FK_Class_Course] FOREIGN KEY([CourseId])
REFERENCES [Chapter12].[Course] ([CourseId])
ON DELETE CASCADE
GO
ALTER TABLE [Chapter12].[Class] CHECK CONSTRAINT [FK_Class_Course]
GO
ALTER TABLE [Chapter12].[Enrollment]  WITH CHECK ADD  CONSTRAINT [FK_Enrollment_Class] FOREIGN KEY([ClassId])
REFERENCES [Chapter12].[Class] ([ClassId])
ON DELETE CASCADE
GO
ALTER TABLE [Chapter12].[Enrollment] CHECK CONSTRAINT [FK_Enrollment_Class]
GO
ALTER TABLE [Chapter12].[Ingredient]  WITH CHECK ADD  CONSTRAINT [FK_Ingredient_Recipe] FOREIGN KEY([RecipeId])
REFERENCES [Chapter12].[Recipe] ([RecipeId])
GO
ALTER TABLE [Chapter12].[Ingredient] CHECK CONSTRAINT [FK_Ingredient_Recipe]
GO
ALTER TABLE [Chapter12].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_OrderStatus] FOREIGN KEY([OrderStatusId])
REFERENCES [Chapter12].[OrderStatus] ([OrderStatusId])
GO
ALTER TABLE [Chapter12].[Order] CHECK CONSTRAINT [FK_Order_OrderStatus]
GO
ALTER TABLE [Chapter12].[SalesOrder]  WITH CHECK ADD  CONSTRAINT [FK_SalesOrder_Customer] FOREIGN KEY([CustomerId])
REFERENCES [Chapter12].[Customer] ([CustomerId])
GO
ALTER TABLE [Chapter12].[SalesOrder] CHECK CONSTRAINT [FK_SalesOrder_Customer]
GO
ALTER TABLE [Chapter12].[Step]  WITH CHECK ADD  CONSTRAINT [FK_Step_Recipe] FOREIGN KEY([RecipeId])
REFERENCES [Chapter12].[Recipe] ([RecipeId])
GO
ALTER TABLE [Chapter12].[Step] CHECK CONSTRAINT [FK_Step_Recipe]
GO
ALTER TABLE [Chapter13].[Accountant]  WITH CHECK ADD  CONSTRAINT [FK_Accountant_Person] FOREIGN KEY([PersonId])
REFERENCES [Chapter13].[Person] ([PersonId])
GO
ALTER TABLE [Chapter13].[Accountant] CHECK CONSTRAINT [FK_Accountant_Person]
GO
ALTER TABLE [Chapter13].[Appointment]  WITH CHECK ADD  CONSTRAINT [FK_Appointment_Doctor] FOREIGN KEY([DoctorId])
REFERENCES [Chapter13].[Doctor] ([DoctorId])
GO
ALTER TABLE [Chapter13].[Appointment] CHECK CONSTRAINT [FK_Appointment_Doctor]
GO
ALTER TABLE [Chapter13].[Client]  WITH CHECK ADD  CONSTRAINT [FK_Client_Accountant1] FOREIGN KEY([AccountantId])
REFERENCES [Chapter13].[Accountant] ([PersonId])
GO
ALTER TABLE [Chapter13].[Client] CHECK CONSTRAINT [FK_Client_Accountant1]
GO
ALTER TABLE [Chapter13].[CourtDate]  WITH CHECK ADD  CONSTRAINT [FK_CourtDate_Lawyer] FOREIGN KEY([LawyerId])
REFERENCES [Chapter13].[Lawyer] ([PersonId])
GO
ALTER TABLE [Chapter13].[CourtDate] CHECK CONSTRAINT [FK_CourtDate_Lawyer]
GO
ALTER TABLE [Chapter13].[CreditCard]  WITH CHECK ADD  CONSTRAINT [FK_CreditCard_Customer] FOREIGN KEY([CustomerId])
REFERENCES [Chapter13].[Customer] ([CustomerId])
GO
ALTER TABLE [Chapter13].[CreditCard] CHECK CONSTRAINT [FK_CreditCard_Customer]
GO
ALTER TABLE [Chapter13].[Doctor]  WITH CHECK ADD  CONSTRAINT [FK_Doctor_Company] FOREIGN KEY([CompanyId])
REFERENCES [Chapter13].[Company] ([CompanyId])
GO
ALTER TABLE [Chapter13].[Doctor] CHECK CONSTRAINT [FK_Doctor_Company]
GO
ALTER TABLE [Chapter13].[HourlyEmployee]  WITH CHECK ADD  CONSTRAINT [FK_HourlyEmployee_Employee] FOREIGN KEY([EmployeeId])
REFERENCES [Chapter13].[Employee] ([EmployeeId])
GO
ALTER TABLE [Chapter13].[HourlyEmployee] CHECK CONSTRAINT [FK_HourlyEmployee_Employee]
GO
ALTER TABLE [Chapter13].[Lawyer]  WITH CHECK ADD  CONSTRAINT [FK_Lawyer_Person] FOREIGN KEY([PersonId])
REFERENCES [Chapter13].[Person] ([PersonId])
GO
ALTER TABLE [Chapter13].[Lawyer] CHECK CONSTRAINT [FK_Lawyer_Person]
GO
ALTER TABLE [Chapter13].[Paycheck]  WITH CHECK ADD  CONSTRAINT [FK_Pay_Associate] FOREIGN KEY([AssociateId])
REFERENCES [Chapter13].[Associate] ([AssociateId])
GO
ALTER TABLE [Chapter13].[Paycheck] CHECK CONSTRAINT [FK_Pay_Associate]
GO
ALTER TABLE [Chapter13].[Payment]  WITH CHECK ADD  CONSTRAINT [FK_Payment_Account] FOREIGN KEY([AccountId])
REFERENCES [Chapter13].[Account] ([AccountId])
GO
ALTER TABLE [Chapter13].[Payment] CHECK CONSTRAINT [FK_Payment_Account]
GO
ALTER TABLE [Chapter13].[Person]  WITH CHECK ADD  CONSTRAINT [FK_Person_College] FOREIGN KEY([CollegeId])
REFERENCES [Chapter13].[College] ([CollegeId])
GO
ALTER TABLE [Chapter13].[Person] CHECK CONSTRAINT [FK_Person_College]
GO
ALTER TABLE [Chapter13].[SalariedEmployee]  WITH CHECK ADD  CONSTRAINT [FK_SalariedEmployee_Employee] FOREIGN KEY([EmployeeId])
REFERENCES [Chapter13].[Employee] ([EmployeeId])
GO
ALTER TABLE [Chapter13].[SalariedEmployee] CHECK CONSTRAINT [FK_SalariedEmployee_Employee]
GO
ALTER TABLE [Chapter13].[Track]  WITH CHECK ADD  CONSTRAINT [FK_Track_CD] FOREIGN KEY([CDId])
REFERENCES [Chapter13].[CD] ([CDId])
GO
ALTER TABLE [Chapter13].[Track] CHECK CONSTRAINT [FK_Track_CD]
GO
ALTER TABLE [Chapter13].[Transaction]  WITH CHECK ADD  CONSTRAINT [FK_Transaction_CreditCard] FOREIGN KEY([CardNumber])
REFERENCES [Chapter13].[CreditCard] ([CardNumber])
GO
ALTER TABLE [Chapter13].[Transaction] CHECK CONSTRAINT [FK_Transaction_CreditCard]
GO
ALTER TABLE [Chapter14].[Instructor]  WITH CHECK ADD  CONSTRAINT [FK_Instructor_Person] FOREIGN KEY([PersonId])
REFERENCES [Chapter14].[Person] ([PersonId])
GO
ALTER TABLE [Chapter14].[Instructor] CHECK CONSTRAINT [FK_Instructor_Person]
GO
ALTER TABLE [Chapter14].[Student]  WITH CHECK ADD  CONSTRAINT [FK_Student_Person] FOREIGN KEY([PersonId])
REFERENCES [Chapter14].[Person] ([PersonId])
GO
ALTER TABLE [Chapter14].[Student] CHECK CONSTRAINT [FK_Student_Person]
GO
ALTER TABLE [Chapter15].[Article]  WITH CHECK ADD  CONSTRAINT [FK_Article_Media] FOREIGN KEY([ArticleId])
REFERENCES [Chapter15].[Media] ([MediaId])
GO
ALTER TABLE [Chapter15].[Article] CHECK CONSTRAINT [FK_Article_Media]
GO
ALTER TABLE [Chapter15].[AuthorBook]  WITH CHECK ADD  CONSTRAINT [FK_AuthorBook_Author] FOREIGN KEY([AuthorId])
REFERENCES [Chapter15].[Author] ([AuthorId])
GO
ALTER TABLE [Chapter15].[AuthorBook] CHECK CONSTRAINT [FK_AuthorBook_Author]
GO
ALTER TABLE [Chapter15].[AuthorBook]  WITH CHECK ADD  CONSTRAINT [FK_AuthorBook_Book] FOREIGN KEY([BookId])
REFERENCES [Chapter15].[Book] ([BookId])
GO
ALTER TABLE [Chapter15].[AuthorBook] CHECK CONSTRAINT [FK_AuthorBook_Book]
GO
ALTER TABLE [Chapter15].[Contact]  WITH CHECK ADD  CONSTRAINT [FK_Contact_Account] FOREIGN KEY([AccountId])
REFERENCES [Chapter15].[Account] ([AccountId])
GO
ALTER TABLE [Chapter15].[Contact] CHECK CONSTRAINT [FK_Contact_Account]
GO
ALTER TABLE [Chapter15].[CreditReport]  WITH CHECK ADD  CONSTRAINT [FK_CreditReport_CreditRiskCustomer] FOREIGN KEY([CustomerId])
REFERENCES [Chapter15].[CreditRiskCustomer] ([CustomerId])
GO
ALTER TABLE [Chapter15].[CreditReport] CHECK CONSTRAINT [FK_CreditReport_CreditRiskCustomer]
GO
ALTER TABLE [Chapter15].[CreditRiskOrder]  WITH CHECK ADD  CONSTRAINT [FK_CreditRiskOrder_CreditRiskCustomer] FOREIGN KEY([CustomerId])
REFERENCES [Chapter15].[CreditRiskCustomer] ([CustomerId])
GO
ALTER TABLE [Chapter15].[CreditRiskOrder] CHECK CONSTRAINT [FK_CreditRiskOrder_CreditRiskCustomer]
GO
ALTER TABLE [Chapter15].[CustomerDiscount]  WITH CHECK ADD  CONSTRAINT [FK_CustomerDiscount_PreferredCustomer] FOREIGN KEY([CustomerId])
REFERENCES [Chapter15].[PreferredCustomer] ([CustomerId])
GO
ALTER TABLE [Chapter15].[CustomerDiscount] CHECK CONSTRAINT [FK_CustomerDiscount_PreferredCustomer]
GO
ALTER TABLE [Chapter15].[Invoice]  WITH CHECK ADD  CONSTRAINT [FK_Invoice_Client] FOREIGN KEY([ClientId])
REFERENCES [Chapter15].[Client] ([ClientId])
GO
ALTER TABLE [Chapter15].[Invoice] CHECK CONSTRAINT [FK_Invoice_Client]
GO
ALTER TABLE [Chapter15].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Customer] FOREIGN KEY([CustomerId])
REFERENCES [Chapter15].[Customer] ([CustomerId])
GO
ALTER TABLE [Chapter15].[Order] CHECK CONSTRAINT [FK_Order_Customer]
GO
ALTER TABLE [Chapter15].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_OrderStatusType] FOREIGN KEY([OrderStatusTypeId])
REFERENCES [Chapter15].[OrderStatusType] ([OrderStatusTypeId])
GO
ALTER TABLE [Chapter15].[Order] CHECK CONSTRAINT [FK_Order_OrderStatusType]
GO
ALTER TABLE [Chapter15].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_ShippingType] FOREIGN KEY([ShippingTypeId])
REFERENCES [Chapter15].[ShippingType] ([ShippingTypeId])
GO
ALTER TABLE [Chapter15].[Order] CHECK CONSTRAINT [FK_Order_ShippingType]
GO
ALTER TABLE [Chapter15].[PreferredOrder]  WITH CHECK ADD  CONSTRAINT [FK_PreferredOrder_PreferredCustomer] FOREIGN KEY([CustomerId])
REFERENCES [Chapter15].[PreferredCustomer] ([CustomerId])
GO
ALTER TABLE [Chapter15].[PreferredOrder] CHECK CONSTRAINT [FK_PreferredOrder_PreferredCustomer]
GO
ALTER TABLE [Chapter15].[ProjectEmployee]  WITH CHECK ADD  CONSTRAINT [FK_ProjectEmployee_Employee] FOREIGN KEY([EmployeeId])
REFERENCES [Chapter15].[Employee] ([EmployeeId])
GO
ALTER TABLE [Chapter15].[ProjectEmployee] CHECK CONSTRAINT [FK_ProjectEmployee_Employee]
GO
ALTER TABLE [Chapter15].[ProjectEmployee]  WITH CHECK ADD  CONSTRAINT [FK_ProjectEmployee_Project] FOREIGN KEY([ProjectId])
REFERENCES [Chapter15].[Project] ([ProjectId])
GO
ALTER TABLE [Chapter15].[ProjectEmployee] CHECK CONSTRAINT [FK_ProjectEmployee_Project]
GO
ALTER TABLE [Chapter15].[Video]  WITH CHECK ADD  CONSTRAINT [FK_Video_Media] FOREIGN KEY([VideoId])
REFERENCES [Chapter15].[Media] ([MediaId])
GO
ALTER TABLE [Chapter15].[Video] CHECK CONSTRAINT [FK_Video_Media]
GO
ALTER TABLE [Chapter2].[eCommerce]  WITH CHECK ADD  CONSTRAINT [FK_eCommerce_Business] FOREIGN KEY([BusinessId])
REFERENCES [Chapter2].[Business] ([BusinessId])
GO
ALTER TABLE [Chapter2].[eCommerce] CHECK CONSTRAINT [FK_eCommerce_Business]
GO
ALTER TABLE [Chapter2].[LinkTable]  WITH CHECK ADD  CONSTRAINT [FK_LinkTable_Album] FOREIGN KEY([AlbumId])
REFERENCES [Chapter2].[Album] ([AlbumId])
GO
ALTER TABLE [Chapter2].[LinkTable] CHECK CONSTRAINT [FK_LinkTable_Album]
GO
ALTER TABLE [Chapter2].[LinkTable]  WITH CHECK ADD  CONSTRAINT [FK_LinkTable_Artist] FOREIGN KEY([ArtistId])
REFERENCES [Chapter2].[Artist] ([ArtistId])
GO
ALTER TABLE [Chapter2].[LinkTable] CHECK CONSTRAINT [FK_LinkTable_Artist]
GO
ALTER TABLE [Chapter2].[OrderItem]  WITH CHECK ADD  CONSTRAINT [FK_OrderItem_Item] FOREIGN KEY([SKU])
REFERENCES [Chapter2].[Item] ([SKU])
GO
ALTER TABLE [Chapter2].[OrderItem] CHECK CONSTRAINT [FK_OrderItem_Item]
GO
ALTER TABLE [Chapter2].[OrderItem]  WITH CHECK ADD  CONSTRAINT [FK_OrderItem_Order] FOREIGN KEY([OrderId])
REFERENCES [Chapter2].[Order] ([OrderId])
GO
ALTER TABLE [Chapter2].[OrderItem] CHECK CONSTRAINT [FK_OrderItem_Order]
GO
ALTER TABLE [Chapter2].[Park]  WITH CHECK ADD  CONSTRAINT [FK_Park_Location] FOREIGN KEY([ParkId])
REFERENCES [Chapter2].[Location] ([LocationId])
GO
ALTER TABLE [Chapter2].[Park] CHECK CONSTRAINT [FK_Park_Location]
GO
ALTER TABLE [Chapter2].[Park]  WITH CHECK ADD  CONSTRAINT [FK_Park_Location1] FOREIGN KEY([OfficeLocationId])
REFERENCES [Chapter2].[Location] ([LocationId])
GO
ALTER TABLE [Chapter2].[Park] CHECK CONSTRAINT [FK_Park_Location1]
GO
ALTER TABLE [Chapter2].[PictureCategory]  WITH CHECK ADD  CONSTRAINT [FK_PictureCategory_PictureCategory] FOREIGN KEY([ParentCategoryId])
REFERENCES [Chapter2].[PictureCategory] ([CategoryId])
GO
ALTER TABLE [Chapter2].[PictureCategory] CHECK CONSTRAINT [FK_PictureCategory_PictureCategory]
GO
ALTER TABLE [Chapter2].[Poem]  WITH CHECK ADD  CONSTRAINT [FK_Poem_Meter] FOREIGN KEY([MeterId])
REFERENCES [Chapter2].[Meter] ([MeterId])
GO
ALTER TABLE [Chapter2].[Poem] CHECK CONSTRAINT [FK_Poem_Meter]
GO
ALTER TABLE [Chapter2].[Poem]  WITH CHECK ADD  CONSTRAINT [FK_Poem_Poet] FOREIGN KEY([PoetId])
REFERENCES [Chapter2].[Poet] ([PoetId])
GO
ALTER TABLE [Chapter2].[Poem] CHECK CONSTRAINT [FK_Poem_Poet]
GO
ALTER TABLE [Chapter2].[ProductWebInfo]  WITH CHECK ADD  CONSTRAINT [FK_ProductWebInfo_Product] FOREIGN KEY([SKU])
REFERENCES [Chapter2].[Product] ([SKU])
GO
ALTER TABLE [Chapter2].[ProductWebInfo] CHECK CONSTRAINT [FK_ProductWebInfo_Product]
GO
ALTER TABLE [Chapter2].[Retail]  WITH CHECK ADD  CONSTRAINT [FK_Retail_Business] FOREIGN KEY([BusinessId])
REFERENCES [Chapter2].[Business] ([BusinessId])
GO
ALTER TABLE [Chapter2].[Retail] CHECK CONSTRAINT [FK_Retail_Business]
GO
ALTER TABLE [Chapter3].[Accident]  WITH CHECK ADD  CONSTRAINT [FK_Accident_Worker] FOREIGN KEY([WorkerId])
REFERENCES [Chapter3].[Worker] ([WorkerId])
GO
ALTER TABLE [Chapter3].[Accident] CHECK CONSTRAINT [FK_Accident_Worker]
GO
ALTER TABLE [Chapter3].[AssociateSalary]  WITH CHECK ADD  CONSTRAINT [FK_AssociateSalary_Associate] FOREIGN KEY([AssociateId])
REFERENCES [Chapter3].[Associate] ([AssociateId])
GO
ALTER TABLE [Chapter3].[AssociateSalary] CHECK CONSTRAINT [FK_AssociateSalary_Associate]
GO
ALTER TABLE [Chapter3].[Bid]  WITH CHECK ADD  CONSTRAINT [FK_Bid_Job] FOREIGN KEY([JobId])
REFERENCES [Chapter3].[Job] ([JobId])
GO
ALTER TABLE [Chapter3].[Bid] CHECK CONSTRAINT [FK_Bid_Job]
GO
ALTER TABLE [Chapter3].[Book]  WITH CHECK ADD  CONSTRAINT [FK_Book_Category] FOREIGN KEY([CategoryId])
REFERENCES [Chapter3].[Category] ([CategoryId])
GO
ALTER TABLE [Chapter3].[Book] CHECK CONSTRAINT [FK_Book_Category]
GO
ALTER TABLE [Chapter3].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_BlogPost] FOREIGN KEY([PostId])
REFERENCES [Chapter3].[BlogPost] ([PostId])
GO
ALTER TABLE [Chapter3].[Comment] CHECK CONSTRAINT [FK_Comment_BlogPost]
GO
ALTER TABLE [Chapter3].[Lawyer]  WITH CHECK ADD  CONSTRAINT [FK_Lawyer_Person] FOREIGN KEY([PersonId])
REFERENCES [Chapter3].[Person] ([PersonId])
GO
ALTER TABLE [Chapter3].[Lawyer] CHECK CONSTRAINT [FK_Lawyer_Person]
GO
ALTER TABLE [Chapter3].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Account] FOREIGN KEY([AccountId])
REFERENCES [Chapter3].[Account] ([AccountId])
GO
ALTER TABLE [Chapter3].[Order] CHECK CONSTRAINT [FK_Order_Account]
GO
ALTER TABLE [Chapter3].[Teacher]  WITH CHECK ADD  CONSTRAINT [FK_Teacher_Person] FOREIGN KEY([PersonId])
REFERENCES [Chapter3].[Person] ([PersonId])
GO
ALTER TABLE [Chapter3].[Teacher] CHECK CONSTRAINT [FK_Teacher_Person]
GO
ALTER TABLE [Chapter3].[TopSelling]  WITH CHECK ADD  CONSTRAINT [FK_TopSelling_Product] FOREIGN KEY([ProductId])
REFERENCES [Chapter3].[Product] ([ProductId])
GO
ALTER TABLE [Chapter3].[TopSelling] CHECK CONSTRAINT [FK_TopSelling_Product]
GO
ALTER TABLE [Chapter4].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_ItemCategory] FOREIGN KEY([ItemCategoryId])
REFERENCES [Chapter4].[ItemCategory] ([ItemCategoryId])
GO
ALTER TABLE [Chapter4].[Item] CHECK CONSTRAINT [FK_Item_ItemCategory]
GO
ALTER TABLE [Chapter4].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_WebCustomer] FOREIGN KEY([CustomerId])
REFERENCES [Chapter4].[WebCustomer] ([CustomerId])
GO
ALTER TABLE [Chapter4].[Order] CHECK CONSTRAINT [FK_Order_WebCustomer]
GO
ALTER TABLE [Chapter4].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Product] FOREIGN KEY([ProductId])
REFERENCES [Chapter4].[Product] ([ProductId])
GO
ALTER TABLE [Chapter4].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Product]
GO
ALTER TABLE [Chapter4].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category] FOREIGN KEY([CategoryId])
REFERENCES [Chapter4].[Category] ([CategoryId])
GO
ALTER TABLE [Chapter4].[Product] CHECK CONSTRAINT [FK_Product_Category]
GO
ALTER TABLE [Chapter4].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Supplier] FOREIGN KEY([SupplierId])
REFERENCES [Chapter4].[Supplier] ([SupplierId])
GO
ALTER TABLE [Chapter4].[Product] CHECK CONSTRAINT [FK_Product_Supplier]
GO
ALTER TABLE [Chapter4].[ProductDetail]  WITH CHECK ADD  CONSTRAINT [FK_ProductDetail_Product] FOREIGN KEY([ProductId])
REFERENCES [Chapter4].[Product] ([ProductId])
GO
ALTER TABLE [Chapter4].[ProductDetail] CHECK CONSTRAINT [FK_ProductDetail_Product]
GO
ALTER TABLE [Chapter4].[Reservation]  WITH CHECK ADD  CONSTRAINT [FK_Reservation_Hotel] FOREIGN KEY([HotelId])
REFERENCES [Chapter4].[Hotel] ([HotelId])
GO
ALTER TABLE [Chapter4].[Reservation] CHECK CONSTRAINT [FK_Reservation_Hotel]
GO
ALTER TABLE [Chapter5].[Appointment]  WITH CHECK ADD  CONSTRAINT [FK_Appointment_Doctor] FOREIGN KEY([DoctorId])
REFERENCES [Chapter5].[Doctor] ([DoctorId])
GO
ALTER TABLE [Chapter5].[Appointment] CHECK CONSTRAINT [FK_Appointment_Doctor]
GO
ALTER TABLE [Chapter5].[Appointment]  WITH CHECK ADD  CONSTRAINT [FK_Appointment_Patient] FOREIGN KEY([PatientId])
REFERENCES [Chapter5].[Patient] ([PatientId])
GO
ALTER TABLE [Chapter5].[Appointment] CHECK CONSTRAINT [FK_Appointment_Patient]
GO
ALTER TABLE [Chapter5].[Associate]  WITH CHECK ADD  CONSTRAINT [FK_Associate_Associate] FOREIGN KEY([ReportsTo])
REFERENCES [Chapter5].[Associate] ([AssociateId])
GO
ALTER TABLE [Chapter5].[Associate] CHECK CONSTRAINT [FK_Associate_Associate]
GO
ALTER TABLE [Chapter5].[CEO]  WITH CHECK ADD  CONSTRAINT [FK_CEO_Associate] FOREIGN KEY([AssociateId])
REFERENCES [Chapter5].[Associate] ([AssociateId])
GO
ALTER TABLE [Chapter5].[CEO] CHECK CONSTRAINT [FK_CEO_Associate]
GO
ALTER TABLE [Chapter5].[Contractor]  WITH CHECK ADD  CONSTRAINT [FK_Contractor_Project] FOREIGN KEY([ProjectID])
REFERENCES [Chapter5].[Project] ([ProjectID])
GO
ALTER TABLE [Chapter5].[Contractor] CHECK CONSTRAINT [FK_Contractor_Project]
GO
ALTER TABLE [Chapter5].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_CustomerType] FOREIGN KEY([CustomerTypeId])
REFERENCES [Chapter5].[CustomerType] ([CustomerTypeId])
GO
ALTER TABLE [Chapter5].[Customer] CHECK CONSTRAINT [FK_Customer_CustomerType]
GO
ALTER TABLE [Chapter5].[CustomerEmail]  WITH CHECK ADD  CONSTRAINT [FK_CustomerEmail_Customer] FOREIGN KEY([CustomerId])
REFERENCES [Chapter5].[Customer] ([CustomerId])
GO
ALTER TABLE [Chapter5].[CustomerEmail] CHECK CONSTRAINT [FK_CustomerEmail_Customer]
GO
ALTER TABLE [Chapter5].[Department]  WITH CHECK ADD  CONSTRAINT [FK_Department_Company] FOREIGN KEY([CompanyId])
REFERENCES [Chapter5].[Company] ([CompanyId])
GO
ALTER TABLE [Chapter5].[Department] CHECK CONSTRAINT [FK_Department_Company]
GO
ALTER TABLE [Chapter5].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Department] FOREIGN KEY([DepartmentId])
REFERENCES [Chapter5].[Department] ([DepartmentId])
GO
ALTER TABLE [Chapter5].[Employee] CHECK CONSTRAINT [FK_Employee_Department]
GO
ALTER TABLE [Chapter5].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Event_Club] FOREIGN KEY([ClubId])
REFERENCES [Chapter5].[Club] ([ClubId])
GO
ALTER TABLE [Chapter5].[Event] CHECK CONSTRAINT [FK_Event_Club]
GO
ALTER TABLE [Chapter5].[ExecutiveSuite]  WITH CHECK ADD  CONSTRAINT [FK_ExecutiveSuite_Room] FOREIGN KEY([RoomId])
REFERENCES [Chapter5].[Room] ([RoomId])
GO
ALTER TABLE [Chapter5].[ExecutiveSuite] CHECK CONSTRAINT [FK_ExecutiveSuite_Room]
GO
ALTER TABLE [Chapter5].[Foreman]  WITH CHECK ADD  CONSTRAINT [FK_Foreman_JobSite] FOREIGN KEY([LocationId])
REFERENCES [Chapter5].[JobSite] ([LocationId])
GO
ALTER TABLE [Chapter5].[Foreman] CHECK CONSTRAINT [FK_Foreman_JobSite]
GO
ALTER TABLE [Chapter5].[Invoice]  WITH CHECK ADD  CONSTRAINT [FK_Invoice_Client] FOREIGN KEY([ClientId])
REFERENCES [Chapter5].[Client] ([ClientId])
GO
ALTER TABLE [Chapter5].[Invoice] CHECK CONSTRAINT [FK_Invoice_Client]
GO
ALTER TABLE [Chapter5].[JobSite]  WITH CHECK ADD  CONSTRAINT [FK_JobSite_Location] FOREIGN KEY([LocationId])
REFERENCES [Chapter5].[Location] ([LocationId])
GO
ALTER TABLE [Chapter5].[JobSite] CHECK CONSTRAINT [FK_JobSite_Location]
GO
ALTER TABLE [Chapter5].[Location]  WITH CHECK ADD  CONSTRAINT [FK_Location_Phone] FOREIGN KEY([PhoneId])
REFERENCES [Chapter5].[Phone] ([PhoneId])
GO
ALTER TABLE [Chapter5].[Location] CHECK CONSTRAINT [FK_Location_Phone]
GO
ALTER TABLE [Chapter5].[Movie]  WITH CHECK ADD  CONSTRAINT [FK_Movie_Category] FOREIGN KEY([CategoryId])
REFERENCES [Chapter5].[Category] ([CategoryId])
GO
ALTER TABLE [Chapter5].[Movie] CHECK CONSTRAINT [FK_Movie_Category]
GO
ALTER TABLE [Chapter5].[OrderItem]  WITH CHECK ADD  CONSTRAINT [FK_OrderItem_Order] FOREIGN KEY([OrderId])
REFERENCES [Chapter5].[Order] ([OrderId])
GO
ALTER TABLE [Chapter5].[OrderItem] CHECK CONSTRAINT [FK_OrderItem_Order]
GO
ALTER TABLE [Chapter5].[Plumber]  WITH CHECK ADD  CONSTRAINT [FK_Plumber_JobSite] FOREIGN KEY([LocationId])
REFERENCES [Chapter5].[JobSite] ([LocationId])
GO
ALTER TABLE [Chapter5].[Plumber] CHECK CONSTRAINT [FK_Plumber_JobSite]
GO
ALTER TABLE [Chapter5].[Plumber]  WITH CHECK ADD  CONSTRAINT [FK_Plumber_Tradesman] FOREIGN KEY([TradesmanId])
REFERENCES [Chapter5].[Tradesman] ([TradesmanId])
GO
ALTER TABLE [Chapter5].[Plumber] CHECK CONSTRAINT [FK_Plumber_Tradesman]
GO
ALTER TABLE [Chapter5].[Project]  WITH CHECK ADD  CONSTRAINT [FK_Project_Manager] FOREIGN KEY([ManagerID])
REFERENCES [Chapter5].[Manager] ([ManagerID])
GO
ALTER TABLE [Chapter5].[Project] CHECK CONSTRAINT [FK_Project_Manager]
GO
ALTER TABLE [Chapter5].[ProjectManager]  WITH CHECK ADD  CONSTRAINT [FK_ProjectManager_Associate] FOREIGN KEY([AssociateId])
REFERENCES [Chapter5].[Associate] ([AssociateId])
GO
ALTER TABLE [Chapter5].[ProjectManager] CHECK CONSTRAINT [FK_ProjectManager_Associate]
GO
ALTER TABLE [Chapter5].[Reservation]  WITH CHECK ADD  CONSTRAINT [FK_Reservation_Room] FOREIGN KEY([RoomId])
REFERENCES [Chapter5].[Room] ([RoomId])
GO
ALTER TABLE [Chapter5].[Reservation] CHECK CONSTRAINT [FK_Reservation_Room]
GO
ALTER TABLE [Chapter5].[Room]  WITH CHECK ADD  CONSTRAINT [FK_Room_Hotel] FOREIGN KEY([HotelId])
REFERENCES [Chapter5].[Hotel] ([HotelId])
GO
ALTER TABLE [Chapter5].[Room] CHECK CONSTRAINT [FK_Room_Hotel]
GO
ALTER TABLE [Chapter5].[Section]  WITH CHECK ADD  CONSTRAINT [FK_Section_Course] FOREIGN KEY([CourseId])
REFERENCES [Chapter5].[Course] ([CourseId])
GO
ALTER TABLE [Chapter5].[Section] CHECK CONSTRAINT [FK_Section_Course]
GO
ALTER TABLE [Chapter5].[Section]  WITH CHECK ADD  CONSTRAINT [FK_Section_Instructor] FOREIGN KEY([InstructorId])
REFERENCES [Chapter5].[Instructor] ([InstructorId])
GO
ALTER TABLE [Chapter5].[Section] CHECK CONSTRAINT [FK_Section_Instructor]
GO
ALTER TABLE [Chapter5].[SectionStudent]  WITH CHECK ADD  CONSTRAINT [FK_SectionStudent_Section] FOREIGN KEY([SectionId])
REFERENCES [Chapter5].[Section] ([SectionId])
GO
ALTER TABLE [Chapter5].[SectionStudent] CHECK CONSTRAINT [FK_SectionStudent_Section]
GO
ALTER TABLE [Chapter5].[SectionStudent]  WITH CHECK ADD  CONSTRAINT [FK_SectionStudent_Student] FOREIGN KEY([StudentId])
REFERENCES [Chapter5].[Student] ([StudentId])
GO
ALTER TABLE [Chapter5].[SectionStudent] CHECK CONSTRAINT [FK_SectionStudent_Student]
GO
ALTER TABLE [Chapter5].[Supervisor]  WITH CHECK ADD  CONSTRAINT [FK_Supervisor_Associate] FOREIGN KEY([AssociateId])
REFERENCES [Chapter5].[Associate] ([AssociateId])
GO
ALTER TABLE [Chapter5].[Supervisor] CHECK CONSTRAINT [FK_Supervisor_Associate]
GO
ALTER TABLE [Chapter6].[CarDealer]  WITH CHECK ADD  CONSTRAINT [FK_CarDealer_Dealer] FOREIGN KEY([DealerId])
REFERENCES [Chapter6].[Dealer] ([DealerId])
GO
ALTER TABLE [Chapter6].[CarDealer] CHECK CONSTRAINT [FK_CarDealer_Dealer]
GO
ALTER TABLE [Chapter6].[Category]  WITH CHECK ADD  CONSTRAINT [FK_Category_Category] FOREIGN KEY([ParentCategoryId])
REFERENCES [Chapter6].[Category] ([CategoryId])
GO
ALTER TABLE [Chapter6].[Category] CHECK CONSTRAINT [FK_Category_Category]
GO
ALTER TABLE [Chapter6].[EventOrganizer]  WITH CHECK ADD  CONSTRAINT [FK_EventOrganizer_Event] FOREIGN KEY([EventId])
REFERENCES [Chapter6].[Event] ([EventId])
GO
ALTER TABLE [Chapter6].[EventOrganizer] CHECK CONSTRAINT [FK_EventOrganizer_Event]
GO
ALTER TABLE [Chapter6].[EventOrganizer]  WITH CHECK ADD  CONSTRAINT [FK_EventOrganizer_Organizer] FOREIGN KEY([OrganizerId])
REFERENCES [Chapter6].[Organizer] ([OrganizerId])
GO
ALTER TABLE [Chapter6].[EventOrganizer] CHECK CONSTRAINT [FK_EventOrganizer_Organizer]
GO
ALTER TABLE [Chapter6].[Instructor]  WITH CHECK ADD  CONSTRAINT [FK_Instructor_Staff] FOREIGN KEY([StaffId])
REFERENCES [Chapter6].[Staff] ([StaffId])
GO
ALTER TABLE [Chapter6].[Instructor] CHECK CONSTRAINT [FK_Instructor_Staff]
GO
ALTER TABLE [Chapter6].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Lookup] FOREIGN KEY([OrderStatusId])
REFERENCES [Chapter6].[Lookup] ([LookupId])
GO
ALTER TABLE [Chapter6].[Order] CHECK CONSTRAINT [FK_Order_Lookup]
GO
ALTER TABLE [Chapter6].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Lookup1] FOREIGN KEY([TransactionTypeId])
REFERENCES [Chapter6].[Lookup] ([LookupId])
GO
ALTER TABLE [Chapter6].[Order] CHECK CONSTRAINT [FK_Order_Lookup1]
GO
ALTER TABLE [Chapter6].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Lookup2] FOREIGN KEY([ShippingTypeId])
REFERENCES [Chapter6].[Lookup] ([LookupId])
GO
ALTER TABLE [Chapter6].[Order] CHECK CONSTRAINT [FK_Order_Lookup2]
GO
ALTER TABLE [Chapter6].[Person]  WITH CHECK ADD  CONSTRAINT [FK_Person_Person] FOREIGN KEY([HeroId])
REFERENCES [Chapter6].[Person] ([PersonId])
GO
ALTER TABLE [Chapter6].[Person] CHECK CONSTRAINT [FK_Person_Person]
GO
ALTER TABLE [Chapter6].[Principal]  WITH CHECK ADD  CONSTRAINT [FK_Principal_Staff] FOREIGN KEY([StaffId])
REFERENCES [Chapter6].[Staff] ([StaffId])
GO
ALTER TABLE [Chapter6].[Principal] CHECK CONSTRAINT [FK_Principal_Staff]
GO
ALTER TABLE [Chapter6].[RefurbishedToy]  WITH CHECK ADD  CONSTRAINT [FK_RefurbishedToy_Toy] FOREIGN KEY([ToyId])
REFERENCES [Chapter6].[Toy] ([ToyId])
GO
ALTER TABLE [Chapter6].[RefurbishedToy] CHECK CONSTRAINT [FK_RefurbishedToy_Toy]
GO
ALTER TABLE [Chapter6].[RelatedProduct]  WITH CHECK ADD  CONSTRAINT [FK_RelatedProduct_Product] FOREIGN KEY([ProductId])
REFERENCES [Chapter6].[Product] ([ProductId])
GO
ALTER TABLE [Chapter6].[RelatedProduct] CHECK CONSTRAINT [FK_RelatedProduct_Product]
GO
ALTER TABLE [Chapter6].[RelatedProduct]  WITH CHECK ADD  CONSTRAINT [FK_RelatedProduct_Product1] FOREIGN KEY([RelatedProductId])
REFERENCES [Chapter6].[Product] ([ProductId])
GO
ALTER TABLE [Chapter6].[RelatedProduct] CHECK CONSTRAINT [FK_RelatedProduct_Product1]
GO
ALTER TABLE [Chapter6].[Ticket]  WITH CHECK ADD  CONSTRAINT [FK_Ticket_Vehicle] FOREIGN KEY([LicenseNumber])
REFERENCES [Chapter6].[Vehicle] ([LicenseNumber])
GO
ALTER TABLE [Chapter6].[Ticket] CHECK CONSTRAINT [FK_Ticket_Vehicle]
GO
ALTER TABLE [Chapter6].[WorkerTask]  WITH CHECK ADD  CONSTRAINT [FK_WorkerTask_Task] FOREIGN KEY([TaskId])
REFERENCES [Chapter6].[Task] ([TaskId])
GO
ALTER TABLE [Chapter6].[WorkerTask] CHECK CONSTRAINT [FK_WorkerTask_Task]
GO
ALTER TABLE [Chapter6].[WorkerTask]  WITH CHECK ADD  CONSTRAINT [FK_WorkerTask_Worker] FOREIGN KEY([WorkerId])
REFERENCES [Chapter6].[Worker] ([WorkerId])
GO
ALTER TABLE [Chapter6].[WorkerTask] CHECK CONSTRAINT [FK_WorkerTask_Worker]
GO
ALTER TABLE [Chapter7].[LineItem]  WITH CHECK ADD  CONSTRAINT [FK_LineItem_Invoice] FOREIGN KEY([InvoiceNumber])
REFERENCES [Chapter7].[Invoice] ([InvoiceNumber])
GO
ALTER TABLE [Chapter7].[LineItem] CHECK CONSTRAINT [FK_LineItem_Invoice]
GO
ALTER TABLE [Chapter7].[ServiceCall]  WITH CHECK ADD  CONSTRAINT [FK_ServiceCall_Technician] FOREIGN KEY([TechId])
REFERENCES [Chapter7].[Technician] ([TechId])
GO
ALTER TABLE [Chapter7].[ServiceCall] CHECK CONSTRAINT [FK_ServiceCall_Technician]
GO
ALTER TABLE [Chapter7].[Task]  WITH CHECK ADD  CONSTRAINT [FK_Task_Employee] FOREIGN KEY([AssignedId])
REFERENCES [Chapter7].[Employee] ([EmployeeNumber])
GO
ALTER TABLE [Chapter7].[Task] CHECK CONSTRAINT [FK_Task_Employee]
GO
ALTER TABLE [Chapter7].[Tasks]  WITH CHECK ADD  CONSTRAINT [FK_Tasks_Employees] FOREIGN KEY([EmployeeId])
REFERENCES [Chapter7].[Employees] ([EmployeeId])
GO
ALTER TABLE [Chapter7].[Tasks] CHECK CONSTRAINT [FK_Tasks_Employees]
GO
ALTER TABLE [Chapter8].[Book]  WITH CHECK ADD  CONSTRAINT [FK_Book_Category] FOREIGN KEY([CategoryId])
REFERENCES [Chapter8].[Category] ([CategoryId])
GO
ALTER TABLE [Chapter8].[Book] CHECK CONSTRAINT [FK_Book_Category]
GO
ALTER TABLE [Chapter8].[Competitor]  WITH CHECK ADD  CONSTRAINT [FK_Competitor_Event] FOREIGN KEY([EventId])
REFERENCES [Chapter8].[Event] ([EventId])
GO
ALTER TABLE [Chapter8].[Competitor] CHECK CONSTRAINT [FK_Competitor_Event]
GO
ALTER TABLE [Chapter8].[Donation]  WITH CHECK ADD  CONSTRAINT [FK_Donation_Donor] FOREIGN KEY([DonorId])
REFERENCES [Chapter8].[Donor] ([DonorId])
GO
ALTER TABLE [Chapter8].[Donation] CHECK CONSTRAINT [FK_Donation_Donor]
GO
ALTER TABLE [Chapter8].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Event_Venue] FOREIGN KEY([VenueId])
REFERENCES [Chapter8].[Venue] ([VenueId])
GO
ALTER TABLE [Chapter8].[Event] CHECK CONSTRAINT [FK_Event_Venue]
GO
ALTER TABLE [Chapter8].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Customer] FOREIGN KEY([CustomerId])
REFERENCES [Chapter8].[Customer] ([CustomerId])
GO
ALTER TABLE [Chapter8].[Order] CHECK CONSTRAINT [FK_Order_Customer]
GO
ALTER TABLE [Chapter8].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Order] FOREIGN KEY([OrderId])
REFERENCES [Chapter8].[Order] ([OrderId])
GO
ALTER TABLE [Chapter8].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Order]
GO
ALTER TABLE [Chapter8].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Product] FOREIGN KEY([ProductId])
REFERENCES [Chapter8].[Product] ([ProductId])
GO
ALTER TABLE [Chapter8].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Product]
GO
ALTER TABLE [Chapter8].[Reservation]  WITH CHECK ADD  CONSTRAINT [FK_Reservation_Schedule] FOREIGN KEY([ScheduleId])
REFERENCES [Chapter8].[Schedule] ([ScheduleId])
GO
ALTER TABLE [Chapter8].[Reservation] CHECK CONSTRAINT [FK_Reservation_Schedule]
GO
ALTER TABLE [Chapter8].[Schedule]  WITH CHECK ADD  CONSTRAINT [FK_Schedule_Train] FOREIGN KEY([TrainId])
REFERENCES [Chapter8].[Train] ([TrainId])
GO
ALTER TABLE [Chapter8].[Schedule] CHECK CONSTRAINT [FK_Schedule_Train]
GO
ALTER TABLE [Chapter8].[SpeakerTalk]  WITH CHECK ADD  CONSTRAINT [FK_SpeakerTalk_Speaker] FOREIGN KEY([SpeakerId])
REFERENCES [Chapter8].[Speaker] ([SpeakerId])
GO
ALTER TABLE [Chapter8].[SpeakerTalk] CHECK CONSTRAINT [FK_SpeakerTalk_Speaker]
GO
ALTER TABLE [Chapter8].[SpeakerTalk]  WITH CHECK ADD  CONSTRAINT [FK_SpeakerTalk_Talk] FOREIGN KEY([TalkId])
REFERENCES [Chapter8].[Talk] ([TalkId])
GO
ALTER TABLE [Chapter8].[SpeakerTalk] CHECK CONSTRAINT [FK_SpeakerTalk_Talk]
GO
ALTER TABLE [Chapter8].[Ticket]  WITH CHECK ADD  CONSTRAINT [FK_Ticket_Vehicle] FOREIGN KEY([VehicleId])
REFERENCES [Chapter8].[Vehicle] ([VehicleId])
GO
ALTER TABLE [Chapter8].[Ticket] CHECK CONSTRAINT [FK_Ticket_Vehicle]
GO
ALTER TABLE [Chapter8].[Violation]  WITH CHECK ADD  CONSTRAINT [FK_Violation_Ticket] FOREIGN KEY([TicketId])
REFERENCES [Chapter8].[Ticket] ([TicketId])
GO
ALTER TABLE [Chapter8].[Violation] CHECK CONSTRAINT [FK_Violation_Ticket]
GO
ALTER TABLE [chapter9].[Booking]  WITH CHECK ADD  CONSTRAINT [FK_Booking_TravelAgent] FOREIGN KEY([AgentId])
REFERENCES [chapter9].[TravelAgent] ([AgentId])
GO
ALTER TABLE [chapter9].[Booking] CHECK CONSTRAINT [FK_Booking_TravelAgent]
GO
ALTER TABLE [chapter9].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_Post] FOREIGN KEY([PostId])
REFERENCES [chapter9].[Post] ([PostId])
GO
ALTER TABLE [chapter9].[Comment] CHECK CONSTRAINT [FK_Comment_Post]
GO
ALTER TABLE [chapter9].[Enrollment]  WITH CHECK ADD  CONSTRAINT [FK_Enrollment_Course] FOREIGN KEY([CourseId])
REFERENCES [chapter9].[Course] ([CourseId])
GO
ALTER TABLE [chapter9].[Enrollment] CHECK CONSTRAINT [FK_Enrollment_Course]
GO
ALTER TABLE [chapter9].[Enrollment]  WITH CHECK ADD  CONSTRAINT [FK_Enrollment_Student] FOREIGN KEY([StudentId])
REFERENCES [chapter9].[Student] ([StudentId])
GO
ALTER TABLE [chapter9].[Enrollment] CHECK CONSTRAINT [FK_Enrollment_Student]
GO
ALTER TABLE [chapter9].[Media]  WITH CHECK ADD  CONSTRAINT [FK_Media_MediaType] FOREIGN KEY([MediaTypeId])
REFERENCES [chapter9].[MediaType] ([MediaTypeId])
GO
ALTER TABLE [chapter9].[Media] CHECK CONSTRAINT [FK_Media_MediaType]
GO
ALTER TABLE [chapter9].[MediaCategory]  WITH CHECK ADD  CONSTRAINT [FK_MediaCategory_Category] FOREIGN KEY([CategoryId])
REFERENCES [chapter9].[Category] ([CategoryId])
GO
ALTER TABLE [chapter9].[MediaCategory] CHECK CONSTRAINT [FK_MediaCategory_Category]
GO
ALTER TABLE [chapter9].[MediaCategory]  WITH CHECK ADD  CONSTRAINT [FK_MediaCategory_Media] FOREIGN KEY([MediaId])
REFERENCES [chapter9].[Media] ([MediaId])
GO
ALTER TABLE [chapter9].[MediaCategory] CHECK CONSTRAINT [FK_MediaCategory_Media]
GO
ALTER TABLE [chapter9].[Payment]  WITH CHECK ADD  CONSTRAINT [FK_Payment_Invoice] FOREIGN KEY([InvoiceId])
REFERENCES [chapter9].[Invoice] ([InvoiceId])
GO
ALTER TABLE [chapter9].[Payment] CHECK CONSTRAINT [FK_Payment_Invoice]
GO
ALTER TABLE [chapter9].[Phone]  WITH CHECK ADD  CONSTRAINT [FK_Phone_Customer] FOREIGN KEY([CustomerId])
REFERENCES [chapter9].[Customer] ([CustomerId])
GO
ALTER TABLE [chapter9].[Phone] CHECK CONSTRAINT [FK_Phone_Customer]
GO
USE [master]
GO
ALTER DATABASE [EFRecipes] SET  READ_WRITE 
GO
