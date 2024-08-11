import os
import psycopg2 as psycopg

basepath = os.path.dirname(__file__)
default_path = os.path.abspath(os.path.join(basepath, '../data/'))
data_path = os.getenv('DATA_PATH', default_path)

model_path = os.path.abspath(os.path.join(basepath, '../data_warehouse')) + '/postgres_DW/DWModel.sql'
with open(model_path, 'r') as file:
    sql = file.read()

sql = sql.replace('{{DATA_PATH}}', data_path)


conn = psycopg.connect("dbname=DW user=root password=password")
cur = conn.cursor()

cur.execute(sql)
conn.commit()

cur.close()
conn.close()
