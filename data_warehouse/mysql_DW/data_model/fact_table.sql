USE data_warehouse;
-- Fact Table: crash_fact
CREATE TABLE crash_fact (
    report_number VARCHAR(255),
    person_id VARCHAR(255),
    vehicle_id VARCHAR(255),
    date_id VARCHAR(255),
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6),
    location VARCHAR(255),
    PRIMARY KEY (report_number),
    FOREIGN KEY (report_number) REFERENCES report_description(report_number),
    FOREIGN KEY (person_id) REFERENCES driver_description(person_id),
    FOREIGN KEY (vehicle_id) REFERENCES vehicle_description(vehicle_id),
    FOREIGN KEY (date_id) REFERENCES date_description(date_id)
);



USE data_warehouse;

-- Insert Aggregated Data into crash_fact
INSERT INTO crash_fact (report_number, person_id, vehicle_id, date_id, most_common_collision_type, total_crashes, most_common_vehicle_model, crashes_per_day)
SELECT
    rd.report_number,
    dd.person_id,
    vd.vehicle_id,
    d.date_id,
    (SELECT TOP 1 collision_type
     FROM report_description
     GROUP BY collision_type
     ORDER BY COUNT(*) DESC) AS most_common_collision_type,
    (SELECT COUNT(*)
     FROM report_description) AS total_crashes,
    (SELECT TOP 1 vehicle_model
     FROM vehicle_description
     GROUP BY vehicle_model
     ORDER BY COUNT(*) DESC) AS most_common_vehicle_model,
    (SELECT COUNT(*)
     FROM report_description
     GROUP BY DATE(rd.crash_date_time)) AS crashes_per_day
FROM
    report_description rd
JOIN
    driver_description dd ON rd.report_number = dd.person_id
JOIN
    vehicle_description vd ON rd.report_number = vd.vehicle_id
JOIN
    date_description d ON DATE(rd.crash_date_time) = d.date_id;
