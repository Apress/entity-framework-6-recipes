create table Chapter3.Associate (
  AssociateID int not null primary key identity,
  Name varchar(100))
go

create table Chapter3.AssociateSalary (
  SalaryID int not null primary key identity,
  AssociateID int not null,
  Salary varchar(100),
  SalaryDate date)
go

alter table Chapter3.AssociateSalary add foreign key (AssociateID) references Chapter3.Associate (AssociateID)
go
