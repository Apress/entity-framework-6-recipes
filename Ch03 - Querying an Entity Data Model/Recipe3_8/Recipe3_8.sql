create table Chapter3.Book (
  BookID int primary key not null identity,
  Title varchar(100),
  CategoryID int)
go

create table Chapter3.Category (
  CategoryID int primary key not null identity,
  Name varchar(100))
go

alter table Chapter3.Book add foreign key (CategoryID) references Chapter3.Category (CategoryID)
go
