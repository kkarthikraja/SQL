CREATE DATABASE IF NOT EXISTS Art_Gallery;

USE Art_Gallery;

CREATE table Artist(Artist_ID int AUTO_INCREMENT not null primary key, FirstName varchar(20) not null, MiddleName varchar(20) not null, LastName varchar(20) not null, Address varchar(100) not null, Phone int not null);

CREATE table Gallery(Gallery_ID int AUTO_INCREMENT not null primary key, Gallery_Name varchar(40) not null, URL varchar(40) not null, Location varchar(100) not null );

CREATE table Exhibition(Ex_ID int AUTO_INCREMENT not null primary key, Ex_Name varchar(40) not null, Ex_Location varchar(100) not null, Ex_type varchar(40) not null, Start_Date date not null, End_Date date not null);

CREATE table Customer(C_ID int AUTO_INCREMENT not null primary key, C_Email varchar(40) not null unique, C_Name varchar(40) not null, Address varchar(100) not null, Phone int not null);

CREATE table Painting(Painting_ID int AUTO_INCREMENT not null primary key, Title varchar(40) not null, URL varchar(40) not null, Year year(4) not null, Type varchar(40) not null, Cost int not null, Likes int not null);

CREATE table Display(Ex_ID int not null unique, Painting_ID int not null unique);

ALTER table Gallery add column Artist_ID int not null;

ALTER table Gallery add foreign key(Artist_ID) references Artist(Artist_ID) on delete cascade;

ALTER table Painting add column Artist_ID int not null;

ALTER table Painting add foreign key (Artist_ID) references Artist(Artist_ID) on delete cascade;

ALTER table Painting add column Gallery_ID int not null;

ALTER table Painting add foreign key (Gallery_ID) references Gallery(Gallery_ID) on delete cascade;

ALTER table Painting add column C_ID int not null;

ALTER table Painting add foreign key (C_ID) references Customer(C_ID) on delete cascade;

ALTER table Display add foreign key (Ex_ID) references Exhibition(Ex_ID) on delete cascade;

ALTER table Display add foreign key (Painting_ID) references Painting(Painting_ID) on delete cascade;