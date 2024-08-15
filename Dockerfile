# Description: Dockerfile for building a custom image with SQL Server 2019 and SQL Server Integration Services (SSIS) 2019  
FROM mcr.microsoft.com/mssql/server:2019-latest
USER root

RUN apt-get update && \
    apt-get install -y software-properties-common curl && \
    rm -rf /var/lib/apt/lists/*

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN add-apt-repository "$(curl https://packages.microsoft.com/config/ubuntu/20.04/mssql-server-2019.list)"

# Install SQL Server Integration Services (SSIS)
RUN apt-get update
RUN apt-get install -y mssql-server-is

# Set up SSIS
RUN echo "[TELEMETRY]\nenabled = F" > /var/opt/ssis/ssis.conf

RUN SSIS_PID=Express ACCEPT_EULA=Y /opt/ssis/bin/ssis-conf -n setup

USER mssql


FROM python:3.12-slim

WORKDIR /app

COPY . .

RUN pip install --upgrade pip && \
pip install --no-cache-dir -r requirements.txt 
# pandas, and any other dependencies FROM requirements.txt

CMD ["python", "scripts/setup.py"]
