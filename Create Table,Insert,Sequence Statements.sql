
Create Table Users(
UserID Varchar2(30) Primary Key, 
Password Varchar2(30),
Email Varchar2(30),
Name Varchar2(30),
Country Varchar2(30),
CreationTime TimeStamp,
LastLoginTime TimeStamp);


Insert Into Users(UserID,Password,Email,Name,Country,CreationTime) Values('Admin','manik123','mani1992@gmail.com','Manikanth','India',timestamp '2015-1-1 09:00:30.00'); 

Insert Into Users(UserID,Password,Email,Name,Country,CreationTime) Values('ShyamSundar','ShyamS','shyam1993@gmail.com','Shyam','USA',timestamp '2015-1-2 05:23:30.00');

Insert Into Users(UserID,Password,Email,Name,Country,CreationTime) Values('PhaniM1','mav2','madha@gmail.com','Phanendra','India',timestamp '2015-1-3 03:56:30.00');

Insert Into Users(UserID,Password,Email,Name,Country,CreationTime) Values('AbhiG','Abhi123','abhilash@gmail.com','Abhilash','UK',timestamp '2015-1-4 11:18:30.00');

Insert Into Users(UserID,Password,Email,Name,Country,CreationTime) Values('Vineeth','Vinny1993','Vineeth@gmail.com','Vineeth','USA',timestamp '2015-1-5 10:08:30.00');

Insert Into Users(UserID,Password,Email,Name,Country,CreationTime) Values('Prashant','PrashantS','Prashant@gmail.com','Prashant','SriLanka',timestamp '2015-1-16 02:17:30.00');

Insert Into Users(UserID,Password,Email,Name,Country,CreationTime) Values('FayazSheik','FayazS','sfayaz@gmail.com','Fayaz','Saudi',timestamp '2015-1-26 12:47:30.00');

Insert Into Users(UserID,Password,Email,Name,Country,CreationTime) Values('VineetU','Vineet1991','Uvineet@gmal.com','Vineeth','Pakistan',timestamp '2015-2-18 10:12:30.00');

Insert Into Users(UserID,Password,Email,Name,Country,CreationTime) Values('BinilB','Binil1990','BinilB@gmail.com','Binil','India',timestamp '2015-2-8 09:12:30.00');


Create Table Admin(
UserID Varchar2(30) Primary Key,
Salary Integer,
HireDate Date,
Status Varchar2(30) Default 'Active',
Foreign Key(UserID) References Users(UserID));


Insert into Admin(UserID,Salary,HireDate) Values('Admin',50000,'01-JAN-15');


Create Table RegularUser(
UserID Varchar2(30) Primary Key,
Status Varchar2(30),
ReputationScore Integer Default 0,
Foreign Key(UserID) References Users(UserID));

Insert Into RegularUser(UserID,Status) Values ('ShyamSundar','Active');

Insert Into RegularUser(UserID,Status) Values ('PhaniM1','Active');

Insert Into RegularUser(UserID,Status) Values ('AbhiG','Active');

Insert Into RegularUser(UserID,Status) Values ('Vineeth','Active');

Insert Into RegularUser(UserID,Status) Values ('Prashant','Active');

Insert Into RegularUser(UserID,Status) Values ('FayazSheik','Active');

Insert Into RegularUser(UserID,Status) Values ('VineetU','Active');

Insert Into RegularUser(UserID,Status) Values ('BinilB','Active');


Create or Replace Type TagListType as varray(5) of varchar2(20);

Create Table Tags(
TagID Integer,
TagName Varchar2(20),
Primary Key (TagID));

Create Sequence TagID_seq start with 121 increment by 1;


Insert Into Tags Values(101,'SQL');
Insert Into Tags Values(102,'JAVA');
Insert Into Tags Values(103,'MS.NET');
Insert Into Tags Values(104,'ASP.NET');
Insert Into Tags Values(105,'C');
Insert Into Tags Values(106,'C++');
Insert Into Tags Values(107,'C#');
Insert Into Tags Values(108,'SAP');
Insert Into Tags Values(109,'PHP');
Insert Into Tags Values(110,'PHYTHON');

