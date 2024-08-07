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