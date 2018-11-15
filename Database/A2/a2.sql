 --KFADILLA
--1
create database KF;

\c kf;
CREATE TABLE Student
(
	Sid INTEGER PRIMARY KEY,
	Sname VARCHAR(15)
);

CREATE TABLE Major
(
	Sid INTEGER REFERENCES Student(Sid),
	Major VARCHAR(15),
	PRIMARY KEY(Sid, Major)
);

CREATE TABLE Book
(
	BookNo INTEGER PRIMARY KEY,
	Title VARCHAR(30),
	Price INTEGER
);

CREATE TABLE Cites
(
	BookNo INTEGER REFERENCES Book(BookNo),
	CitedBookNo INTEGER REFERENCES Book(BookNo),
	PRIMARY KEY(BookNo, CitedBookNo)
);

CREATE TABLE Buys(
	Sid INTEGER REFERENCES Student(Sid),
	BookNo INTEGER REFERENCES Book(BookNo)
);

INSERT INTO Book VALUES(2001,	'Databases',	40);
INSERT INTO Book VALUES(2002,	'OperatingSystems',	25);
INSERT INTO Book VALUES(2003,	'Networks',	20);
INSERT INTO Book VALUES(2004,	'AI',	45);
INSERT INTO Book VALUES(2005,	'DiscreteMathematics',	20);
INSERT INTO Book VALUES(2006,	'SQL',	25);
INSERT INTO Book VALUES(2007,	'ProgrammingLanguages',	15);
INSERT INTO Book VALUES(2008,	'DataScience',	50);
INSERT INTO Book VALUES(2009,	'Calculus',	10);
INSERT INTO Book VALUES(2010,	'Philosophy',	25);
INSERT INTO Book VALUES(2012,	'Geometry',	80);
INSERT INTO Book VALUES(2013,	'RealAnalysis',35);
INSERT INTO Book VALUES(2011,	'Anthropology',	50);
INSERT INTO Book VALUES(2014,	'Topology',	70);

