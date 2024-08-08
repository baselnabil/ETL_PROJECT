FROM python:3.12-slim

WORKDIR /app

COPY . .

RUN pip install --upgrade pip && \
pip install --no-cache-dir -r requirements.txt 
# pandas, and any other dependencies

CMD ["scripts/start_DW.sh"]