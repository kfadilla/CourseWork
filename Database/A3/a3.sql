--KFADILLA
--work with yifan yin, xinze fan and rui xi

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
CREATE TABLE Buys(
	Sid INTEGER REFERENCES Student(Sid),
	BookNo INTEGER REFERENCES Book(BookNo)
);
CREATE TABLE qone
(
	x INTEGER
);
CREATE TABLE qtwo
(
	y INTEGER
);
create table A
(
	x integer
);
create table B 
(
	x integer
);
create table C (
	x integer
	);
create table qthree 
(
	x integer, 
	y integer
);
INSERT INTO qone values(1);
INSERT INTO qone values(2);
INSERT INTO qone values(3);
INSERT INTO qtwo values(1);
INSERT INTO qtwo values(3);
INSERT INTO qtwo values(4);
INSERT INTO qtwo values(5);
insert into qthree values(1, 9);
insert into qthree values(2, 7);
insert into qthree values(3, 6);
insert into qthree values(4, 6);
insert into qthree values(5, 10);
insert into qthree values(6, 7);
insert into qthree values(7, 3);
INSERT INTO A values(1);
INSERT INTO A values(2);
INSERT INTO A values(3);
insert into B values(1);
insert into B values(2);
insert into B values(3);
insert into B values(5);
insert into B values(4);
insert into C values(10);
insert into C values(11);
insert into C values(1);
insert into C values(3);
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
--1
CREATE FUNCTION A()
RETURNS TABLE(x INTEGER, square_root_x float, x_squared float, two_to_the_power_x Float, x_factorial Numeric, logarithm_x FLOAT)
AS $$
 Select qone.x, sqrt(qone.x), qone.x^2, 2^(qone.x), (qone.x)!, ln(qone.x) from qone;
$$
LANGUAGE SQL;
Select * from A();
--2
CREATE FUNCTION SETQ(out empty_a_minus_b VARCHAR(1), out not_empty_symmetric_difference VARCHAR(1), out empty_a_intersect_b VARCHAR(1))
AS $$
BEGIN
	if (select count(1) from (Select x from qone except select y from qtwo)AS t) = 0 THEN
		empty_a_minus_b = true;
	ELSE
		empty_a_minus_b = false;
	END IF; 
	if (select count(1) from ((Select x from qone except select y from qtwo) union (Select y from qtwo except select x from qone))AS t)= 0 THEN
		not_empty_symmetric_difference = false;
	ELSE
		not_empty_symmetric_difference = true;
	END IF;
	IF (select count(1) from (Select x from qone intersect select y from qtwo)AS t) = 0 THEN
		empty_a_intersect_b = true;
	ELSE
		empty_a_intersect_b = false;
	END if;
END; $$
LANGUAGE plpgsql;
Select * from SETQ();

--3
create function qpairs(OUT x1 integer,OUT y1 integer,OUT x2 integer,OUT y2 integer) 
AS
$$
select p1.x, p1.y, p2.x, p2.y from qthree p1, qthree p2 
where p1.x <> p2.x and p1.x + p1.y = p2.x + p2.y;
$$ language sql;

Select * from qpairs();

--4
--(a)																				
select exists((select A.x from A) intersect (select B.x from B));
select exists((select A.x from A where A.x in (select B.x from B)));
--(b)
select not exists((select A.x from A) except (select B.x from B));
select not exists((select A.x from A where A.x not in (select B.x from B)));
--(c)											   
select not exists((select B.x from B) except (select A.x from A));
select not exists((select B.x from B where B.x not in (select A.x from A)));
--(d)
select not exists(((select A.x from A) except (select B.x from B))
                  intersect
                  ((select B.x from B) except (select A.x from A)));
select not exists (select A1.x from 
       (select A.x from A
                         where A.x not in(select B.x from B)) A1
                   where A1.x in (select B.x from B where B.x not in (select A.x from A)));
--(e)
select not exists (select n1.x, n2.x, n3.x from
          ((select A.x from A)
                intersect
                (select B.x from B)) n1, 
            ((select A.x from A)
                intersect
                (select B.x from B)) n2, 
            ((select A.x from A)
                intersect
                (select B.x from B)) n3 
            where n1.x <> n2.x and n1.x <> n3.x and n2.x <> n3.x);
select not exists (select n1.x, n2.x, n3.x from
       (select A.x from A 
        where
        A.x in (select B.x from B)) n1, 
        (select A.x from A 
         where
         A.x in (select B.x from B)) n2, 
         (select A.x from A 
          where
         A.x in (select B.x from B)) n3 
         where n1.x <> n2.x and n1.x <> n3.x and n2.x <> n3.x);															  
--(f)
select not exists (((select A.x from A) union (select B.x from B)) except (select C.x from C));
select not exists 
(select C.x from C where C.x not in (select A.x from A) or C.x not in (select B.x from B));
--(g)
select (select count(*) from 
  (((select A.x from A) except (select B.x from B))
     union
    ((select B.x from B) except (select C.x from C))) n )  = 1;
--5
-----(problem 5)
--（a）
select (select count(*) 
		from ((select A.x from A) 
		intersect (select B.x from B)) n ) > 0;
--（b）
select (select count(*) 
		from ((select A.x from A) 
		except (select B.x from B)) n ) = 0;
--（c）
select (select count(*) 
		from ((select B.x from B) 
		except (select A.x from A)) n ) = 0;
