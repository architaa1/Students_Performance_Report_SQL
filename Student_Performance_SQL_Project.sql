create database students;
use students;
Rename table bd_students_per_v2 to Students;
-- Total no of students
select count(*) from students;
-- find max and min age
select max(age) as "Max Age", min(age) as "Min Age"
from  students;
-- find max and min study time
select max(studytime) as "Max study time", 
min(studytime) as "Min study time" from students;
-- find max and min attendance
select max(attendance) as "Max attendance",
min(attendance) as "Min attendance" from students;
-- max and min attendance with names
Select full_name as StudentName, 
attendance as Attendance
From students
Where attendance
= (Select Max(attendance) From students)
union all
Select full_name as StudentName, 
attendance as Attendance
From students
Where attendance
= (Select Min(attendance) From students);
-- count location
select location, count(location) as "Count"
from students 
group by location;
-- count male and female students
select gender, count(gender) as "count"
from students
group by gender;
-- Impact of parental education on scores
select mother_education,avg(english), avg(math), 
avg(science), avg(social_science) 
from students
group by mother_education;
-- top 5 performers in english, maths, science
select full_name,english from students
order by english desc
limit 5;
select full_name,math from students
order by math desc
limit 5;
select full_name,science from students
order by science desc
limit 5;
-- impact of tutoring on scores
select tutoring, AVG(english + math + science
 + social_science + art_culture) 
AS AvgScore
FROM students
GROUP BY tutoring;
-- impact of extra curricular activities on tutoring
SELECT extra_curricular_activities, 
AVG(english + math + science
+ social_science + art_culture) AS AvgScore
FROM students
GROUP BY extra_curricular_activities;
-- impact of attendance on scores
SELECT attendance, 
AVG(english + math + science
+ social_science + art_culture) AS AvgScore
FROM students
GROUP BY attendance
order by attendance desc;
-- impact of school type on scores
SELECT school_type, 
AVG(english + math + science
+ social_science + art_culture) AS AvgScore
FROM students
GROUP BY school_type;
-- impact of study time on scores
SELECT studytime, 
AVG(english + math + science
+ social_science + art_culture) AS AvgScore
FROM students
GROUP BY studytime
order by studytime desc;
-- impact of internet access on scores
SELECT internet_access, 
AVG(english + math + science
+ social_science + art_culture) AS AvgScore
FROM students
GROUP BY internet_access;
-- scores by student group
SELECT stu_group, 
AVG(english + math + science
+ social_science + art_culture) AS AvgScore
FROM students
GROUP BY stu_group
order by avgscore desc;
-- find grades for different marks
set @stdid= 390;
select @sname:= full_name from students where
id=@stdid;
select @eng:= english from students where
id=@stdid;
select @maths:= math from students where
id=@stdid;
select @sci:= science from students where
id=@stdid;
select @ssc:= social_science from students where
id=@stdid;
select @art:= art_culture from students where
id=@stdid;
set @total= @eng + @maths + @sci + @ssc + @art;
set @percent= @total*100/500;
select @stdid as "id", @sname as "std Name",
@eng as "english", @maths as "math",
@sci as "science", @ssc as "social science",
@art as "art culture", @total as "total marks",
@percent as "percent";
drop procedure findgrade;
delimiter &&
create procedure findgrade(stdid int)
begin
if (@percent >= 90) then
select "Grade A, Excellent";
elseif (@percent >= 80) then
select "Grade B, Better" ;
elseif (@percent >= 70) then
select "Grade C, Good" ;
elseif (@percent >= 60) then
select "Grade D, Satifactory" ;
elseif (@percent >= 50) then
select "Grade E, Need Improvement" ;
else
select "Failed" ;
end if;
 end && delimiter ;
 call findgrade(390);