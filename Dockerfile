# Simple image
FROM ubuntu:18.04

# install sqlite3 + curl
RUN apt-get update && apt-get install -y sqlite3 curl

# set the working directory in the container
WORKDIR /app

# copy the cwd to the container
COPY . /app

# download public data to the given file path

RUN echo "Downloading data to /app/my_data.log"
RUN chmod +x /app/download.sh
RUN bash /app/download.sh /app/my_data.log

# convert the data to a sqlite3 database, open CLI
RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["bash", "entrypoint.sh", "/app/my_data.log"]