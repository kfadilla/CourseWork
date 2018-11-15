--KFADILLA
--work with xinze fan, rui xi, yifan yin, yuyao ba
--1

create database KF;
\c kf;
create table Student(Sid integer primary key, Sname varchar(15));
create table Major(Sid integer references Student(Sid), Major varchar(15), primary key (Sid, Major));
create table Book(BookNo integer primary key, Title varchar(30), Price integer);
create table Cites(BookNo integer references Book(BookNo), CitedBookNo integer references Book(BookNo), primary key (BookNo, CitedBookNo));
create table Buys(Sid integer references Student(Sid), BookNo integer references Book(BookNo), primary key (Sid, BookNo));

insert into Student values(1001, 'Jean');
insert into Student values(1002, 'Maria');
insert into Student values(1003, 'Anna');
insert into Student values(1004, 'Chin');
insert into Student values(1005, 'John');
insert into Student values(1006, 'Ryan');
insert into Student values(1007, 'Catherine');
insert into Student values(1008, 'Emma');
insert into Student values(1009, 'Jan');
insert into Student values(1010, 'Linda');
insert into Student values(1011, 'Nick');
insert into Student values(1012, 'Eric');
insert into Student values(1013, 'Lisa');
insert into Student values(1014, 'Filip');
insert into Student values(1015, 'Dirk');
insert into Student values(1016, 'Mary');
insert into Student values(1017, 'Ellen');
insert into Student values(1020, 'Greg');
insert into Student values(1022, 'Qin');
insert into Student values(1023, 'Melanie');
insert into Student values(1040, 'Pam');
insert into Major values(1001, 'Math');
insert into Major values(1001, 'Physics');
insert into Major values(1002, 'CS');
insert into Major values(1002, 'Math');
insert into Major values(1003, 'Math');
insert into Major values(1004, 'CS');
insert into Major values(1006, 'CS');
insert into Major values(1007, 'CS');
insert into Major values(1007, 'Physics');
insert into Major values(1008, 'Physics');
insert into Major values(1009, 'Biology');
insert into Major values(1010, 'Biology');
insert into Major values(1011, 'CS');
insert into Major values(1011, 'Math');
insert into Major values(1012, 'CS');
insert into Major values(1013, 'CS');
insert into Major values(1013, 'Psychology');
insert into Major values(1014, 'Theater');
insert into Major values(1015, 'Chemistry');
insert into Major values(1017, 'Anthropology');
insert into Major values(1022, 'CS');
insert into Book values(2001, 'Databases', 40);
insert into Book values(2002, 'OperatingSystems', 25);
insert into Book values(2003, 'Networks', 20);
insert into Book values(2004, 'AI', 45);
insert into Book values(2005, 'DiscreteMathematics', 20);
insert into Book values(2006, 'SQL', 25);
insert into Book values(2007, 'ProgrammingLanguages', 15);
insert into Book values(2008, 'DataScience', 50);
insert into Book values(2009, 'Calculus', 10);
insert into Book values(2010, 'Philosophy', 25);
insert into Book values(2011, 'Anthropology', 50);
insert into Book values(2012, 'Geometry', 80);
insert into Book values(2013, 'RealAnalysis', 35);
insert into Book values(2014, 'Topology', 70);
insert into Cites values(2008, 2011);
insert into Cites values(2008, 2012);
insert into Cites values(2001, 2002);
insert into Cites values(2001, 2007);
insert into Cites values(2002, 2003);
insert into Cites values(2003, 2001);
insert into Cites values(2003, 2004);
insert into Cites values(2003, 2002);
insert into Cites values(2010, 2001);
insert into Cites values(2010, 2002);
insert into Cites values(2010, 2003);
insert into Cites values(2010, 2004);
insert into Cites values(2010, 2005);
insert into Cites values(2010, 2006);
insert into Cites values(2010, 2007);
insert into Cites values(2010, 2008);
insert into Cites values(2010, 2009);
insert into Cites values(2010, 2011);
insert into Cites values(2010, 2013);
insert into Cites values(2010, 2014);
insert into Cites values(2012, 2001);
insert into Buys values(1001, 2002);
insert into Buys values(1001, 2007);
insert into Buys values(1001, 2009);
insert into Buys values(1001, 2011);
insert into Buys values(1001, 2013);
insert into Buys values(1002, 2001);
insert into Buys values(1002, 2002);
insert into Buys values(1002, 2007);
insert into Buys values(1002, 2011);
insert into Buys values(1002, 2012);
insert into Buys values(1002, 2013);
insert into Buys values(1003, 2002);
insert into Buys values(1003, 2007);
insert into Buys values(1003, 2011);
insert into Buys values(1003, 2012);
insert into Buys values(1003, 2013);
insert into Buys values(1004, 2006);
insert into Buys values(1004, 2007);
insert into Buys values(1004, 2008);
insert into Buys values(1004, 2011);
insert into Buys values(1004, 2012);
insert into Buys values(1004, 2013);
insert into Buys values(1005, 2007);
insert into Buys values(1005, 2011);
insert into Buys values(1005, 2012);
insert into Buys values(1005, 2013);
insert into Buys values(1006, 2006);
insert into Buys values(1006, 2007);
insert into Buys values(1006, 2008);
insert into Buys values(1006, 2011);
insert into Buys values(1006, 2012);
insert into Buys values(1006, 2013);
insert into Buys values(1007, 2001);
insert into Buys values(1007, 2002);
insert into Buys values(1007, 2003);
insert into Buys values(1007, 2007);
insert into Buys values(1007, 2008);
insert into Buys values(1007, 2009);
insert into Buys values(1007, 2010);
insert into Buys values(1007, 2011);
insert into Buys values(1007, 2012);
insert into Buys values(1007, 2013);
insert into Buys values(1008, 2007);
insert into Buys values(1008, 2011);
insert into Buys values(1008, 2012);
insert into Buys values(1008, 2013);
insert into Buys values(1009, 2001);
insert into Buys values(1009, 2002);
insert into Buys values(1009, 2011);
insert into Buys values(1009, 2012);
insert into Buys values(1009, 2013);
insert into Buys values(1010, 2001);
insert into Buys values(1010, 2002);
insert into Buys values(1010, 2003);
insert into Buys values(1010, 2011);
insert into Buys values(1010, 2012);
insert into Buys values(1010, 2013);
insert into Buys values(1011, 2002);
insert into Buys values(1011, 2011);
insert into Buys values(1011, 2012);
insert into Buys values(1012, 2011);
insert into Buys values(1012, 2012);
insert into Buys values(1013, 2001);
insert into Buys values(1013, 2011);
insert into Buys values(1013, 2012);
insert into Buys values(1014, 2008);
insert into Buys values(1014, 2011);
insert into Buys values(1014, 2012);
insert into Buys values(1017, 2001);
insert into Buys values(1017, 2002);
insert into Buys values(1017, 2003);
insert into Buys values(1017, 2008);
insert into Buys values(1017, 2012);
insert into Buys values(1020, 2001);
insert into Buys values(1020, 2012);
insert into Buys values(1022, 2014);
insert into Buys values(1023, 2012);
insert into Buys values(1023, 2014);
insert into Buys values(1040, 2002);
--1 from
select distinct s.sid,s.sname, b.bookno, b.title from student s 
	cross join book b 
	inner join buys t on
		 ((s.sname = 'Eric' or s.sname = 'Anna') and s.sid = t.sid and b.price > 20 and t.bookno = b.bookno);

