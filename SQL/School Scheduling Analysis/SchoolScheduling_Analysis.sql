-- What kind of titles are associated with our faculty?
Select f.staffid, s.stffirstname, f.title from faculty f
inner join staff s on s.staffid = f.staffid order by f.title desc;

-- Show an alphabetical list of all the staff members and their salaries if they make between $40,000 and $50,000 a year
Select concat(stffirstname,' ',stflastname) as 'Staff Name', Salary from staff
where salary > 40000 and salary < 50000 order by 1 asc;

-- Provide a list of staff members and their salaries if they make at least $35000 a year
Select staffid, salary, Concat(stffirstName,' ',stflastName) as 'Staff name' from staff 
where salary>=35000 order by salary asc;

-- How many classes are held in room 3346?
Select count(*) as 'Total Classes' from classes
where classroomid = 3346;

-- Provide a list of students whose first name starts with ‘B’ or who live in Seattle
Select studcity, Concat(studfirstName,' ',studlastName) as 'Student name' from students  
where studfirstname like 'B%' or studcity='Seattle';

-- Show the subject categories that have fewer than three full professors teaching that subject
Select c.categorydescription, count(f.staffid) as profcount from categories c
left join faculty_categories fc on fc.categoryid = c.categoryid
left join faculty f on f.staffid = fc.staffid and f.title = 'Professor'
group by c.categorydescription having count(f.staffid) < 3 order by profcount asc;

-- List the subjects taught on Wednesday
Select distinct s.subjectname, c.wednesdayschedule from subjects s
inner join classes c on s.subjectid = c.subjectid 
where c.wednesdayschedule = 1;

-- Display students enrolled in a class on Tuesday
Select distinct concat(studfirstname,' ',studlastname) as 'Student name' from students s
inner join student_schedules sc on s.studentid = sc.studentid
inner join classes c on sc.classid = c.classid 
where c.tuesdayschedule = 1;

-- List each staff member and the count of classes each is scheduled to teach
Select st.staffid, concat(st.stffirstname,' ', st.stflastname) as 'Staff name', count(fc.classid) as classes_count from staff st
left join faculty_classes fc on fc.staffid = st.staffid
group by st.staffid order by classes_count desc;

-- For all staff in ZIP Codes 98270 and 98271, change the area code to 360.
Update staff 
set stfareacode = '360'
where stfzipcode in ('98270', '98271');

-- Staff Tim Smith wants to enroll as a student. Create a new student record from Tim’s staff record
Insert into students (studfirstname, studlastname, studstreetaddress, studcity, studstate, studzipcode, studareacode, studphonenumber)
Select stffirstname, stflastname, stfstreetaddress, stfcity, stfstate, stfzipcode, stfareacode, stfphonenumber from staff
where stffirstname = 'Tim' and stflastname = 'Smith';