Insert Into Tags Values(111,'MySQL');
Insert Into Tags Values(112,'PERL');
Insert Into Tags Values(113,'Ruby');
Insert Into Tags Values(114,'R');
Insert Into Tags Values(115,'SAS');
Insert Into Tags Values(116,'SPSS');
Insert Into Tags Values(117,'COBOL');
Insert Into Tags Values(118,'RPG');
Insert Into Tags Values(119,'INFORMATICA');
Insert Into Tags Values(120,'TABLEAU');
select * from UserTags;

Create Table UserTags(
UserID Varchar2(30),
TagID Integer,
Primary Key(UserID,TagID),
Foreign Key(UserID) References RegularUser(UserID),
Foreign Key(TagID) References Tags(TagID));


Insert into UserTags Values('ShyamSundar',101);
Insert into UserTags Values('ShyamSundar',102);
Insert into UserTags Values('ShyamSundar',103);
Insert into UserTags Values('PhaniM1',107);
Insert into UserTags Values('PhaniM1',108);
Insert into UserTags Values('AbhiG',102);
Insert into UserTags Values('Vineeth',103);
Insert into UserTags Values('Vineeth',105);
Insert into UserTags Values('Vineeth',106);
Insert into UserTags Values('Prashant',101);
Insert into UserTags Values('Prashant',102);
Insert into UserTags Values('Prashant',108);


Create Table Questions(
QuestionID Integer Primary Key,
UserID Varchar2(30),
QuestionDesc Varchar2(4000),
QuestionStatus Varchar2(10) Default 'Active',
VoteCount Integer Default 0,
PostingTime TimeStamp,
ClosingTime TimeStamp,
Foreign Key(UserID) References RegularUser(UserID));

Create Sequence QuestionID_seq start with 15 increment by 1;


Insert Into Questions(QuestionID,UserID,QuestionDesc,PostingTime) Values(1,'ShyamSundar','SQL multiple ORDER BY columns sort by Desc and Asc',timestamp '2015-1-10 09:00:30.00');

Insert Into Questions(QuestionID,UserID,QuestionDesc,PostingTime) Values(2,'ShyamSundar','Replace INNER JOIN and LEFT OUTER JOIN with UNION',timestamp '2015-1-26 09:00:30.00');

Insert Into Questions(QuestionID,UserID,QuestionDesc,PostingTime) Values(3,'ShyamSundar','c# Controlled Thread Pooling. More threads are running simultaneously than expected',timestamp '2015-2-10 09:00:30.00');

Insert Into Questions(QuestionID,UserID,QuestionDesc,PostingTime) Values(4,'ShyamSundar','use outer apply to find for each row have a record based on first result from detail table',timestamp '2015-2-18 09:00:30.00');

Insert Into Questions(QuestionID,UserID,QuestionDesc,PostingTime) Values(5,'ShyamSundar','How to insert into my table from a file in mysql?',timestamp '2015-3-16 09:00:30.00');

Insert Into Questions(QuestionID,UserID,QuestionDesc,PostingTime) Values(6,'PhaniM1','Insert a table inside another with one field different',timestamp '2015-1-12 09:00:30.00');

Insert Into Questions(QuestionID,UserID,QuestionDesc,PostingTime) Values(7,'PhaniM1','Why change the ordering of the tables in the FROM clause makes the SQL execution time different?',timestamp '2015-1-22 09:00:30.00');

Insert Into Questions(QuestionID,UserID,QuestionDesc,PostingTime) Values(8,'PhaniM1','Number of unique elements in a vector',timestamp '2015-2-08 09:00:30.00');

Insert Into Questions(QuestionID,UserID,QuestionDesc,PostingTime) Values(9,'PhaniM1','create objects but how to get at the individual object?',timestamp '2015-3-19 09:00:30.00');

Insert Into Questions(QuestionID,UserID,QuestionDesc,PostingTime) Values(10,'PhaniM1','Python simple bouncing physics',timestamp '2015-3-24 09:00:30.00');

Insert Into Questions(QuestionID,UserID,QuestionDesc,PostingTime) Values(11,'AbhiG','How can I make a parallel proccess with PhantomJS in C#?',timestamp '2015-1-15 09:00:30.00');

Insert Into Questions(QuestionID,UserID,QuestionDesc,PostingTime) Values(12,'AbhiG','What is the SQL to extract/calculate averages by department?',timestamp '2015-3-11 09:00:30.00');

