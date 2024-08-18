# !/bin/sh
INPUT_FILE=$1
OUTPUT_DB="$INPUT_FILE.db"
INITIALIZE_SQL="initialize.sql"
PARSE_OBJECTS_SQL="parse_objects.sql"

# Check that INPUT_FILE is provided
if [ -z $INPUT_FILE ]; then
    echo "Usage: $0 <input_file>"
    exit 1
fi

# Check if OUTPUT_DB exists, removing it if it does
if [ -f $OUTPUT_DB ]; then
    rm $OUTPUT_DB
fi

# Check if INITIALIZE_SQL exists, removing it if it does
if [ -f $INITIALIZE_SQL ]; then
    rm $INITIALIZE_SQL
fi

# Create INITIALIZE_SQL file with SQL commands to initialize the database
cat <<-EOF > $INITIALIZE_SQL
DROP TABLE IF EXISTS data;
CREATE TABLE data (content TEXT);
.separator "\\r"
.import $INPUT_FILE data
EOF

# Execute SQLite3 with the INITIALIZE_SQL file
sqlite3 $OUTPUT_DB < $INITIALIZE_SQL

# Execute SQLite3 with the PARSE_OBJECTS_SQL file
sqlite3 $OUTPUT_DB < $PARSE_OBJECTS_SQL

sqlite3 $OUTPUT_DB
