CREATE DATABASE data_warehouse;

USE data_warehouse;

-- Dimension Table: vehicle_description
CREATE TABLE vehicle_description (
    vehicle_id VARCHAR(255) PRIMARY KEY,
    vehicle_damage_extent VARCHAR(255),
    vehicle_first_impact_location VARCHAR(255),
    vehicle_second_impact_location VARCHAR(255),
    vehicle_body_type VARCHAR(255),
    vehicle_movement VARCHAR(255),
    vehicle_continuing_dir VARCHAR(255),
    vehicle_going_dir VARCHAR(255),
    driverless_vehicle BOOLEAN,
    parked_vehicle BOOLEAN,
    vehicle_year INT,
    vehicle_make VARCHAR(255),
    vehicle_model VARCHAR(255)
);

-- Dimension Table: report_description
CREATE TABLE report_description (
    report_number VARCHAR(255) PRIMARY KEY,
    local_case_number VARCHAR(255),
    agency_name VARCHAR(255),
    acrs_report_type VARCHAR(255),
    crash_date_time DATETIME,
    route_type VARCHAR(255),
    road_name VARCHAR(255),
    cross_street_type VARCHAR(255),
    cross_street_name VARCHAR(255),
    off_road_description TEXT,
    municipality VARCHAR(255),
    related_non_motorist VARCHAR(255),
    collision_type VARCHAR(255),
    weather VARCHAR(255),
    surface_condition VARCHAR(255),
    light VARCHAR(255),
    traffic_control VARCHAR(255),
    driver_substance_abuse VARCHAR(255),
    non_motorist_substance_abuse VARCHAR(255)
);

-- Dimension Table: road_description
CREATE TABLE road_description (
    route_type VARCHAR(255),
    road_name VARCHAR(255),
    cross_street_type VARCHAR(255),
    cross_street_name VARCHAR(255),
    off_road_description TEXT,
    municipality VARCHAR(255),
    related_non_motorist VARCHAR(255),
    collision_type VARCHAR(255),
    weather VARCHAR(255),
    surface_condition VARCHAR(255),
    light VARCHAR(255),
    traffic_control VARCHAR(255)
);

-- Dimension Table: driver_description
CREATE TABLE driver_description (
    person_id VARCHAR(255) PRIMARY KEY,
    driver_at_fault BOOLEAN,
    injury_severity VARCHAR(255),
    circumstance TEXT,
    driver_distracted_by VARCHAR(255),
    drivers_license_state VARCHAR(255)
);

-- Dimension Table: date_description
CREATE TABLE date_description (
    date_id VARCHAR(255) PRIMARY KEY,
    day_of_week VARCHAR(255),
    month VARCHAR(255),
    hour VARCHAR(255)
);


