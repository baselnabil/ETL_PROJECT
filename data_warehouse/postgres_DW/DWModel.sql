-- DIM TABLES FOR THE MODEL

DROP TABLE IF EXISTS Dim_report_case;
CREATE TABLE Dim_report_case (
    ID SERIAL PRIMARY KEY,
    Report_Number VARCHAR,
    Local_Case_Number VARCHAR,
    Agency_Name VARCHAR,
    ACRS_Report_Type VARCHAR,
    Crash_Date_Time TIMESTAMP,
    Location VARCHAR
);

DROP TABLE IF EXISTS Dim_Time;
CREATE TABLE Dim_Time (
    ID SERIAL PRIMARY KEY,
    Date DATE,
    TimeS TIMESTAMP,
    Year INT,
    Month INT,
    Day INT,
    Hour INT,
    Minute INT,
    Second INT,
    AM_PM VARCHAR(2)
);


DROP TABLE IF EXISTS Dim_road_location;
CREATE TABLE Dim_road_location (
    ID SERIAL PRIMARY KEY,
    Route_Type VARCHAR,
    Road_Name VARCHAR,
    Cross_Street_Name VARCHAR,
    Latitude FLOAT,
    Longitude FLOAT
);

DROP TABLE IF EXISTS Dim_vehicle;
CREATE TABLE Dim_vehicle (
    ID SERIAL PRIMARY KEY,
    Vehicle_ID VARCHAR,
    Vehicle_Damage_Extent VARCHAR,
    Vehicle_First_Impact_Location VARCHAR,
    Vehicle_Second_Impact_Location VARCHAR,
    Vehicle_Body_Type VARCHAR,
    Vehicle_Movement VARCHAR,
    Vehicle_Continuing_Dir VARCHAR,
    Vehicle_Going_Dir VARCHAR,
    Speed_Limit INT,
    Driverless_Vehicle BOOLEAN,
    Parked_Vehicle BOOLEAN,
    Vehicle_Year INT,
    Vehicle_Make VARCHAR,
    Vehicle_Model VARCHAR,
    Equipment_Problems VARCHAR
);

DROP TABLE IF EXISTS Dim_driver_person;
CREATE TABLE Dim_driver_person (
    ID SERIAL PRIMARY KEY,
    Person_ID VARCHAR,
    Driver_At_Fault BOOLEAN,
    Driver_Substance_Abuse VARCHAR,
    Driver_Distracted_By VARCHAR,
    Drivers_License_State VARCHAR
);

DROP TABLE IF EXISTS Dim_incident_details;
CREATE TABLE Dim_incident_details (
    ID SERIAL PRIMARY KEY,
    Collision_Type VARCHAR,
    Weather VARCHAR,
    Surface_Condition VARCHAR,
    Light VARCHAR,
    Traffic_Control VARCHAR,
    Injury_Severity VARCHAR
);

-- IMPORT DATA INTO DIM TABLES


copy Dim_report_case(ID, Report_Number, Local_Case_Number, Agency_Name, ACRS_Report_Type, Crash_Date_Time, Location)
FROM '{{DATA_PATH}}/loaded/report_case.csv' DELIMITER ',' CSV HEADER;

copy Dim_road_location(ID, Route_Type, Road_Name, Cross_Street_Name, Latitude, Longitude)
FROM '{{DATA_PATH}}/loaded/road_location.csv' DELIMITER ',' CSV HEADER;

copy Dim_vehicle(ID, Vehicle_ID, Vehicle_Damage_Extent, Vehicle_First_Impact_Location, Vehicle_Second_Impact_Location, Vehicle_Body_Type, Vehicle_Movement, Vehicle_Continuing_Dir, Vehicle_Going_Dir, Speed_Limit, Driverless_Vehicle, Parked_Vehicle, Vehicle_Year, Vehicle_Make, Vehicle_Model, Equipment_Problems)
FROM '{{DATA_PATH}}/loaded/vehicle.csv' DELIMITER ',' CSV HEADER;

