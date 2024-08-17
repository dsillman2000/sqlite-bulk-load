# !/bin/sh
OUTPUT_FILE=$1

if [ -f $OUTPUT_FILE ]; then
    rm $OUTPUT_FILE
fi

# Fetch data from some public API and store it in my_data.log
curl -s https://jsonplaceholder.typicode.com/posts > $OUTPUT_FILE