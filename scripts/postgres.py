import os
import psycopg

# Get the path to the data directory
basepath = os.path.dirname(__file__)
default_path = os.path.abspath(os.path.join(basepath, '../data/'))
data_path = os.getenv('DATA_PATH', default_path)

model_path = os.path.abspath(os.path.join(basepath, '../data_warehouse')) + '/postgres_DW/DWModel.sql'
# Read the SQL file
with open(model_path, 'r') as file:
    sql = file.read()

# Replace the placeholder with the actual path
sql = sql.replace('{{DATA_PATH}}', data_path)

# Connect to the database and execute the SQL
conn = psycopg.connect("dbname=DW user=root password=password")
cur = conn.cursor()

cur.execute(sql)
conn.commit()

# Close the connection
cur.close()
conn.close()
