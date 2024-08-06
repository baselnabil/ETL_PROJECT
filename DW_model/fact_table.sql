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