--KFADILLA
--1
create database KF;

\c kf;
CREATE TABLE Sailor
(
	Sid INTEGER PRIMARY KEY,
	Sname VARCHAR(20),
	Rating INTEGER,
	Age INTEGER
);

CREATE TABLE Boat
(
	Bid INTEGER PRIMARY KEY,
	Bname VARCHAR(15),
	Color VARCHAR(15)
);

CREATE TABLE Reserves
(
	Sid INTEGER references Sailor(Sid),
	Bid INTEGER references Boat(Bid),
	Day VARCHAR(10),
	PRIMARY KEY (Sid, Bid)
);



INSERT INTO Boat VALUES(101,  'Interlake', 'blue');
INSERT INTO Boat VALUES(102,  'Sunset',    'red');
INSERT INTO Boat VALUES(103,  'Clipper',   'green');
INSERT INTO Boat VALUES(104,  'Marine',    'red');

INSERT INTO Sailor VALUES(22,   'Dustin',       7,      45);
INSERT INTO Sailor VALUES(29,   'Brutus',       1,      33);
INSERT INTO Sailor VALUES(31,   'Lubber',       8,      55);
INSERT INTO Sailor VALUES(32,   'Andy',         8,      25);
INSERT INTO Sailor VALUES(58,   'Rusty',        10,     35);
INSERT INTO Sailor VALUES(64,   'Horatio',      7,      35);
INSERT INTO Sailor VALUES(71,   'Zorba',        10,     16);
INSERT INTO Sailor VALUES(74,   'Horatio',      9,      35);
INSERT INTO Sailor VALUES(85,   'Art',          3,      25);
INSERT INTO Sailor VALUES(95,   'Bob',          3,      63);

INSERT INTO Reserves VALUES(22,   101,  'Monday');
INSERT INTO Reserves VALUES(22,   102,  'Tuesday');
INSERT INTO Reserves VALUES(22,   103,  'Wednesday');
INSERT INTO Reserves VALUES(31,   102,  'Thursday');
INSERT INTO Reserves VALUES(31,   103,  'Friday');
INSERT INTO Reserves VALUES(31,   104,  'Saturday');
INSERT INTO Reserves VALUES(64,   101,  'Sunday');
INSERT INTO Reserves VALUES(64,   102,  'Monday');
INSERT INTO Reserves VALUES(74,   102,  'Saturday');

--2
ALTER TABLE Sailor ADD PRIMARY KEY(Sname);
INSERT INTO Sailor VALUES(null, 'John', 3, 1990);

--3a
SELECT Sid, Rating FROM Sailor;

--3b
SELECT Bid, Color FROM Boat;

--3c
SELECT Sname FROM Sailor
	WHERE Age between 15 and 30;

--3d
SELECT DISTINCT Bname FROM Boat, Reserves
	WHERE Boat.Bid = Reserves.Bid and (Reserves.Day = 'Saturday' or Reserves.Day = 'Sunday');

--3e
SELECT DISTINCT Sname FROM Sailor, Reserves, Boat
	WHERE Sailor.Sid = Reserves.Sid and Reserves.bid = Boat.bid and Boat.Color = 'red'
		and Sailor.Sid IN 
			(SELECT S.sid FROM Sailor S, Boat B, Reserves R
				WHERE S.sid = R.sid and R.bid = B.bid and B.Color = 'green');

--3f
SELECT DISTINCT Sname FROM Sailor S1, Reserves R1, Boat B1
	WHERE S1.Sid = R1.Sid and R1.bid = B1.bid and B1.Color = 'red'
		and S1.Sid NOT IN 
			(SELECT S2.sid FROM Sailor S2, Boat B2, Reserves R2
				WHERE S2.sid = R2.sid and R2.bid = B2.bid and (B2.Color = 'green' or B2.Color = 'blue'));
--3g
SELECT DISTINCT Sname FROM Sailor S1, Reserves R1, Boat B1
	WHERE S1.Sid = R1.Sid and R1.bid = B1.bid
		and S1.Sid IN 
			(SELECT S2.sid FROM Sailor S2, Boat B2, Reserves R2
				WHERE S2.sid = R2.sid and R2.bid = B2.bid and NOT (B2.bid = B1.bid));

--3h
SELECT DISTINCT Sid FROM Sailor S1
	WHERE S1.Sid NOT IN
		(SELECT R2.Sid FROM Reserves R2);

--3i
SELECT DISTINCT S1.Sid FROM Sailor S1, Boat B1, Reserves R1
	WHERE S1.Sid = R1.Sid and R1.bid = B1.Bid and R1.Day = 'Saturday'
		and EXISTS 
			(SELECT R2.Sid FROM Sailor S2, Boat B2, Reserves R2
				WHERE S2.Sid = R2.Sid and R2.Bid = B2.Bid and NOT (R1.Sid = R2.Sid) and R2.Day = 'Saturday');

--3j
SELECT DISTINCT B1.Bid FROM Sailor S1, Boat B1, Reserves R1
	WHERE S1.Sid = R1.Sid and R1.bid = B1.Bid
		and R1.Bid NOT IN 
			(SELECT R2.Bid FROM Sailor S2, Boat B2, Reserves R2
				WHERE S2.Sid = R2.Sid and R2.Bid = B2.Bid and NOT (S2.Sid = S1.Sid));


\c postgres;
drop database KF;