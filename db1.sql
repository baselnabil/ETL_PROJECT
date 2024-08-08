create database extract
use extract

drop table crashReport
CREATE TABLE crashReport (
    [Report Number] VARCHAR(70) NULL,
    [Local Case Number] VARCHAR(70) NULL,
    [Agency Name] VARCHAR(70) NULL,
    [ACRS Report Type] VARCHAR(70) NULL,
    [Route Type] VARCHAR(70) NULL,
    [Road Name] VARCHAR(70) NULL,
    [Cross-Street Type] VARCHAR(70) NULL,
    [Cross-Street Name] VARCHAR(70) NULL,
    [Off-Road Description] VARCHAR(70) NULL,
    [Municipality] VARCHAR(70) NULL,
    [Related Non-Motorist] VARCHAR(70) NULL,
    [Collision Type] VARCHAR(70) NULL,
    [Weather] VARCHAR(70) NULL,
    [Surface Condition] VARCHAR(70) NULL,
    [Light] VARCHAR(70) NULL,
    [Traffic Control] VARCHAR(70) NULL,
    [Driver Substance Abuse] VARCHAR(70) NULL,
    [Non-Motorist Substance Abuse] VARCHAR(70) NULL,
    [Person ID] VARCHAR(70) NULL,
    [Driver At Fault] VARCHAR(70) NULL,
    [Injury Severity] VARCHAR(70) NULL,
    [Circumstance] VARCHAR(70) NULL,
    [Driver Distracted By] VARCHAR(70) NULL,
    [Drivers License State] VARCHAR(70) NULL,
    [Vehicle ID] VARCHAR(70) NULL,
    [Vehicle Damage Extent] VARCHAR(70) NULL,
    [Vehicle First Impact Location] VARCHAR(70) NULL,
    [Vehicle Second Impact Location] VARCHAR(70) NULL,
    [Vehicle Body Type] VARCHAR(70) NULL,
    [Vehicle Movement] VARCHAR(70) NULL,
    [Vehicle Continuing Dir] VARCHAR(70) NULL,
    [Vehicle Going Dir] VARCHAR(70) NULL,
    [Speed Limit] VARCHAR(70) NULL,
    [Driverless Vehicle] VARCHAR(70) NULL,
    [Parked Vehicle] VARCHAR(70) NULL,
    [Vehicle Year] VARCHAR(70) NULL,
    [Vehicle Make] VARCHAR(70) NULL,
    [Vehicle Model] VARCHAR(70) NULL,
    [Equipment Problems] VARCHAR(70) NULL,
    [Latitude] VARCHAR(70) NULL,
    [Longitude] VARCHAR(70) NULL,
    [Location] VARCHAR(70) NULL
);
alter table crashReport
add  [Crash Date/Time] varchar(70)

select [Crash Date/Time] from crashReport



select * from crashReport

