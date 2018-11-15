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

--1a
select distinct Student.Sid, Student.Sname 
from Student, Buys, Cites 
where Student.Sid = Buys.Sid and Buys.BookNo = Cites.BookNo;

--1b
select distinct s.Sid, s.sname 
from student s, Major m1, Major m2 
where s.Sid = m1.Sid and s.Sid = m2.Sid and m1.Major <> m2.Major;

--1c
with 
E1 as (select distinct Buys.Sid from Buys), 
E2 as (select distinct B1.Sid from Buys B1, Buys B2 where B1.Sid = B2.Sid and B1.BookNo <> B2.BookNo) 
(select * from E1) except (select * from E2);

--1d
with 
E1 as (select distinct B.BookNo, B.Title from Book B), 
E2 as (select distinct Buys.BookNo, Book.Title from Buys, Book where Buys.Sid <> 1001 and Buys.BookNo = Book.BookNo) 
(select BookNo, Title from E1) except (select BookNo, Title from E2);
--1e
select distinct Student.Sid, Student.Sname 
from Student, Buys B1, Buys B2, Book BB1, Book BB2 
where Student.Sid = B1.Sid and Student.Sid = B2.Sid 
and B1.BookNo <> B2.BookNo and B1.BookNo = BB1.BookNo 
and B2.BookNo = BB2.BookNo and BB1.Price < 50 and BB2.Price < 50;

--1f:
with 
E1 as (select distinct Major.Sid, Book.BookNo from Major, Book where Major.Major = 'CS'), 
E2 as (select distinct Buys.Sid, Buys.BookNo from Buys), 
E3 as (select * from E1 except select * from E2) 
select distinct BookNo from E3;
--1g:
with 
E1 as (select distinct B1.BookNo from Book B1), 
E2 as (select distinct Cites.CitedBookNo from Cites, Book where Cites.BookNo = Book.BookNo and Book.Price > 50) 
(select BookNo from E1) except (select CitedBookNo from E2);
--1h:
with 
E1 as (select distinct Buys.Sid as AA, Buys.BookNo as BB, Book.BookNo as CC from Buys, Book), 
E2 as (select distinct Buys.Sid as AA, Buys.BookNo as BB, Cites.CitedBookNo as CC from Buys, Cites where Buys.BookNo = Cites.BookNo), 
E3 as (select * from E1 except select * from E2) 
select distinct (AA, CC) from E3;
--1i:
with 
E1 as (select distinct Major.Sid from Major where Major.Major = 'CS'), 
E2 as (select distinct E1.Sid, Buys.BookNo from E1 inner join Buys on E1.Sid = Buys.Sid), 
E3 as (select distinct (B1.BookNo, B2.BookNo) from Book B1 cross join Book B2 where B1.BookNo <> B2.BookNo), 
E4 as (select distinct E2.BookNo as b1, E2.Sid, Book.BookNo as b2 from E2 cross join Book), 
E5 as (select distinct Book.BookNo as b1, E2.Sid, E2.BookNo as b2 from E2 cross join Book), 
E6 as (select distinct (b1, b2) from (select * from E4 except select * from E5) q), 
E7 as (select distinct (b1, b2) from (select * from E5 except select * from E4) q) 
select * from E3 except select * from E6
intersect 
select * from E3 except select * from E7;
--1j
with 
E1 as (select S1.Sid as Sid1, S2.Sid as Sid2, B1.BookNo from Student S1, Student S2, Buys B1 where B1.Sid = S1.Sid), 
E2 as (select S1.Sid as Sid1, S2.Sid as Sid2, B2.BookNo from Student S1, Student S2, Buys B2 where B2.Sid = S2.Sid), 
E3 as (select distinct k.Sid1, k.Sid2 from (select * from E1 except select * from E2) k), 
E4 as (select distinct S1.Sid as SSid1, S2.Sid as SSid2 from Student S1, Student S2 where S1.Sid <> S2.Sid), 
E5 as (select * from E4 except select * from E3) 
select * from E5;
--2a
select distinct m.Sid, m.Major 
from Major m, Buys t, Book b 
where t.BookNo = b.BookNo and b.Price < 20 and m.Sid = t.Sid;
--2b
with 
p1 as (select distinct t.Sid, b.BookNo from Buys t, Book b where t.BookNo = b.BookNo), 
p2 as (select distinct t.Sid, b.BookNo from Buys t, Book b, Buys t1, Book b1 where t1.BookNo = b1.BookNo and t1.Sid = t.Sid and not b.Price <= b1.Price) 
(select * from p1) except (select * from p2);
--2c:
--step 1:
select distinct s.Sid, s.Sname 
from Student s, Major m 
where m.Major = 'CS' and s.Sid = m.Sid and exists(
	select 1 
	from Buys t, Cites c, Book b1, Book b2 
	where s.Sid = t.Sid and t.BookNo = c.CitedBookNo and c.CitedBookNo = b1.BookNo and c.BookNo = b2.BookNo and b1.Price > b2.Price);
--step 2:
select distinct s.Sid, s.Sname 
from Student s, Major m, Buys t, Cites c, Book b1, Book b2 
where m.Major = 'CS' and s.Sid = m.Sid and s.Sid = t.Sid 
and t.BookNo = c.CitedBookNo and c.CitedBookNo = b1.BookNo 
and c.BookNo = b2.BookNo and b1.Price > b2.Price;

--2d:
select distinct b.BookNo, b.Title
from Book b, Major m, Buys t
where m.Major='CS' and m.sid = t.sid and not t.BookNo = b.BookNo;

--2e
SELECT DISTINCT Q.BookNo, Q.Title 
FROM ((select b.bookno, b.title
	  from book b)
	  EXCEPT
	  (SELECT z.BookNo, z.Title
		FROM ((SELECT B.BookNo, B.Title, S.Sid
				FROM Book B, Student S, Major M1, Major M2
				WHERE M1.Major = 'CS' AND M2.Major ='Math' AND S.Sid = M1.Sid AND S.Sid = M2.Sid)
			   EXCEPT
			   (SELECT B.BookNo, B.Title, S.Sid
				FROM Book B, Student S, buys T
				WHERE T.BookNo = B.BookNo AND T.Sid = S.Sid) )z)
	  ) Q;
\c postgres;
drop database KF;