INSERT INTO Student VALUES(1001, 'Jean');
INSERT INTO Student VALUES(1002, 'Maria');
INSERT INTO Student VALUES(1003, 'Anna');
INSERT INTO Student VALUES(1004, 'Chin');
INSERT INTO Student VALUES(1005, 'John');
INSERT INTO Student VALUES(1006, 'Ryan');
INSERT INTO Student VALUES(1007, 'Catherine');
INSERT INTO Student VALUES(1008, 'Emma');
INSERT INTO Student VALUES(1009, 'Jan');
INSERT INTO Student VALUES(1010, 'Linda');
INSERT INTO Student VALUES(1011, 'Nick'); 
INSERT INTO Student VALUES(1012, 'Eric'); 
INSERT INTO Student VALUES(1013, 'Lisa'); 
INSERT INTO Student VALUES(1014, 'Filip');
INSERT INTO Student VALUES(1015, 'Dirk'); 
INSERT INTO Student VALUES(1016, 'Mary'); 
INSERT INTO Student VALUES(1017, 'Ellen'); 
INSERT INTO Student VALUES(1020, 'Greg'); 
INSERT INTO Student VALUES(1022, 'Qin'); 
INSERT INTO Student VALUES(1023, 'Melanie'); 
INSERT INTO Student VALUES(1040, 'Pam');
INSERT INTO Cites VALUES(2012,	2001);
INSERT INTO Cites VALUES(2008,	2011);
INSERT INTO Cites VALUES(2008,	2012);
INSERT INTO Cites VALUES(2001,	2002);
INSERT INTO Cites VALUES(2001,	2007);
INSERT INTO Cites VALUES(2002,	2003);
INSERT INTO Cites VALUES(2003,	2001);
INSERT INTO Cites VALUES(2003,	2004);
INSERT INTO Cites VALUES(2003,	2002);
INSERT INTO Cites VALUES(2010,	2001);
INSERT INTO Cites VALUES(2010,	2002);
INSERT INTO Cites VALUES(2010,	2003);
INSERT INTO Cites VALUES(2010,	2004);
INSERT INTO Cites VALUES(2010,	2005);
INSERT INTO Cites VALUES(2010,	2006);
INSERT INTO Cites VALUES(2010,	2007);
INSERT INTO Cites VALUES(2010,	2008);
INSERT INTO Cites VALUES(2010,	2009);
INSERT INTO Cites VALUES(2010,	2011);
INSERT INTO Cites VALUES(2010,	2013);
INSERT INTO Cites VALUES(2010,	2014);
INSERT INTO Buys VALUES(1023,	2012);
INSERT INTO Buys VALUES(1023,	2014);
INSERT INTO Buys VALUES(1040,	2002);
INSERT INTO Buys VALUES(1001,	2002);
INSERT INTO Buys VALUES(1001,	2007);
INSERT INTO Buys VALUES(1001,	2009);
INSERT INTO Buys VALUES(1001,	2011);
INSERT INTO Buys VALUES(1001,	2013);
INSERT INTO Buys VALUES(1002,	2001);
INSERT INTO Buys VALUES(1002,	2002);
INSERT INTO Buys VALUES(1002,	2007);
INSERT INTO Buys VALUES(1002,	2011);
INSERT INTO Buys VALUES(1002,	2012);
INSERT INTO Buys VALUES(1002,	2013);
INSERT INTO Buys VALUES(1003,	2002);
INSERT INTO Buys VALUES(1003,	2007);
INSERT INTO Buys VALUES(1003,	2011);
INSERT INTO Buys VALUES(1003,	2012);
INSERT INTO Buys VALUES(1003,	2013);
INSERT INTO Buys VALUES(1004,	2006);
INSERT INTO Buys VALUES(1004,	2007);
INSERT INTO Buys VALUES(1004,	2008);
INSERT INTO Buys VALUES(1004,	2011);
INSERT INTO Buys VALUES(1004,	2012);
INSERT INTO Buys VALUES(1004,	2013);
INSERT INTO Buys VALUES(1005,	2007);
INSERT INTO Buys VALUES(1005,	2011);
INSERT INTO Buys VALUES(1005,	2012);
INSERT INTO Buys VALUES(1005,	2013);
INSERT INTO Buys VALUES(1006,	2006);
INSERT INTO Buys VALUES(1006,	2007);
INSERT INTO Buys VALUES(1006,	2008);
INSERT INTO Buys VALUES(1006,	2011);
INSERT INTO Buys VALUES(1006,	2012);
INSERT INTO Buys VALUES(1006,	2013);
INSERT INTO Buys VALUES(1007,	2001);
INSERT INTO Buys VALUES(1007,	2002);
INSERT INTO Buys VALUES(1007,	2003);
INSERT INTO Buys VALUES(1007,	2007);
INSERT INTO Buys VALUES(1007,	2008);
INSERT INTO Buys VALUES(1007,	2009);
INSERT INTO Buys VALUES(1007,	2010);
INSERT INTO Buys VALUES(1007,	2011);
INSERT INTO Buys VALUES(1007,	2012);
INSERT INTO Buys VALUES(1007,	2013);
INSERT INTO Buys VALUES(1008,	2007);
INSERT INTO Buys VALUES(1008,	2011);
INSERT INTO Buys VALUES(1008,	2012);
INSERT INTO Buys VALUES(1008,	2013);
INSERT INTO Buys VALUES(1009,	2001);
INSERT INTO Buys VALUES(1009,	2002);
INSERT INTO Buys VALUES(1009,	2011);
INSERT INTO Buys VALUES(1009,	2012);
INSERT INTO Buys VALUES(1009,	2013);
INSERT INTO Buys VALUES(1010,	2001);
INSERT INTO Buys VALUES(1010,	2002);
INSERT INTO Buys VALUES(1010,	2003);
INSERT INTO Buys VALUES(1010,	2011);
INSERT INTO Buys VALUES(1010,	2012);
INSERT INTO Buys VALUES(1010,	2013);
INSERT INTO Buys VALUES(1011,	2002);
INSERT INTO Buys VALUES(1011,	2011);
INSERT INTO Buys VALUES(1011,	2012);
INSERT INTO Buys VALUES(1012,	2011);
INSERT INTO Buys VALUES(1012,	2012);
INSERT INTO Buys VALUES(1013,	2001);
INSERT INTO Buys VALUES(1013,	2011);
INSERT INTO Buys VALUES(1013,	2012);
INSERT INTO Buys VALUES(1014,	2008);
INSERT INTO Buys VALUES(1014,	2011);
INSERT INTO Buys VALUES(1014,	2012);
INSERT INTO Buys VALUES(1017,	2001);
INSERT INTO Buys VALUES(1017,	2002);
INSERT INTO Buys VALUES(1017,	2003);
INSERT INTO Buys VALUES(1017,	2008);
INSERT INTO Buys VALUES(1017,	2012);
INSERT INTO Buys VALUES(1020,	2001);
INSERT INTO Buys VALUES(1020,	2012);
INSERT INTO Buys VALUES(1022,	2014);
INSERT INTO Major Values(1001,	'Math');
INSERT INTO Major Values(1001,	'Physics');
INSERT INTO Major Values(1002,	'CS');
INSERT INTO Major Values(1002,	'Math');
INSERT INTO Major Values(1003,	'Math');
INSERT INTO Major Values(1004,	'CS');
INSERT INTO Major Values(1006,	'CS');
INSERT INTO Major Values(1007,	'CS');
INSERT INTO Major Values(1007,	'Physics');
INSERT INTO Major Values(1008,	'Physics');
INSERT INTO Major Values(1009,	'Biology');
INSERT INTO Major Values(1010,	'Biology');
INSERT INTO Major Values(1011,	'CS');
INSERT INTO Major Values(1011,	'Math');
INSERT INTO Major Values(1012,	'CS');
INSERT INTO Major Values(1013,	'CS');
INSERT INTO Major Values(1013,	'Psychology');
INSERT INTO Major Values(1014,	'Theater');
INSERT INTO Major Values(1017,	'Anthropology');
INSERT INTO Major Values(1022,	'CS');
INSERT INTO Major Values(1015,	'Chemistry');