copy Dim_driver_person(ID, Person_ID, Driver_At_Fault, Driver_Substance_Abuse, Driver_Distracted_By, Drivers_License_State)
FROM '{{DATA_PATH}}/loaded/driver_person.txt' DELIMITER ',' CSV HEADER;

copy Dim_incident_details(ID, Collision_Type, Weather, Surface_Condition, Light, Traffic_Control, Injury_Severity)
FROM '{{DATA_PATH}}/loaded/incident_details.txt' DELIMITER ',' CSV HEADER;

-- INSERT DATA INTO DIM_TIME by extracting from Crash_Date_Time column in Dim_report_case

INSERT INTO Dim_Time (ID, Date, TimeS, Year, Month, Day, Hour, Minute, Second, AM_PM)
SELECT 
    r.ID AS ID,
    DATE(r.Crash_Date_Time) AS Date,
    r.Crash_Date_Time AS TimeS,
    EXTRACT(YEAR FROM r.Crash_Date_Time) AS Year,
    EXTRACT(MONTH FROM r.Crash_Date_Time) AS Month,
    EXTRACT(DAY FROM r.Crash_Date_Time) AS Day,
    EXTRACT(HOUR FROM r.Crash_Date_Time) AS Hour,
    EXTRACT(MINUTE FROM r.Crash_Date_Time) AS Minute,
    EXTRACT(SECOND FROM r.Crash_Date_Time) AS Second,
    CASE 
        WHEN EXTRACT(HOUR FROM r.Crash_Date_Time) < 12 THEN 'AM'
        ELSE 'PM'
    END AS AM_PM
FROM Dim_report_case r;


ALTER TABLE Dim_report_case DROP COLUMN Crash_Date_Time;


DROP TABLE IF EXISTS Fact_crash;
CREATE TABLE Fact_crash (
    ID SERIAL PRIMARY KEY,
    ReportNumberID INT,
    TimeID INT,
    roadlocationID INT,
    VehicleID INT,
    driverpersonID INT,
    incidentdetailsID INT,
    Number_of_Crashes INT,
    Number_of_Injured INT,
    Most_Common_CrashType VARCHAR,
    Most_Common_Weather VARCHAR,

    FOREIGN KEY (ReportNumberID) REFERENCES Dim_report_case(ID),
    FOREIGN KEY (TimeID) REFERENCES Dim_Time(ID),
    FOREIGN KEY (roadlocationID) REFERENCES Dim_road_location(ID),
    FOREIGN KEY (VehicleID) REFERENCES Dim_vehicle(ID),
    FOREIGN KEY (driverpersonID) REFERENCES Dim_driver_person(ID),
    FOREIGN KEY (incidentdetailsID) REFERENCES Dim_incident_details(ID)
);





-- ANALYTICS QUERIES FOR THE MODEL

INSERT INTO Fact_crash
(
    ReportNumberID, roadlocationID, VehicleID, driverpersonID, incidentdetailsID,
    Number_of_Crashes, Number_of_Injured, Most_Common_CrashType, Most_Common_Weather
)
SELECT
    NULL AS ReportNumberID,
    NULL AS TimeID,
    NULL AS roadlocationID,
    NULL AS VehicleID,
    NULL AS driverpersonID,
    NULL AS incidentdetailsID,
    COUNT(*) AS Number_of_Crashes,
    COUNT(
        CASE
            WHEN id.Injury_Severity IS NOT NULL
                 AND id.Injury_Severity != 'NO APPARENT INJURY'
            THEN 1
            ELSE NULL
        END
    ) AS Number_of_Injured,
    (SELECT Collision_Type
     FROM Dim_incident_details
     GROUP BY Collision_Type
     ORDER BY COUNT(*) DESC
     LIMIT 1) AS Most_Common_CrashType, 
    (SELECT Weather
     FROM Dim_incident_details
     GROUP BY Weather
     ORDER BY COUNT(*) DESC
     LIMIT 1) AS Most_Common_Weather 
FROM Dim_report_case r
JOIN Dim_road_location rl ON r.ID = rl.ID
JOIN Dim_vehicle v ON r.ID = v.ID
JOIN Dim_driver_person dp ON r.ID = dp.ID
JOIN Dim_incident_details id ON r.ID = id.ID;