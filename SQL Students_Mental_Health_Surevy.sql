select * from students_details;

select * from attendance_details;

select * from academic_performance;

select * from survey_report;

select * from counseling_session_report;

--List all students with their details.--

select * from students_details sd
right join attendance_details ad on ad.student_id = sd.student_id
right join academic_performance ap on ap.student_id = sd.student_id
right join survey_report sr on sr.student_id = sd.student_id
right join counseling_session_report csr on csr.student_id = sd.student_id


--Show the names and ages of all female students.--

select name,age from students_details
where gender = 'Female';

--What is the average age of students?--

select AVG(cast(age as float)) as Average_Age from students_details;

--How many students are in each class?--

select distinct class, count(student_id) as total_students
from students_details
group by class
order by total_students asc;


--What is the maximum stress level recorded in the mental health surveys?--

select max(stress_level) as Max_stress_level_recorded 
from survey_report;

--OR--

select top 1 stress_level from survey_report
order by stress_level desc;

--OR--

select stress_level from survey_report
group by stress_level 
having stress_level = (select max(stress_level) from survey_report);


--Find students who have a stress level greater than 7.--

select sd.student_id,sd.name from students_details sd
join survey_report sr on  sd.student_id = sr.student_id
where stress_level > 7;

--List the details of students who were present between '2024-03-01' and '2024-06-30'.--

select sd.student_id,sd.name,sd.age,sd.gender, sd.class from students_details sd
join attendance_details ad on sd.student_id=ad.student_id
where ad.date between '2024-03-01' and '2024-06-30' and ad.present = 'TRUE';

--Show the names of students who attended counseling sessions in the last month.--

select sd.name,csr.date from students_details sd
inner join counseling_session_report csr on sd.student_id=csr.student_id
where csr.date >= DATEADD(month,-1,GETDATE())
order by csr.date asc;

--Last Date--

select max(csr.date) as max_date
from counseling_session_report csr

--Find the attendance records for students who have a grade 'A' in Mathematics.--

select ad.attendance_id,ad.date,ad.present, ad.student_id from attendance_details ad 
left join academic_performance ap on ad.student_id=ap.student_id
where ap.grade = 'A';

--What is the average depression score for each class?--

select distinct(sd.class) as Class, avg(cast(sr.depression_score as tinyint)) as avg_depression_score from students_details sd
join survey_report sr on sd.student_id = sr.student_id
group by sd.class;


--How many counseling sessions has each student attended?--

select sd.name,count(cast(sr.survey_id as int)) as Sessions_attended from students_details sd
left join survey_report sr on sd.student_id=sr.student_id
group by sd.name
order by Sessions_attended asc;


--Categorize students' stress levels into 'Low', 'Medium', and 'High'.
--Write a query that uses a case statement to categorize stress levels in the mental_health_surveys table.
select * from survey_report;

select sd.student_id,sd.name,sr.stress_level,
case
when sr.stress_level <=3 then 'Low'
when sr.stress_level between 4 and 6 then 'Medium'
else 'High'
end as stress_category
from students_details sd
join survey_report sr on sr.student_id = sd.student_id;


--Create a stored procedure to insert a new student record.
--Explain how you would create a stored procedure to insert a new student into the students table.

-- checking columns
select * from students_details

-- checking data type of columns
SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'students_details' AND COLUMN_NAME = 'class';

--creating procedure--

create procedure NewRecords 
                 @student_id nvarchar(20), 
				 @name nvarchar(50), 
				 @age nvarchar(20), 
				 @gender nvarchar(20) ,
				 @class nvarchar(20)
as begin
insert into students_details(student_id, name, age, gender, class)
values (@student_id, @name, @age, @gender, @class)

select 'Student details inserted successfully' as result
end;

exec NewRecords 1001,'Jiya',30,'Female','9C'

select top 1 * from students_details
where student_id = 1001;

-- deleting the newly added value

delete from students_details
where student_id=1001

--making changes in the procedure

alter procedure NewRecords
                 @student_id nvarchar(20), 
				 @name nvarchar(50), 
				 @age nvarchar(20), 
				 @gender nvarchar(20) ,
				 @class nvarchar(20)
as begin
insert into students_details(student_id, name, age, gender, class)
values (@student_id, @name, @age, @gender, @class)

select 'Student details inserted successfully' as result
end;

exec NewRecords 1001, 'Karl Johnshon',35,'Male','10A'

select * from students_details
where student_id = 1001;

--Creating procedure to pull out all the data using only student_id

