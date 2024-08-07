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


INSERT INTO Fact_crash
(
    ReportNumberID, roadlocationID, VehicleID, driverpersonID, incidentdetailsID,
    Number_of_Crashes, Number_of_Injured, Most_Common_CrashType, Most_Common_Weather
)
SELECT
    NULL AS ReportNumberID,
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