--（d）
select (select count(*) 
		from (((select A.x from A) 
		except (select B.x from B))
        intersect
        ((select B.x from B) 
		except
		(select A.x from A))) n ) = 0;
--(e)
 select (select count(*) 
	from ((select A.x from A)
    intersect
    (select B.x from B)) n) <= 2;
--(f)
select (select count(*) 
	from (((select A.x from A) 
	union (select B.x from B)) 
	except (select C.x from C)) n ) = 0;
--(g)
select (select count(*) 
	from (((select A.x from A) 
	except (select B.x from B))
    union ((select B.x from B) 
	except (select C.x from C))) n )  = 1;

--6ai
create function booksBoughtbyStudent(s INT)
returns table(bookno int, title VARCHAR(30), price int)
as
$$
SELECT bk.bookno, bk.Title, bk.price FROM Buys b,Book bk, student St
    WHERE s = St.sid and St.sid = b.Sid AND bk.BookNo = b.BookNo;
$$ language sql;
--ii. 
SELECT *
from booksBoughtbyStudent(1001);
SELECT * 
FROM booksBoughtbyStudent(1015);
--iiia
SELECT s.sid,s.sname FROM Student s
WHERE (SELECT count(1) FROM (SELECT t.price from booksBoughtbyStudent(s.sid) t where t.price<50) q)=1;
--iiib
SELECT s1.sid,s2.sid FROM Student s1, Student s2
where s1.sid<>s2.sid and (select count(1) from ((SELECT  t1.bookno from booksBoughtbyStudent(s1.sid) t1) EXCEPT (SELECT  t2.BookNo FROM booksBoughtbyStudent(s2.sid) t2)) q)=0
 and (select count(1) from ((SELECT  t1.bookno from booksBoughtbyStudent(s2.sid) t1) EXCEPT (SELECT  t2.BookNo FROM booksBoughtbyStudent(s1.sid) t2)) q)=0;

--bi
create function studentsWhoBoughtBook(qbookno int)
RETURNS table(sid int, sname varchar(15))
as
$$
select student.sid, student.sname from student, Buys
where qbookno = Buys.bookno and Buys.sid = student.sid;
$$
LANGUAGE SQL;
--bii
select * from studentsWhoBoughtBook(2001);
select * from studentsWhoBoughtBook(2010);

--biii
select distinct b.bookno 
from student s, BooksBoughtbyStudent(s.sid) b
where (select count(1) from studentsWhoBoughtBook(b.bookno) st, major m
    where st.sid = m.sid and m.major = 'CS') >=2 and 
          (select count(1) from booksBoughtbyStudent(s.sid) b1 where b1.price>30)>=1;

--ci
SELECT m.sid,m.major FROM major m
	where (SELECT count(1) 
		   FROM (SELECT t.price from 
				 booksBoughtbyStudent(m.sid) t 
				 where t.price > 30) p)>=4;

--cii 
select s1.sid, s2.sid from student s1,student s2
	where s1.sid<>s2.sid 
		and (select sum(t.price) from booksBoughtbyStudent(s1.sid)t) 
									= (select sum(t.price) from booksBoughtbyStudent(s2.sid)t);

--ciii
select distinct s1.sid,s1.sname from Student s1
where
(select sum(t.price) from booksBoughtbyStudent(s1.sid) t) 
  >(SELECT (select sum(c.price) from Student s2,major m, booksBoughtbyStudent(s2.sid) c WHERE s2.sid = m.sid and m.major = 'CS') /(select count(1) FROM major m1 WHERE m1.major='CS'));
--civ
select b.bookno, b.title from book b
where b.price = (select max(b.price) from book b
 where b.price < (select max(b.price) from book b 
 	where b.price < (select max(b.price) from book b)));

--cv
select distinct b.BookNo, b.Title from Book b where 
(select count(1) from ((select t.Sid from studentsWhoBoughtBook(b.BookNo) t) 
	except (select distinct m.Sid from Major m where m.Major = 'CS')) v) = 0;
--cvi
select s.sid, s.sname from  student s 
where s.sid in (select t.sid from buys t
	where  t.sid = s.sid and t.bookno not in 
	(select t1.bookno from buys t1, buys t2 
		where  t1.bookno = t2.bookno and t1.sid <> t2.sid and t1.sid in 
		(select m.sid from major m where  m.major = 'CS') 
		and t2.sid in (select m.sid from major m 
			where m.major = 'CS')));

--cvii
select distinct s.sid, b.bookno from student s, buys bu, booksboughtbystudent(s.sid) b 
	where b.price < (select avg(b1.price) from booksboughtbystudent(s.sid)b1);

--cviii
select s1.sid, s2.sid from student s1, student s2, major m1, major m2
where s1.sid = m1.sid and s2.sid = m2.sid and m2.major = m1.major and s1.sid <> s2.sid
and (select count(*) from booksBoughtbyStudent(s1.sid)) = (select count(*) from booksBoughtbyStudent(s2.sid));

--cix
select distinct S1.Sid, S2.Sid, (select count(*) from ((select b1.BookNo FROM booksBoughtbyStudent(s1.sid) b1) 
	except (select b2.BookNo from booksBoughtbyStudent(s2.sid) b2)) d)
from Major S1, Major S2 where S1.Major = S2.Major and S1.Sid <> S2.Sid;
--cx
select b.BookNo from Book b where (select count(1) from 
	(select m.Sid from Major m where m.Major = 'CS'
	except
	select t.Sid from studentsWhoBoughtBook(B.BookNo) t) v) = 1;
\c postgres;
drop database KF;