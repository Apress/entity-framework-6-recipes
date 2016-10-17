create table Chapter3.Account (
  AccountID int not null primary key identity,
  City varchar(100),
  State varchar(100))
go

create table Chapter3.CustomerOrder (
  OrderID int not null primary key identity,
  Amount decimal,
  AccountID int not null,
  ShipCity varchar(100),
  ShipState varchar(100))
go

alter table Chapter3.CustomerOrder add foreign key (AccountID) references Chapter3.Account (AccountID)
go
