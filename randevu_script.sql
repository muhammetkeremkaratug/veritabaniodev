create database HastaDoktorDB

use HastaDoktorDB
 
create table Doktorlar(

  DoctorId int primary key identity,

  Ad nvarchar(25) not null,

  Soyad nvarchar(25) not null

)

create table Hastalar(

   HastaId int primary key identity,

   Ad nvarchar(25) not null,

   Soyad nvarchar(25) not null

)

create table Mesajlar(

   MesajId int primary key identity(1,1),

   Icerik nvarchar(MAX),

   HastaId int foreign key references Hastalar(HastaId),

   DoktorId int foreign key references Doktorlar(DoctorId),

   Tarih datetime

)
 
insert Doktorlar(Ad,Soyad) values ('Hakan','Þahin'),

                                  ('Kerem','Karatuð'),

								  ('Ýlayda','Çetin')
 
insert Hastalar(Ad,Soyad) values ('Mert','Kaya'),

                                 ('Ayþe','Kartal'),

						         ('Koray','Kara')
 
insert Mesajlar(DoktorId,HastaId,Icerik,Tarih) 

values (2,1,'Merhaba bir randevum var',GETDATE()),

       (3,2,'Merhaba nasýlsýn',GETDATE()),

       (1,3,'Merhaba koray',GETDATE())
 
select Doktorlar.Ad as Doktor,Hastalar.Ad as Hasta,Mesajlar.Icerik Mesaj from Mesajlar,Doktorlar,Hastalar

where Mesajlar.DoktorId = Doktorlar.DoctorId and Mesajlar.HastaId = Hastalar.HastaId
 
 
create database DogruDb

use DogruDb
 
create table Roles(

   Id int primary key identity,

   RoleName nvarchar(30) not null

)

create table MyUsers(

  Id int primary key identity,

  FirstName nvarchar(25),

  LastName nvarchar(25),

  RoleId int foreign key references Roles(Id)

)
 
create table MyMessages(

  MesajId int primary key identity,

  Content nvarchar(500) not null,

  SenderId int foreign key references MyUsers(Id),

  ReceiverId int foreign key references MyUsers(Id),

  SendDate datetime

)
 
-- Roles(RoleId,RoleName)

-- Users(UserId,FirstName,LastName,PhoneNumber)

-- Messages(MessageId,Content,SenderId,ReceiverId,CreatedDate)
 
insert into Roles(RoleName) values ('Doktor'),('Hasta')
 
insert MyUsers(FirstName,LastName,RoleId) 

values ('Kerem','Karatuð',1),

       ('Ýlayda','Çetin',2)
 
insert MyMessages(Content,SendDate,SenderId,ReceiverId)

values ('Merhaba bir randevu olusturmak istiyorum',getDatE(),2,1),

       ('Tabiki ne zaman',getDatE(),1,2)
 
select 

r.RoleName as Role,

sender.FirstName+' '+sender.LastName as Gonderici,

mm.Content as Mesaj,

receiver.FirstName+' '+receiver.LastName as Alici

from Roles as r 

join MyUsers as sender 

on r.Id = sender.RoleId

join MyMessages as mm 

on sender.Id = mm.SenderId

join MyUsers as receiver

on mm.ReceiverId = receiver.Id