-- INDEXING ON vehicle_description 
CREATE INDEX idx_vehicle_make ON vehicle_description(vehicle_make);
CREATE INDEX idx_vehicle_model ON vehicle_description(vehicle_model);
CREATE INDEX idx_vehicle_year ON vehicle_description(vehicle_year);


--INDEXING ON report_description
CREATE INDEX idx_agency_name ON report_description(agency_name);
CREATE INDEX idx_crash_date_time ON report_description(crash_date_time);
CREATE INDEX idx_collision_type ON report_description(collision_type);
CREATE INDEX idx_weather ON report_description(weather);


--INDEXING ON road_description
CREATE INDEX idx_road_name ON road_description(road_name);
CREATE INDEX idx_municipality ON road_description(municipality);
CREATE INDEX idx_collision_type_road ON road_description(collision_type);


--INDEXING ON driver_description 
CREATE INDEX idx_driver_at_fault ON driver_description(driver_at_fault);
CREATE INDEX idx_drivers_license_state ON driver_description(drivers_license_state);



--INDEXING ON date_description 
CREATE INDEX idx_day_of_week ON date_description(day_of_week);
CREATE INDEX idx_month ON date_description(month);
CREATE INDEX idx_hour ON date_description(hour);


--INDEXING ON crash_fact 
CREATE INDEX idx_report_number ON crash_fact(report_number);
CREATE INDEX idx_person_id ON crash_fact(person_id);
CREATE INDEX idx_vehicle_id ON crash_fact(vehicle_id);
CREATE INDEX idx_date_id ON crash_fact(date_id);
CREATE INDEX idx_location ON crash_fact(location);