Insert Into Questions(QuestionID,UserID,QuestionDesc,PostingTime) Values(13,'AbhiG','JAVA using assigned values from an array in a calculation',timestamp '2015-3-24 09:00:30.00');

Insert Into Questions(QuestionID,UserID,QuestionDesc,PostingTime) Values(14,'AbhiG','How to connect to base from sub domain? SQLiteConnector, connectionString',timestamp '2015-3-27 09:00:30.00');



Create Table QuestionTags(
QuestionID Integer,
TagID Integer,
Primary Key(QuestionID,TagID),
Foreign Key(QuestionID) References Questions(QuestionID),
Foreign Key(TagID) References Tags(TagID));

Insert into QuestionTags Values(1,101);
Insert Into QuestionTags Values(1,111);
Insert Into QuestionTags Values(1,102);
Insert into QuestionTags Values(2,101);
Insert Into QuestionTags Values(2,102);
Insert Into QuestionTags Values(2,109);
Insert Into QuestionTags Values(2,107);
Insert Into QuestionTags Values(2,111);
Insert into QuestionTags Values(3,107);
Insert Into QuestionTags Values(3,103);
Insert Into QuestionTags Values(3,104);
Insert into QuestionTags Values(4,104);
Insert Into QuestionTags Values(4,103);
Insert Into QuestionTags Values(4,107);
Insert into QuestionTags Values(5,101);
Insert Into QuestionTags Values(5,102);
Insert Into QuestionTags Values(5,111);
Insert into QuestionTags Values(6,101);
Insert Into QuestionTags Values(6,103);
Insert Into QuestionTags Values(6,104);
Insert Into QuestionTags Values(6,107);
Insert into QuestionTags Values(7,101);
Insert Into QuestionTags Values(7,109);
Insert Into QuestionTags Values(7,110);
Insert Into QuestionTags Values(7,111);
Insert into QuestionTags Values(8,102);
Insert Into QuestionTags Values(8,111);
Insert Into QuestionTags Values(8,109);
Insert into QuestionTags Values(9,102);
Insert Into QuestionTags Values(9,111);
Insert Into QuestionTags Values(9,109);
Insert into QuestionTags Values(10,110);
Insert Into QuestionTags Values(10,112);
Insert Into QuestionTags Values(10,101);
Insert into QuestionTags Values(11,107);
Insert Into QuestionTags Values(11,103);
Insert Into QuestionTags Values(11,104);
Insert into QuestionTags Values(12,101);
Insert Into QuestionTags Values(12,102);
Insert into QuestionTags Values(13,102);
Insert Into QuestionTags Values(13,105);
Insert Into QuestionTags Values(13,106);
Insert into QuestionTags Values(14,103);
Insert Into QuestionTags Values(14,104);
Insert Into QuestionTags Values(14,106);


Create Table Answers(
AnswerID Integer Primary Key ,
UserID Varchar2(30),
QuestionID Integer,
Answer Varchar2(4000),
AnswerStatus Varchar2(20),
VoteCount Integer Default 0,
PostingTime TimeStamp,
Foreign Key(QuestionID) References Questions(QuestionID),
Foreign Key(UserID) References RegularUser(UserID));



Insert Into Answers(AnswerID,UserID,QuestionID,Answer,PostingTime) Values(1,'Prashant',1,'ORDER BY column1 DESC column2',timestamp '2015-1-11 11:34:30.00');

Insert Into Answers(AnswerID,UserID,QuestionID,Answer,PostingTime) Values(2,'AbhiG',6,'Insert into Original Select * from Temp where site = 1',timestamp '2015-1-15 04:27:30.00');

Insert Into Answers(AnswerID,UserID,QuestionID,Answer,PostingTime) Values(3,'Vineeth',1,'SELECT * FROM People ORDER BY FirstName DESC, YearOfBirth ASC',timestamp '2015-1-17 02:10:30.00');

Insert Into Answers(AnswerID,UserID,QuestionID,Answer,PostingTime) Values(4,'AbhiG',7,'The ORDERED hint causes Oracle to join tables in the order in which they appear in the FROM clause.',timestamp '2015-1-26 05:12:20.00');

Insert Into Answers(AnswerID,UserID,QuestionID,Answer,PostingTime) Values(5,'PhaniM1',3,'You forgot to Reset() the ManualResetEvent, it always stays set.',timestamp '2015-1-26 12:00:30.00');