--to
Select distinct q1.sid, q1.sname, Buys.bookno, q2.title from
	(select * from student s where s.sname = 'Eric' or s.sname = 'Anna') q1
	natural join Buys
	natural join (select * from book b where b.price > 20) q2;

--2 from
select distinct s.sid from student s 
	cross join book b 
	inner join buys t on 
		((s.sname = 'Eric' or s.sname = 'Anna') and s.sid = t.sid and b.price > 20 and t.bookno = b.bookno);

--to
Select distinct q1.sid from
	(select * from student s where s.sname = 'Eric' or s.sname = 'Anna') q1
	natural join Buys
	natural join (select * from book b where b.price > 20) q3;

--3 from
select distinct s1.sid, b1.price as b1_price, b2.price as b2_price from
 (select s.sid from student s where s.sname <> 'Eric') s1 
 cross join book b2 
 inner join book b1 on (b1.bookno <> b2.bookno and b1.price > 60 and b2.price >= 50)
 inner join buys t1 on (t1.bookno = b1.bookno and t1.sid = s1.sid) 
 inner join buys t2 on (t2.bookno = b2.bookno and t2.sid = s1.sid);

 --to
 Select distinct q1.sid, q2.price1 as b1_price, q3.price2 as b2_price from
 	(select s.sid from student s where s.sname <> 'Eric') q1
 	natural join ((select * from buys) subq0
 	natural join (select b.bookno, b.price as price1 from book b where b.price > 60) subq1) q2
 	inner join ((select * from buys) subq3
 	natural join (select b.bookno, b.price as price2 from Book b where b.price >=50)subq4)q3
 		on (q2.bookno <> q3.bookno and q2.sid = q3.sid);

--4 from
select q.sid from (select s.sid, s.sname from student s
	except
	select s.sid, s.sname from student s
	inner join buys t on (s.sid = t.sid)
	inner join book b on (t.bookno = b.bookno and b.price > 50)) q;

--to
select q.sid from (select s.sid,s.sname from student s
	except
	select s.sid, s.sname from student s
	natural join Buys
	natural join (select b.bookno, b.price from book b where b.price >50) subq1)q;

--5from
select q.sid, q.sname from 
(select s.sid, s.sname, 2007 as bookno from student s
	cross join book b
	intersect
	select s.sid, s.sname, b.bookno from student s
	cross join book b
	inner join buys t on 
	(s.sid = t.sid and t.bookno = b.bookno and b.price <25)) q;

--to
select q.sid,q.sname from
	(select s.sid, s.sname, 2007 as bookno from student s
		cross join book b
		intersect
		select s.sid, s.sname, subq1.bookno from student s
		natural join Buys
		natural join (select b.bookno, b.price from book b where b.price <25) subq1) q;

--6 from
select distinct q.bookno from 
	(select s.sid, s.sname, b.bookno, b.title from student s
		cross join book b
		except
		select s.sid, s.sname, b.bookno, b.title from student s
		cross join book b
		inner join buys t 
			on (s.sid = t.sid and t.bookno = b.bookno and b.price <20)) q;

--to
select distinct q.bookno from
	(select * from student s
		cross join (select b.bookno, b.title from book b)q1
		except
		select s.sid, s.sname, subq2.bookno,subq2.title
		from student s
		natural join Buys
		natural join (select b.bookno, b.title from book b where b.price < 20) subq2)q;
 \c postgres;
drop database KF;