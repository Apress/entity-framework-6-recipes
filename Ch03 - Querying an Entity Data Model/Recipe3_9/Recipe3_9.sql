create table Chapter3.Worker (
  WorkerID int not null primary key identity,
  Name varchar(100))
go

create table Chapter3.Accident (
  AccidentID int not null primary key identity,
  Description varchar(100),
  Severity int,
  WorkerID int
)

alter table Chapter3.Accident add foreign key (WorkerID) references Chapter3.Worker (WorkerID)
go
