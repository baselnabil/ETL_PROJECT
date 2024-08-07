#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas
import os
#import psycopg

basepath = os.path.dirname(__file__)
default_path = os.path.abspath(basepath)

# In[2]:


baseCsv = pandas.read_csv(basepath + '/raw/crash_data.csv', sep=',', index_col=False, low_memory=False)


# In[3]:


baseCsv['Report Number'] = baseCsv['Report Number'].astype(str).str.strip()
baseCsv = baseCsv.drop_duplicates(subset=['Report Number'], keep='first').reset_index(drop=True)


# In[4]:


NullPrecentage = baseCsv.isnull().sum() * 100 / len(baseCsv)
NullPrecentage


# # Removing Colums with more than 60% Null Values
# ## Following the Business Model

# In[5]:


ColumnsToDrop = NullPrecentage[NullPrecentage > 60].index
if not ColumnsToDrop.empty:
 baseCsv = baseCsv.drop(ColumnsToDrop, axis=1)
baseCsv.dtypes


# In[6]:


baseCsv.isnull().sum()


# # Removing `Yes,No,Nulls` into valid Boolean for use
# ## Replacing `Nulls` in the rest with the most frequent value found in that column 

# In[7]:


baseCsv['Driverless Vehicle'] = baseCsv['Driverless Vehicle'].str.lower()
baseCsv['Driverless Vehicle'] = baseCsv['Driverless Vehicle'].replace({
    'yes': True,
    'no': False,
    'unknown': False
})

baseCsv['Parked Vehicle'] = baseCsv['Parked Vehicle'].str.lower()
baseCsv['Parked Vehicle'] = baseCsv['Parked Vehicle'].replace({
    'yes': True,
    'no': False,
    'unknown': False
})

baseCsv['Driver Substance Abuse'] = baseCsv['Driver Substance Abuse'].str.lower()
baseCsv['Driver Substance Abuse'] = baseCsv['Driver Substance Abuse'].replace({
    'yes': True,
    'no': False,
    'unknown': False
})

baseCsv['Driver At Fault'] = baseCsv['Driver At Fault'].str.lower()
baseCsv['Driver At Fault'] = baseCsv['Driver At Fault'].replace({
    'yes': True,
    'no': False,
    'unknown': False
}).astype('boolean')

baseCsv = baseCsv.apply(
    lambda col: col.fillna(
        col.loc[
            ~col.str.lower().isin(['unknown', 'n/a'])
        ].mode()[0] if col.dropna().size > 0 and not col.loc[
            ~col.str.lower().isin(['unknown', 'n/a'])
        ].mode().empty else col.fillna('N/A')
    ) 
    if col.dtype == 'object' else col.fillna(0), 
    axis=0
)


# In[8]:


baseCsv.isnull().sum()


# In[9]:


# Group 1: Report and Case Information
df_report_case = baseCsv[['Report Number', 'Local Case Number', 'Agency Name', "ACRS Report Type", "Crash Date/Time", 'Location']]
df_report_case.insert(0, 'ID', range(1, 1 + len(df_report_case)))

# Group 2: Road and Location Information 
df_road_location = baseCsv[['Route Type', 'Road Name', 
                       'Cross-Street Name', 'Latitude', 'Longitude']]
df_road_location.insert(0, 'ID', range(1, 1 + len(df_road_location)))


# Group 3: Vehicle Information 
df_vehicle = baseCsv[['Vehicle ID', 'Vehicle Damage Extent', 
                 'Vehicle First Impact Location', 'Vehicle Second Impact Location', 
                 'Vehicle Body Type', 'Vehicle Movement', 'Vehicle Continuing Dir', 
                 'Vehicle Going Dir', 'Speed Limit', 'Driverless Vehicle', 
                 'Parked Vehicle', 'Vehicle Year', 'Vehicle Make', 'Vehicle Model', 
                 'Equipment Problems']]
df_vehicle.insert(0, 'ID', range(1, 1 + len(df_vehicle)))

# Group 4: Driver and Person Information
df_driver_person = baseCsv[['Person ID', 'Driver At Fault', 
                       'Driver Substance Abuse', 'Driver Distracted By', 
                       'Drivers License State']]
df_driver_person.insert(0, 'ID', range(1, 1 + len(df_driver_person)))


# Group 5: Incident Details 
df_incident_details = baseCsv[['Collision Type', 'Weather', 'Surface Condition', 
                          'Light', 'Traffic Control', 'Injury Severity']]
df_incident_details.insert(0, 'ID', range(1, 1 + len(df_incident_details)))


# In[10]:


df_report_case.to_csv(basepath + '/loaded/report_case.csv', index=False)
df_road_location.to_csv(basepath + '/loaded/road_location.csv', index=False)
df_vehicle.to_csv(basepath + '/loaded/vehicle.csv', index=False)
df_driver_person.to_csv(basepath + '/loaded/driver_person.txt', sep=',', index=False, header=True)
df_incident_details.to_csv(basepath + '/loaded/incident_details.txt', sep=',', index=False, header=True)

