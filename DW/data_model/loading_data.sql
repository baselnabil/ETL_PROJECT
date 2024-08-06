LOAD DATA LOCAL INFILE '/home/basel/basel/etl_project/data/raw/crash_data.csv'
INTO TABLE crash_reports
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