--problem1
Select DISTINCT m1.Sid, m1.major FROM Buys b1, Major m1, Book bo1
	WHERE m1.Sid = b1.Sid and b1.BookNo = bo1.BookNo and bo1.Price < 20;
--problem2
Select DISTINCT bo1.BookNo, bo1.Title FROM Book bo1, cites c1
	WHERE bo1.BookNo = c1.CitedBookNo and bo1.price between 20 and 40;

--problem3
Select DISTINCT s1.Sid, s1.Sname from major m1, book bo1, student s1, buys b1, cites c1
	where s1.sid = m1.sid and m1.major = 'CS' 
	and b1.sid = s1.sid 
	and b1.bookno = bo1.bookno 
	and c1.CitedbookNo in (Select bo2.bookNo from book bo2, cites c2
		where bo2.bookNo = c1.CitedBookNo and bo2.price < bo1.price);

--problem4
select distinct bo.bookno, bo.title from book bo, cites c1, cites c2
	where bo.bookno = c1.citedbookno and c1.bookno = c2.citedbookno;

--problem5
select distinct bo.bookno from book bo where bo.price <= all(select bo.price from book bo);

--problem6
select bookno, title from book where book.bookno not in
(select A.bookno from book as A, book as B
  where A.price < B.price);

--problem7
select distinct bo.bookno, bo.title from book bo
		where bo.price>= all(select b2.price from book b2 where 
		          b2.price <> (select b2.price from book b2 
				  where b2.price >= all(select b2.price from book b2)))
				and bo.price<> (select bo.price from book bo where bo.price >= all(select bo.price from book bo));
--problem8
SELECT DISTINCT c.BookNo, bk.price FROM Book bk, Cites c
WHERE c.BookNo = bk.BookNo AND c.BookNo in (SELECT c.BookNo FROM Cites c, Book bk WHERE c.CitedBookNo=bk.BookNo AND bk.price>20)
union
SELECT DISTINCT bk.BookNo, bk.price FROM Book bk, Cites c
WHERE bk.BookNo NOT IN(SELECT c.CitedBookNo FROM Cites c);
--problem9
select distinct b.bookno, b.title from book b, student s, buys bu, major m
	where bu.sid = s.sid and b.bookno = bu.bookno and m.sid = s.sid
		and (m.major = 'Psychology' or m.major = 'Biology');

--problem10
Select b.bookno, b.title from book b
where exists ((Select bu.bookno, b.title from book b1, buys bu, student s, major m 
	where s.sid = m.sid and m.major = 'CS' and bu.sid = s.sid) except (select b2.bookno, b2.title from book b2, buys bu2, student s2
			where bu2.sid = s2.sid and b2.bookno = bu2.bookno));

--problem11
SELECT DISTINCT b.BookNo FROM Book b, Student s, Major m, Buys bu
    WHERE s.Sid = bu.Sid AND s.Sid NOT IN (SELECT s1.Sid FROM Student s1, Major m1
          WHERE s1.Sid = m1.Sid AND m1.Major = 'CS'
                OR m1.Major = 'Math' OR m1.Major = 'Chemistry' OR m1.Major = 'Psychology'
                        OR m1.Major = 'Physics'  OR m1.Major = 'Anthropology'  
                        	OR m1.Major = 'Theater')
    union
SELECT DISTINCT bk.BookNo FROM Book bk, Buys b
WHERE bk.BookNo NOT IN (SELECT b.BookNo FROM Buys b);
--problem12
select distinct Book.BookNo, Book.Title from Book where not exists(
select distinct m1.Sid from major m1, major m2 where m1.major = 'CS' and m2.major = 'Math' and m1.Sid = m2.Sid
except
select distinct buys.sid from Buys where book.bookNo = buys.bookNo);
--problem13
with csMajor as (select Major.Sid from Major where Major.Major = 'CS')
select s.sid, s.sname from Student s where exists(
	(select bu1.BookNo from Buys bu1 where bu1.Sid = s.Sid)
	except
	(select distinct b2.BookNo from Buys b2, Buys b3 where b2.BookNo = b3.BookNo and b2.sid <> b3.sid 
	and b2.Sid in (select sid from csMajor) 
	and b3.Sid in (select sid from csMajor)));

--problem14
select distinct s.Sid, s.Sname from Student s, Buys bu, Book b where s.Sid not in (select Sid from Buys)
union
select distinct s1.Sid, s1.Sname from Student s1
where s1.Sid not in (select distinct B1.Sid from Buys B1, Buys B2, Book 
	where B1.Sid = B2.Sid and B1.BookNo <> B2.BookNo and B1.BookNo = Book.BookNo and Book.BookNo in (select Book.BookNo from Book where Book.Price > 20));

--problem15
select S.Sid,B.BookNo from Student S, Buys B, Book B1
where B.Sid = S.Sid and B.BookNo = B1.BookNo and B1.Price <= all(select B2.Price from Book B2, Buys B3 where B2.BookNo = B3.BookNo and B3.Sid = S.Sid)order by S.sid asc;
\c postgres
drop database KF;