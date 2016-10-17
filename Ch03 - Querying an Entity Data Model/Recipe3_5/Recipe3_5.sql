create table Chapter3.BlogPost (
  PostID int primary key not null identity,
  Title varchar(100),
  Description varchar(max))
go

create table Chapter3.Comment (
  CommentID int primary key not null,
  Comments varchar(max),
  PostID int)
go

alter table Chapter3.Comment add foreign key (PostID) references Chapter3.BlogPost (PostID)
go
