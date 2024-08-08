USE data_warehouse;
-- Fact Table: crash_fact
CREATE TABLE crash_fact (
    [Report Number] VARCHAR(70),
    [Person ID] VARCHAR(70),
    [Vehicle ID] VARCHAR(70),
    [Latitude] VARCHAR(70),
    [Longitude] VARCHAR(70),
    [Location] VARCHAR(70),
	[date_id]varchar(70),
    PRIMARY KEY ([Report Number]),
    FOREIGN KEY ([Report Number]) REFERENCES report_description([Report Number]),
    FOREIGN KEY ([Person ID]) REFERENCES driver_description([Person ID]),
    FOREIGN KEY ([Vehicle ID]) REFERENCES vehicle_description([Vehicle ID]),
	FOREIGN KEY ([date_id]) REFERENCES date_description([date_id] )
	)
drop table crash_fact