create procedure StudentFullData
                  @students_id varchar(20)

as begin
select sd.student_id,sd.name,sd.age,sd.gender,sd.class,
       ad.date,ad.present,ap.subject,ap.grade,ap.semester,
	   sr.date as survey_date,sr.stress_level,sr.anxiety_level,sr.depression_score,sr.sleep_hours,
	   csr.date as counseling_date,csr.session_notes
from students_details sd
join attendance_details ad on sd.student_id=ad.student_id
join academic_performance ap on sd.student_id=ap.student_id
join survey_report sr on sd.student_id = sr.stress_level
join counseling_session_report csr on sd.student_id=csr.student_id
where sd.student_id = @students_id
order by sd.student_id
end;

begin try
      exec StudentFullData @students_id = 100
end try

begin catch
    select error_message() as ErrorOccured
end catch;

exec StudentFullData @students_id = 100

--making corrections in procedure

alter procedure StudentFullData
                  @students_id int

as begin
select sd.student_id,sd.name,sd.age,sd.gender,sd.class,
       ad.date,ad.present,ap.subject,ap.grade,ap.semester,
	   sr.date as survey_date,sr.stress_level,sr.anxiety_level,sr.depression_score,sr.sleep_hours,
	   csr.date as counseling_date,csr.session_notes
from students_details sd
join attendance_details ad on sd.student_id=ad.student_id
join academic_performance ap on sd.student_id=ap.student_id
join survey_report sr on sd.student_id = sr.student_id
join counseling_session_report csr on sd.student_id=csr.student_id
where sd.student_id = @students_id
order by sd.student_id
end;


--using try and catch to handle errors

begin try
      exec StudentFullData @students_id = 1
end try

begin catch
    select error_message() as ErrorOccured
end catch;


--Use a CTE to find the average stress level of students for each class.

--Write a query using a CTE to calculate the average stress level for each class.

with AverageStressLevel as (select sd.class as Distinct_Class ,sr.stress_level
from students_details sd
join survey_report sr on sd.student_id=sr.student_id)

select Distinct_Class,
avg(cast(stress_level as decimal(5,2))) as Average_stress_level 
from AverageStressLevel
group by Distinct_Class;

-- Step 1: Create the CTE
WITH StudentSurveyCTE AS (
    SELECT 
        sd.class,
        sr.stress_level
    FROM 
        students_details sd
    JOIN 
        survey_report sr ON sd.student_id = sr.student_id
)

-- Step 2: Calculate the average stress level for each class
SELECT 
    class,
    AVG(CAST(stress_level AS DECIMAL(5, 2))) AS avg_stress_level
FROM 
    StudentSurveyCTE
GROUP BY 
    class;


--Write a query using a CTE to find the top 5 students with the highest average grades.

with Top5Students as (select sd.student_id as Student_ID,sd.name as Student_name,
                     avg(case
					 when ap.grade='A' then 1
					 when ap.grade = 'B' then 2
					 when ap.grade = 'C' then 3
					 when ap.grade = 'D' then 4
					 else 5
					 end) as Avg_grade
from 
students_details sd
join academic_performance ap on sd.student_id = ap.student_id
group by sd.student_id,sd.name)

select top 5 * from Top5Students
order by Avg_grade asc;


--What is the total number of hours slept by students with a stress level of 5 or lower

select * from survey_report;

select sum(cast(sleep_hours as decimal(10,2))) as total_seleep_hours from survey_report 
where stress_level <= 5;


--Identify students who have both high stress levels and low sleep hours.

Alter table survey_report 
alter column stress_level tinyint

Alter table survey_report 
alter column anxiety_level tinyint

Alter table survey_report 
alter column depression_score tinyint

Alter table survey_report 
alter column sleep_hours decimal(10,2)


select sd.student_id, sd.name, case 
                                    when sr.stress_level < 3 then 'Low'
							        when sr.stress_level <= 6 then 'Medium'
							        else 'High' 
							        end as Stress_level, 
			                    case 
								     when sr.sleep_hours < 6 then 'Low'
									 when sr.sleep_hours <= 8 then 'Medium'
									 else 'High'
									 end as Sleep_hours
from students_details sd
join survey_report sr on sd.student_id=sr.student_id
where sr.stress_level > 6 and sleep_hours < 6
order by sd.student_id;


--Show the number of absences for each student.

select * from attendance_details;

select distinct student_id, count(present) as total_absence from attendance_details
where present = 'False'
group by student_id
order by total_absence asc;