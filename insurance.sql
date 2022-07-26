create database Insurance_1BM20CS031;
use Insurance_1BM20CS031;

-- table person (driver-id #: String, name: String, address: String)

create table Person(Driver_ID varchar(40), name varchar(40), address varchar(20));
desc Person;
alter table Person add primary key(Driver_ID);

insert into Person values ('A01', 'richard', 'Srinivas Nagar'),('A02', 'pradeep', 'Rajaji Nagar'),('A03', 'smith', 'Ashok Nagar'),('A04', 'venu', 'NR colony'),('A05','john', 'Hanumath Nagar');
select * from Person;

--  table car (Regno: String, model: String, year: int)

create table car(Reg_no varchar(20) primary key, model varchar(20), year int);
desc car;

insert into car values('KA052250','Indica',1990),('KA031181','Lancer',1957),('KA095477','Toyota',1998),('KA053048','Honda',2008),('KA041702','Audi',2005);
select * from car;

-- create table accident (report-number: int, date: date, location: String)

create table accident(report_number int, date date, location varchar(30));
alter table accident add primary key(report_number);
desc accident;

	 -- YYYY-MM-DD   DATE FORMAT

insert into accident values(11,'2020-11-10','Mysore Road'),(12,'2020-12-11','South end circle'),(13,'2003-09-10','Bull Temple Road'),(14,'2002-10-14','Srinivas Nagar'),(15,'2001-10-30','Kanakapura Road');
select * from accident;

-- create table owns  (driver-id #: String, Regno: String)

create table owns(Driver_ID varchar(40), Reg_no varchar(20), foreign key(Driver_ID) references Person(Driver_ID), foreign key (Reg_no) references car(Reg_no));
desc owns;
insert into owns values('A01','KA052250'),('A02','KA031181'),('A03','KA095477'),('A04','KA053048'),('A05','KA041702');
select * from owns;

-- create table participated (driver-id: String, Regno: String, report-number: int, damage-amount: int)

create table participated(Driver_ID varchar(40), Reg_no varchar(20), report_number int, damage_amount int);
alter table participated add foreign key(Driver_ID) references Person(Driver_ID), add foreign key (Reg_no) references car(Reg_no), add  foreign key (report_number) references accident(report_number);
desc participated;

insert into participated values('A01','KA031181',11,100),('A02','KA041702',12,200),('A03','KA052250',13,300),('A04','KA053048',14,400),('A05','KA095477',15,500);
select * from participated;

-- a
update participated set damage_amount = 25000 where report_number = 12; 
select * from participated;

	-- b

delete from accident where report_number = 16;

insert into accident values(16, '2022-11-11', 'Hanumath nagar' );
select * from accident;

 -- (iv) 
select distinct count(reg_no) from participated p,accident a where p.report_number=a.report_number and a.date like '2008%';

-- (v)
select count(report_number) from participated p, car c where p.reg_no = c.reg_no and c.model = 'Lancer';

-- ADDITIONAL QUERIES:
 -- 1)	LIST THE ENTIRE PARTICIPATED RELATION IN THE DESCENDING ORDER OF DAMAGE AMOUNT
 
select * from participated order by damage_amount desc;

-- 2)	FIND THE AVERAGE DAMAGE AMOUNT
select avg(damage_amount) from participated;

-- 3)	DELETE THE TUPLE WHOSE DAMAGE AMOUNT IS BELOW THE AVERAGE DAMAGE AMOUNT
delete participated.* from participated WHERE damage_amount < 5260.0000;

-- 4)	LIST THE NAME OF DRIVERS WHOSE DAMAGE IS GREATER THAN THE AVERAGE DAMAGE AMOUNT.
select name from person x, participated y where y.driver_id=x.driver_id and   damage_amount  > (select avg(damage_amount) from participated);

-- 5)	FIND MAXIMUM DAMAGE AMOUNT.
select max(damage_amount) from participated;

-- Extra 
  -- 1
insert into car values('KA05MC001','Audi',2018); 
select * from car;

insert into accident values(16,'2019-03-01','Bull temple road');
select * from accident;

insert into owns values('A03','KA05MC001');

insert into participated values('A03','KA05MC001',16,75000);

  -- 2
  select  o.driver_id,c.* from owns o,car c where o.Reg_no=c.Reg_no and c.model='Lancer';
  
   -- 3
   select Reg_no from participated p, accident a where p.report_number=a.report_number and a.date  between  '2003-01-01' and  '2005-01-01';
                                                            
   -- 4
   select count(*) from accident where location like 'Mysore%';
   
   -- 5
   select x.*,y.damage_amount from person x,participated y where x.driver_id=y.driver_id and y.damage_amount > (select avg(damage_amount) from participated);
                                                        
	-- 6
    select count(*) from accident where date like '2008%';
  
  -- 7
  delete c.model from car c, person p, owns o where o.Reg_no=c.Reg_no and o.driver_id=p.driver_id and p.name='john' and  c.model='Audi';
   