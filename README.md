# college-student-result-management-sqlplus
A complete Oracle SQL Plus 10g-based College Student Result Management System. This project includes a full database schema, sample data, and an auto GPA calculation script using PL/SQL. Ideal for BCA/CS students to understand core DBMS concepts through a practical academic project.


✅ Project Title: "College Student Result Management System"
🔹 Description:
This system allows admin staff (or faculty) to manage student information, course registrations, marks, and generate results for students.

✅ Main Features:
Add/update/delete student records

Add/update/delete subject details

Enter marks for students

Generate individual student result

Calculate GPA/percentage

View subject-wise performance

View class toppers, subject toppers

✅ Entities for ER Diagram:
STUDENT – stores basic details

COURSE – stores subject/course info

MARKS – stores marks obtained in different subjects

FACULTY – optional, for who entered the marks

RESULT – stores GPA/Grade info per student




RESULT(Result_ID, Student_ID, GPA, Grade, Semester)

FACULTY(Faculty_ID, Name, Department, Email)