Insert Into Answers(AnswerID,UserID,QuestionID,Answer,PostingTime) Values(6,'Prashant',2,'SELECT T2."Date", T1."ProductID", T1."StoreID", T1."Currency" ,T1."Sales", T2."Quantity" FROM "SALES" AS T1 INNER JOIN "STOCK" AS T2 ON T1."ProductID", T2."ProductID" and T1."StoreID",T2."StoreID"',timestamp '2015-1-27 10:28:30.00');

Insert Into Answers(AnswerID,UserID,QuestionID,Answer,PostingTime) Values(7,'Vineeth',8,'I d use a sorted associative container to handle this, specifically std::set.',timestamp '2015-2-10 03:23:23.00');

Insert Into Answers(AnswerID,UserID,QuestionID,Answer,PostingTime) Values(8,'Prashant',8,'Space efficient : Use hash map . O(logN)*O(n) for insert and just keep the count of number of elements successfully inserted.',timestamp '2015-2-17 02:36:23.00');

Insert Into Answers(AnswerID,UserID,QuestionID,Answer,PostingTime) Values(9,'Vineeth',3,'You probably want to use an AutoResetEvent instead of the ManualResetEvent',timestamp '2015-2-18 03:27:44.00');

Insert Into Answers(AnswerID,UserID,QuestionID,Answer,PostingTime) Values(10,'AbhiG',4,'SELECT  TERM,PROBLEM,DOWN_DATEFROM [PROBLEM_LOG] WHERE PROBLEM = PM ',timestamp '2015-2-18 09:00:30.00');

Insert Into Answers(AnswerID,UserID,QuestionID,Answer,PostingTime) Values(11,'AbhiG',4,'SELECT  TERM,PROBLEM,DOWN_DATEFROM [PROBLEM_LOG] WHERE PROBLEM = PM ',timestamp '2015-2-25 11:25:20.00');

Insert Into Answers(AnswerID,UserID,QuestionID,Answer,PostingTime) Values(12,'AbhiG',1,'SELECT  * FROM    mytable ORDER BY coloumn1 DESC, coloumn2 ASC',timestamp '2015-2-26 01:30:30.00');

Insert Into Answers(AnswerID,UserID,QuestionID,Answer,PostingTime) Values(13,'AbhiG',1,'SELECT employee_id, dept, name, age, salary FROM employee_info WHERE dept = Sales ORDER BY salary, age DESC;',timestamp '2015-3-2 17:27:23.00');

Insert Into Answers(AnswerID,UserID,QuestionID,Answer,PostingTime) Values(14,'Prashant',6,'Insert into Original (site, field1, field2, field3) Select 2, field1, field2, field3 from Temp where site = 1',timestamp '2015-3-11 12:37:34.00');

Insert Into Answers(AnswerID,UserID,QuestionID,Answer,PostingTime) Values(15,'Vineeth',12,'select count(name), major, avg(gpa) from students group by major;',timestamp '2015-3-16 04:17:29.00');

Insert Into Answers(AnswerID,UserID,QuestionID,Answer,PostingTime) Values(16,'Prashant',5,'LOAD DATA LOCAL INFILE "C:/file.dat" INTO TABLE table;',timestamp '2015-3-17 21:43:23.00');

Insert Into Answers(AnswerID,UserID,QuestionID,Answer,PostingTime) Values(17,'Vineeth',9,'You want to create an array of My::Coffee objects with the corresponding names. In Perl, you would do:my @coffees = map My::Coffee->new($_), @names',timestamp '2015-3-20 10:16:27.00');

Insert Into Answers(AnswerID,UserID,QuestionID,Answer,PostingTime) Values(18,'ShyamSundar',10,'velocityVector is movement speed, represented by Vector, moving towards surface. Surface Normal is perpendicular to the surface, with length of 1',timestamp '2015-3-24 11:23:45.00');

Insert Into Answers(AnswerID,UserID,QuestionID,Answer,PostingTime) Values(19,'ShyamSundar',13,' System.out.print("Enter Employees Payscale (Number 0 to 4): PayScale2[i] = scanner.nextDouble();',timestamp '2015-3-25 03:12:23.00');

