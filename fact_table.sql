USE data_warehouse;
-- Fact Table: crash_fact
CREATE TABLE crash_fact (
    [Report Number] int,
    [Person ID] int,
    [Vehicle ID] int,
    [Latitude] int,
    [Longitude] int,
    [Location] int,
	[date_id]int,
    PRIMARY KEY ([Report Number]),
    FOREIGN KEY ([Report Number]) REFERENCES report_description([Number]),
    FOREIGN KEY ([Person ID]) REFERENCES driver_description([Number]),
    FOREIGN KEY ([Vehicle ID]) REFERENCES vehicle_description([Number]),
	FOREIGN KEY ([date_id]) REFERENCES date_description([Number] )
	)
drop table crash_fact

drop database data_warehouse

select * from crash_fact


