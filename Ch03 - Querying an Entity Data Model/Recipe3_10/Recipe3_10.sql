create table Chapter3.Product (
  ProductID int not null primary key identity,
  Name varchar(100))
go

create table Chapter3.TopSelling (
  ProductID int not null primary key,
  Rating int)
go

alter table Chapter3.TopSelling add foreign key (ProductID) references Chapter3.Product (ProductID)
go