Insert Into Answers(AnswerID,UserID,QuestionID,Answer,PostingTime) Values(20,'Prashant',5,'LOAD DATA LOCAL INFILE "C:/file.dat" INTO TABLE table;',timestamp '2015-3-25 04:23:34.00');

Insert Into Answers(AnswerID,UserID,QuestionID,Answer,PostingTime) Values(21,'ShyamSundar',12,'SELECT AVG(gpa) FROM student_info ORDER BY gpa DESC',timestamp '2015-3-25 12:17:23.00');

Insert Into Answers(AnswerID,UserID,QuestionID,Answer,PostingTime) Values(22,'AbhiG',10,'When the ball hits A and C, its X velocities are inverted, and when it hits B and D, its Y velocities are inverted',timestamp '2015-3-27 01:45:57.00');

Insert Into Answers(AnswerID,UserID,QuestionID,Answer,PostingTime) Values(23,'PhaniM1',13,'System.out.println(Employee " + Employee[i] + " " + FirstName[i] + " " + LastName[i] + " has " + HoursWorked[i] * PayScale[0]);',timestamp '2015-3-27 10:19:29.00');

Insert Into Answers(AnswerID,UserID,QuestionID,Answer,PostingTime) Values(24,'Vineeth',9,'You want to create an array of My::Coffee objects with the corresponding names. In Perl, you would do:my @coffees = map My::Coffee->new($_), @names',timestamp '2015-3-27 11:16:26.00');

Insert Into Answers(AnswerID,UserID,QuestionID,Answer,PostingTime) Values(25,'PhaniM1',14,'HttpContext.Current.Request.Url.AbsoluteUri',timestamp '2015-3-27 12:45:23.00');

Insert Into Answers(AnswerID,UserID,QuestionID,Answer,PostingTime) Values(26,'Vineeth',5,'LOAD DATA LOCAL INFILE "C:/file.dat"  INTO TABLE table FIELDS TERMINATED BY ENCLOSED',timestamp '2015-3-28 10:34:54.00');

Insert Into Answers(AnswerID,UserID,QuestionID,Answer,PostingTime) Values(27,'PhaniM1',14,'HttpContext.Current.Request.Url.AbsoluteUri',timestamp '2015-3-29 06:23:47.00');

Insert Into Answers(AnswerID,UserID,QuestionID,Answer,PostingTime) Values(28,'Vineeth',12,'select count(name), major, avg(gpa) from students group by major;',timestamp '2015-3-29 07:32:43.00');

Insert Into Answers(AnswerID,UserID,QuestionID,Answer,PostingTime) Values(29,'ShyamSundar',14,'MyBase.db3 is in App_Data folder. Now I have web site in domain www. NewSubdomain . MySite .com ',timestamp '2015-3-29 10:23:34.00');

Insert Into Answers(AnswerID,UserID,QuestionID,Answer,PostingTime) Values(30,'Vineeth',12,'select count(name), major, avg(gpa) from students group by major;',timestamp '2015-3-29 10:23:43.00');

Insert Into Answers(AnswerID,UserID,QuestionID,Answer,PostingTime) Values(31,'AbhiG',4,'SELECT  TERM,PROBLEM,DOWN_



FROM [PROBLEM_LOG] WHERE PROBLEM = PM ',timestamp '2015-3-29 12:25:45.00');

Insert Into Answers(AnswerID,UserID,QuestionID,Answer,PostingTime) Values(32,'Prashant',5,'LOAD DATA LOCAL INFILE "C:/file.dat" INTO TABLE table;',timestamp '2015-3-30 07:23:47.00');

Insert Into Answers(AnswerID,UserID,QuestionID,Answer,PostingTime) Values(33,'PhaniM1',14,'HttpContext.Current.Request.Url.AbsoluteUri',timestamp '2015-3-31 11:23:32.00');



Create Table QuestionVotes(
UserID Varchar2(30),
QuestionID Integer,
Primary Key(UserID, QuestionID),
Foreign Key(UserID) References RegularUser(UserID),
Foreign Key(QuestionID) References Questions(QuestionID));


Create Table AnswerVotes(
UserID Varchar2(30),
AnswerID Integer,
Primary Key(UserID, AnswerID),
Foreign Key(UserID) References RegularUser(UserID),
Foreign Key(AnswerID) References Answers(AnswerID));
 
