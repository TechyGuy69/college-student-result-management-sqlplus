
-- College Student Result Management System
-- Created for Oracle SQL Plus 10g

-- Drop tables if exist (for reset purposes)
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE MARKS';
    EXECUTE IMMEDIATE 'DROP TABLE RESULT';
    EXECUTE IMMEDIATE 'DROP TABLE STUDENT';
    EXECUTE IMMEDIATE 'DROP TABLE COURSE';
    EXECUTE IMMEDIATE 'DROP TABLE FACULTY';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

-- STUDENT table
CREATE TABLE STUDENT (
    Student_ID VARCHAR2(10) PRIMARY KEY,
    Name VARCHAR2(50),
    Dept VARCHAR2(30),
    Semester NUMBER(1),
    Email VARCHAR2(50),
    Phone VARCHAR2(15)
);

-- COURSE table
CREATE TABLE COURSE (
    Course_ID VARCHAR2(10) PRIMARY KEY,
    Course_Name VARCHAR2(50),
    Credits NUMBER(2),
    Max_Marks NUMBER(3)
);

-- FACULTY table
CREATE TABLE FACULTY (
    Faculty_ID VARCHAR2(10) PRIMARY KEY,
    Name VARCHAR2(50),
    Department VARCHAR2(30),
    Email VARCHAR2(50)
);

-- MARKS table
CREATE TABLE MARKS (
    Mark_ID VARCHAR2(10) PRIMARY KEY,
    Student_ID VARCHAR2(10),
    Course_ID VARCHAR2(10),
    Marks_Obtained NUMBER(3),
    FOREIGN KEY (Student_ID) REFERENCES STUDENT(Student_ID),
    FOREIGN KEY (Course_ID) REFERENCES COURSE(Course_ID)
);

-- RESULT table
CREATE TABLE RESULT (
    Result_ID VARCHAR2(10) PRIMARY KEY,
    Student_ID VARCHAR2(10),
    GPA NUMBER(4,2),
    Grade VARCHAR2(2),
    Semester NUMBER(1),
    FOREIGN KEY (Student_ID) REFERENCES STUDENT(Student_ID)
);

-- Sample Data Insertion

-- Students
INSERT INTO STUDENT VALUES ('S101', 'Amit Roy', 'CSE', 4, 'amit@xyz.com', '9876543210');
INSERT INTO STUDENT VALUES ('S102', 'Sneha Das', 'ECE', 4, 'sneha@xyz.com', '8765432109');
INSERT INTO STUDENT VALUES ('S103', 'Ravi Sharma', 'CSE', 4, 'ravi@xyz.com', '7654321098');
INSERT INTO STUDENT VALUES ('S104', 'Neha Sen', 'IT', 4, 'neha@xyz.com', '6543210987');
INSERT INTO STUDENT VALUES ('S105', 'Priya Saha', 'ECE', 4, 'priya@xyz.com', '9123456780');

-- Courses
INSERT INTO COURSE VALUES ('C101', 'DBMS', 4, 100);
INSERT INTO COURSE VALUES ('C102', 'OOP with Java', 4, 100);
INSERT INTO COURSE VALUES ('C103', 'Operating Systems', 3, 100);
INSERT INTO COURSE VALUES ('C104', 'Computer Networks', 3, 100);
INSERT INTO COURSE VALUES ('C105', 'Software Engineering', 3, 100);

-- Faculty
INSERT INTO FACULTY VALUES ('F101', 'Dr. Gupta', 'CSE', 'gupta@xyz.com');
INSERT INTO FACULTY VALUES ('F102', 'Mrs. Sen', 'ECE', 'sen@xyz.com');
INSERT INTO FACULTY VALUES ('F103', 'Mr. Ali', 'IT', 'ali@xyz.com');

-- Marks for all students
INSERT INTO MARKS VALUES ('M101', 'S101', 'C101', 85);
INSERT INTO MARKS VALUES ('M102', 'S101', 'C102', 78);
INSERT INTO MARKS VALUES ('M103', 'S101', 'C103', 90);
INSERT INTO MARKS VALUES ('M104', 'S101', 'C104', 82);
INSERT INTO MARKS VALUES ('M105', 'S101', 'C105', 75);

INSERT INTO MARKS VALUES ('M106', 'S102', 'C101', 70);
INSERT INTO MARKS VALUES ('M107', 'S102', 'C102', 60);
INSERT INTO MARKS VALUES ('M108', 'S102', 'C103', 75);
INSERT INTO MARKS VALUES ('M109', 'S102', 'C104', 68);
INSERT INTO MARKS VALUES ('M110', 'S102', 'C105', 72);

INSERT INTO MARKS VALUES ('M111', 'S103', 'C101', 92);
INSERT INTO MARKS VALUES ('M112', 'S103', 'C102', 88);
INSERT INTO MARKS VALUES ('M113', 'S103', 'C103', 91);
INSERT INTO MARKS VALUES ('M114', 'S103', 'C104', 89);
INSERT INTO MARKS VALUES ('M115', 'S103', 'C105', 86);

INSERT INTO MARKS VALUES ('M116', 'S104', 'C101', 65);
INSERT INTO MARKS VALUES ('M117', 'S104', 'C102', 58);
INSERT INTO MARKS VALUES ('M118', 'S104', 'C103', 62);
INSERT INTO MARKS VALUES ('M119', 'S104', 'C104', 67);
INSERT INTO MARKS VALUES ('M120', 'S104', 'C105', 70);

INSERT INTO MARKS VALUES ('M121', 'S105', 'C101', 80);
INSERT INTO MARKS VALUES ('M122', 'S105', 'C102', 77);
INSERT INTO MARKS VALUES ('M123', 'S105', 'C103', 79);
INSERT INTO MARKS VALUES ('M124', 'S105', 'C104', 76);
INSERT INTO MARKS VALUES ('M125', 'S105', 'C105', 74);

-- GPA Calculation and Insert Script using PL/SQL
BEGIN
    FOR r IN (SELECT Student_ID, SUM(Marks_Obtained) AS total, SUM(Max_Marks) AS max_total
              FROM MARKS M JOIN COURSE C ON M.Course_ID = C.Course_ID
              GROUP BY Student_ID) LOOP
        DECLARE
            gpa NUMBER(4,2);
            grade VARCHAR2(2);
        BEGIN
            gpa := ROUND((r.total / r.max_total) * 10, 2);
            IF gpa >= 9 THEN grade := 'A+';
            ELSIF gpa >= 8 THEN grade := 'A';
            ELSIF gpa >= 7 THEN grade := 'B';
            ELSIF gpa >= 6 THEN grade := 'C';
            ELSE grade := 'F';
            END IF;

            INSERT INTO RESULT (Result_ID, Student_ID, GPA, Grade, Semester)
            VALUES ('R_' || r.Student_ID, r.Student_ID, gpa, grade, 4);
        END;
    END LOOP;
END;
/

-- View GPA results
SELECT * FROM RESULT;
