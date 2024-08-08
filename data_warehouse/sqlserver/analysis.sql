--deleting the null rows if exists
Delete from crash_fact where [Report Number] is NULL;
Delete from report_description where [Report Number] is NULL;
-- deleting from the main schema
--deleting columns with all null values 
delete from dbo.gg where [Report Number] is NULL;
-- Analyze the types of vehicles involved in crashes.
select [Vehicle Model],count(*) from crash_fact inner join dbo.vehicle_description on crash_fact.[Vehicle ID]=vehicle_description.[Vehicle ID] group by [Vehicle Model];
-- Location-Based Crash Analysis: � Identify crash hotspots by location.
select count (*) as hotspots,Location from gg group by Location order by hotspots desc;
-- Analyze crashes by severity and contributing factors.
select [Injury Severity] ,count(*) from dbo.crash_fact 
inner join dbo.driver_description on 
crash_fact.[Person ID]=driver_description.[Person ID] 
group by [Injury Severity];
-- Analyze crashes by contributing factors.
select Circumstance,[Driver Distracted By] from 
dbo.crash_fact inner join dbo.driver_description on 
crash_fact.[Person ID]=driver_description.[Person ID] ;
--Driverless and Parked Vehicle Analysis: � Analyze the involvement of driverless and parked vehicles in crashes.
select count(*) as occ,[Vehicle Movement] from dbo.vehicle_description group by [Vehicle Movement] order by occ desc;
--Weather Condition Analysis
select [Surface Condition],count(*) from dbo.crash_fact inner join dbo.report_description on dbo.crash_fact.[Report Number]=dbo.report_description.[Report Number] group by [Surface Condition] order by count(*);
-- Light Condition Analysis
select Light,count(*) as num from dbo.crash_fact inner join dbo.report_description on crash_fact.[Report Number]=report_description.[Report Number] group by Light order by num desc;
--Analyze of distractions
select [Driver Distracted By],count(*) from dbo.crash_fact inner join dbo.driver_description on 
crash_fact.[Person ID]=driver_description.[Person ID] group by [Driver Distracted By];
--Drivers with how many accidents
select dbo.crash_fact.[Person ID],count(*) from crash_fact inner join dbo.driver_description on dbo.crash_fact.[Person ID]=dbo.driver_description.[Person ID] group by dbo.crash_fact.[Person ID];
-- Analaysis by Date
-- By day
select day_of_week,count(*) from dbo.crash_fact inner join dbo.date_description 
on dbo.crash_fact.date_id=date_description.date_id group by day_of_week;
--By month
select month,count(*) from dbo.crash_fact inner join dbo.date_description 
on dbo.crash_fact.date_id=date_description.date_id group by month;
--By Hour
select hour,count(hour) from dbo.crash_fact inner join dbo.date_description 
on dbo.crash_fact.date_id=date_description.date_id group by dbo.date_description.hour;
select * from date_description;





