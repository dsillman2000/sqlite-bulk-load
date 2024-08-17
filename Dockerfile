# image w/ python3 installed
FROM python:3.7-slim

# install sqlite3 + curl
RUN apt-get update && apt-get install -y sqlite3 curl

# pip-install jinja-cli
RUN pip install jinja-cli --no-cache-dir

# set the working directory in the container
WORKDIR /app

# copy the cwd to the container
COPY . /app

# download public data to the given file path

RUN echo "Downloading data to /app/my_data.log"
RUN chmod +x /app/download.sh
RUN sh /app/download.sh /app/my_data.log

# convert the data to a sqlite3 database, open CLI
RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["sh", "entrypoint.sh", "/app/my_data.log"]