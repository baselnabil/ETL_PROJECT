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

copy Dim_report_case(ID, Report_Number, Local_Case_Number, Agency_Name, ACRS_Report_Type, Crash_Date_Time, Location)
FROM '/mnt/newVol/Work/ETL_PROJECT/data/loaded/report_case.csv' DELIMITER ',' CSV HEADER;

copy Dim_road_location(ID, Route_Type, Road_Name, Cross_Street_Name, Latitude, Longitude)
FROM '/mnt/newVol/Work/ETL_PROJECT/data/loaded/road_location.csv' DELIMITER ',' CSV HEADER;

copy Dim_vehicle(ID, Vehicle_ID, Vehicle_Damage_Extent, Vehicle_First_Impact_Location, Vehicle_Second_Impact_Location, Vehicle_Body_Type, Vehicle_Movement, Vehicle_Continuing_Dir, Vehicle_Going_Dir, Speed_Limit, Driverless_Vehicle, Parked_Vehicle, Vehicle_Year, Vehicle_Make, Vehicle_Model, Equipment_Problems)
FROM '/mnt/newVol/Work/ETL_PROJECT/data/loaded/vehicle.csv' DELIMITER ',' CSV HEADER;

copy Dim_driver_person(ID, Person_ID, Driver_At_Fault, Driver_Substance_Abuse, Driver_Distracted_By, Drivers_License_State)
FROM '/mnt/newVol/Work/ETL_PROJECT/data/loaded/driver_person.txt' DELIMITER ',' CSV HEADER;

copy Dim_incident_details(ID, Collision_Type, Weather, Surface_Condition, Light, Traffic_Control, Injury_Severity)
FROM '/mnt/newVol/Work/ETL_PROJECT/data/loaded/incident_details.txt' DELIMITER ',' CSV HEADER;



DROP TABLE IF EXISTS Fact_crash;
CREATE TABLE Fact_crash (
    ID SERIAL PRIMARY KEY,
    ReportNumberID INT,
    roadlocationID INT,
    VehicleID INT,
    driverpersonID INT,
    incidentdetailsID INT,
    Number_of_Crashes INT,
    Number_of_Injured INT,
    Most_Common_CrashType VARCHAR,
    Most_Common_Weather VARCHAR,

    FOREIGN KEY (ReportNumberID) REFERENCES Dim_report_case(ID),
    FOREIGN KEY (roadlocationID) REFERENCES Dim_road_location(ID),
    FOREIGN KEY (VehicleID) REFERENCES Dim_vehicle(ID),
    FOREIGN KEY (driverpersonID) REFERENCES Dim_driver_person(ID),
    FOREIGN KEY (incidentdetailsID) REFERENCES Dim_incident_details(ID)
);
