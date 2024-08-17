# !/bin/sh
INPUT_FILE=$1
OUTPUT_DB="$INPUT_FILE.db"
INITIALIZE_SQL="initialize.sql"
TABLE_NAME="data"

# Check if OUTPUT_DB exists, removing it if it does
if [ -f $OUTPUT_DB ]; then
    rm $OUTPUT_DB
fi

# Check if initialize.sql exists, removing it if it does
if [ -f $INITIALIZE_SQL ]; then
    rm $INITIALIZE_SQL
fi

# Generate initialize.sql for the provided input arguments using jinja
jinja initialize.sql.j2 \
    -D table_name $TABLE_NAME \
    -D file_name $INPUT_FILE \
    > initialize.sql

# Create SQLite3 connection to OUTPUT_DB, executing initialize.sql
sqlite3 $OUTPUT_DB < ./initialize.sql

# Open OUTPUT_DB in SQLite3 CLI
sqlite3 $OUTPUT_DB