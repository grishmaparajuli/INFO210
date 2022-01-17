



-- DROP TABLES 
DROP TABLE Teaches;
DROP TABLE Professor_Works_in;
DROP TABLE LinkedCourse;
DROP TABLE Pre_Req;
DROP TABLE Course_Offer;
DROP TABLE Department;






-- Create Department table 
CREATE TABLE Department (
DepartmentID varchar(25) PRIMARY KEY,
Name varchar(128) not null
);


-- UPDATE: Combined Professor Table with Works_in table to capture participation constraints 
-- Every Professor must be in an department at creation 
CREATE TABLE Professor_Works_in (
ID varchar(10) PRIMARY KEY,
Name varchar(128) not null,
DepartmentID varchar(25) not null,
FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);


-- INSERT QUERIES 
-- Department INSERT QUERIES 
INSERT INTO Department (DepartmentID, Name) VALUES ('CCI', 'College Comp and Info');
INSERT INTO Department (DepartmentID, Name) VALUES ('Lebow', 'College of Busn');
INSERT INTO Department (DepartmentID, Name) VALUES ('CoE', 'College of engr');
INSERT INTO Department (DepartmentID, Name) VALUES ('CoAS', 'College of Arts and Sci');
INSERT INTO Department (DepartmentID, Name) VALUES ('CSE', 'College of SoftEngr');


-- Professor Works_in INSERT QUERIES 
INSERT INTO Professor_Works_in (ID, Name, DepartmentID) VALUES ('PF1', 'Deanna Germano', 'CCI');
INSERT INTO Professor_Works_in (ID, Name, DepartmentID) VALUES ('PF2', 'Lawan Langer', 'CCI');
INSERT INTO Professor_Works_in (ID, Name, DepartmentID) VALUES ('PF3', 'Macey Bell', 'Lebow');
INSERT INTO Professor_Works_in (ID, Name, DepartmentID) VALUES ('PF4', 'Jaycob Scrivens', 'CoE');
INSERT INTO Professor_Works_in (ID, Name, DepartmentID) VALUES ('PF5', 'Melody Stanley', 'CoAS');


-- UPDATE: Combine Course with Offers table to capture participation constraints 
CREATE TABLE Course_Offer (
CourseID varchar(25),
Name varchar(128) not null,
Section varchar(25),
DepartmentID varchar(25) not null,
PRIMARY KEY (CourseID, Section),
FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);


-- Create Teaches Relation Table 
CREATE TABLE Teaches (
ID varchar(10),
CourseID varchar(25),
Section varchar(25),
PRIMARY KEY (ID, CourseID, Section),
FOREIGN KEY (ID) REFERENCES Professor_Works_in(ID) on delete cascade,
FOREIGN KEY (CourseID, Section) REFERENCES Course_Offer(CourseID, Section)
);


-- INSERT QUERIES 
-- Course INSERT QUERIES 
INSERT INTO Course_Offer (CourseID, Name, Section, DepartmentID) VALUES ('INFO210', 'DBMS', '001', 'CCI');
INSERT INTO Course_Offer (CourseID, Name, Section, DepartmentID) VALUES ('INFO210', 'DBMS', '002', 'CCI');
INSERT INTO Course_Offer (CourseID, Name, Section, DepartmentID) VALUES ('STAT201', 'Intro to Busn Stat', '001', 'Lebow');
INSERT INTO Course_Offer (CourseID, Name, Section, DepartmentID) VALUES ('CS164', 'Intro to CompSci', '002', 'CCI');
INSERT INTO Course_Offer (CourseID, Name, Section, DepartmentID) VALUES ('ENGL101', 'Compos and Rhetoric I', '003', 'CoAS');
INSERT INTO Course_Offer (CourseID, Name, Section, DepartmentID) VALUES ('ENGR101', 'Engr Design Lab I', '001', 'CoE');
INSERT INTO Course_Offer (CourseID, Name, Section, DepartmentID) VALUES ('MATH121', 'Calculus I', '004', 'Lebow');



-- Teaches INSERT QUERIES 
INSERT INTO Teaches (ID, CourseID, Section) VALUES ('PF1', 'INFO210', '001');
INSERT INTO Teaches (ID, CourseID, Section) VALUES ('PF2', 'INFO210', '002');
INSERT INTO Teaches (ID, CourseID, Section) VALUES ('PF3', 'STAT201', '001');
INSERT INTO Teaches (ID, CourseID, Section) VALUES ('PF4', 'ENGR101', '001');
INSERT INTO Teaches (ID, CourseID, Section) VALUES ('PF5', 'ENGL101', '003');



-- Create Pre-Req Table
CREATE TABLE Pre_Req (
CourseID varchar(25),
Section varchar(25),
Pre_ReqID varchar(25),
PRIMARY KEY (CourseID, Pre_ReqID),
FOREIGN KEY (CourseID, Section) REFERENCES Course_Offer(CourseID, Section),
FOREIGN KEY (Pre_ReqID, Section) REFERENCES Course_Offer(CourseID, Section)
);


-- Create Linked Course Table
CREATE TABLE LinkedCourse (
CourseID varchar(25),
LinkedID varchar(25) not null,
CourseSection varchar(10) not null,
LinkedSection varchar(10) not null,
PRIMARY KEY (CourseID, LinkedID, CourseSection, LinkedSection),
FOREIGN KEY (CourseID, CourseSection) REFERENCES Course_Offer(CourseID, Section),
FOREIGN KEY (LinkedID, LinkedSection) REFERENCES Course_Offer(CourseID, Section)
);


-- INSERT QUERIES for Pre_Req Table 
INSERT INTO Pre_Req (CourseID, Pre_ReqID) VALUES ('INFO210', 'CS164');
INSERT INTO Pre_Req (CourseID, Pre_ReqID) VALUES ('STAT201', 'MATH121');


-- INSERT QUERIES for LinkedCourse Table
INSERT INTO LinkedCourse (CourseID, LinkedID, CourseSection, LinkedSection) VALUES ('INFO210', 'INFO210', '001', '002');
INSERT INTO LinkedCourse (CourseID, LinkedID, CourseSection, LinkedSection) VALUES ('INFO210', 'INFO210', '002', '001');
INSERT INTO LinkedCourse (CourseID, LinkedID, CourseSection, LinkedSection) VALUES ('STAT201', 'MATH121', '001', '004');
INSERT INTO LinkedCourse (CourseID, LinkedID, CourseSection, LinkedSection) VALUES ('INFO210', 'CS164', '001', '002');
INSERT INTO LinkedCourse (CourseID, LinkedID, CourseSection, LinkedSection) VALUES ('ENGR101', 'CS164', '001', '002');


-- Modifying a Professor Name 
UPDATE Professor_Works_in SET Name = 'Mariam Spartak' WHERE ID = 'PF1';

-- Updating a department name
UPDATE Department SET Name = "College of Business" WHERE DepartmentID = 'Lebow';

-- Deleting a department
DELETE FROM Department WHERE DepartmentID='CSE';


-- Display Config
SET linesize 1000
COL ID FORMAT A10
COL CourseID FORMAT A10
COL Section FORMAT A10
COL DepartmentID FORMAT A10
COL Name FORMAT A25










