CREATE DATABASE data_warehouse;

drop database data_warehouse
USE data_warehouse;

select * from vehicle_description
-- Dimension Table: vehicle_description
CREATE TABLE vehicle_description (
	[Number] int identity(1,1) primary key,
    [Vehicle ID] VARCHAR(70) ,
    [Vehicle Damage Extent] VARCHAR(70),
    [Vehicle First Impact Location] VARCHAR(70),
    [Vehicle Second Impact Location] VARCHAR(70),
    [Vehicle Body Type] VARCHAR(70),
    [Vehicle Movement] VARCHAR(70),
    [Vehicle Continuing Dir] VARCHAR(70),
    [Vehicle Going Dir] VARCHAR(70),
    [Speed Limit] VARCHAR(70),
    [Driverless Vehicle] VARCHAR(70),
    [Parked Vehicle] VARCHAR(70),
    [Vehicle Year] VARCHAR(70),
    [Vehicle Make] VARCHAR(70),
    [Vehicle Model] VARCHAR(70),
    [Equipment Problems] VARCHAR(70),
    [Latitude] VARCHAR(70),
    [Longitude] VARCHAR(70),
    [Location] VARCHAR(70),
    [Route Type] VARCHAR(70),
    [Road Name] VARCHAR(70),
    [Cross-Street Type] VARCHAR(70),
    [Cross-Street Name] VARCHAR(70),
    [Off-Road Description] VARCHAR(70),
    [Municipality] VARCHAR(70),
    [Related Non-Motorist] VARCHAR(70),
    [Collision Type] VARCHAR(70),
    [Weather] VARCHAR(70),
    [Surface Condition] VARCHAR(70),
    [Light] VARCHAR(70),
    [Traffic Control] VARCHAR(70)
);

-- Dimension Table: report_description
CREATE TABLE report_description (
	[Number] int identity(1,1) primary key,
    [Report Number] VARCHAR(70),
    [Local Case Number] VARCHAR(70),
    [Agency Name] VARCHAR(70),
    [ACRS Report Type] VARCHAR(70),
    [Route Type] VARCHAR(70),
    [Road Name] VARCHAR(70),
    [Cross-Street Type] VARCHAR(70),
    [Cross-Street Name] VARCHAR(70),
    [Off-Road Description] VARCHAR(70),
    [Municipality] VARCHAR(70),
    [Related Non-Motorist] VARCHAR(70),
    [Collision Type] VARCHAR(70),
    [Weather] VARCHAR(70),
    [Surface Condition] VARCHAR(70),
    [Light] VARCHAR(70),
    [Traffic Control] VARCHAR(70),
    [Driver Substance Abuse] VARCHAR(70),
    [Non-Motorist Substance Abuse] VARCHAR(70)
);

-- Dimension Table: driver_description
CREATE TABLE driver_description (
	[Number] int identity(1,1) primary key,
    [Person ID] VARCHAR(70),
    [Driver At Fault] VARCHAR(70),
    [Injury Severity] VARCHAR(70),
    [Circumstance] VARCHAR(70),
    [Driver Distracted By] VARCHAR(70),
    [Drivers License State] VARCHAR(70)
);

-- Dimension Table: date_description
CREATE TABLE date_description (
	[Number] int identity(1,1) primary key,
    [date_id] VARCHAR(70),
    [day_of_week] VARCHAR(70),
    [month] VARCHAR(70),
    [hour] VARCHAR(70)
);




