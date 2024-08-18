# !/bin/sh
INPUT_FILE=$1
OUTPUT_DB="$INPUT_FILE.db"
INITIALIZE_SQL="initialize.sql"

# Check if OUTPUT_DB exists, removing it if it does
if [ -f $OUTPUT_DB ]; then
    rm $OUTPUT_DB
fi

# Create SQLite3 connection to OUTPUT_DB, executing initialize.sql, creating CLI session
sqlite3 $OUTPUT_DB \
    -cmd "DROP TABLE IF EXISTS data;" \
    -cmd "CREATE TABLE data (content TEXT);" \
    -cmd ".separator \"\\r\"" \
    -cmd ".import $INPUT_FILE data"