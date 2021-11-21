#!/bin/bash

set -e

cd "$(dirname "$0")"

psql -d f1 -f create_tables.sql

working_dir=/tmp/f1
mkdir -p $working_dir
cd $working_dir
curl -o f1db_csv.zip https://ergast.com/downloads/f1db_csv.zip
unzip -o f1db_csv.zip


for file in *.csv; do
    sed -i .bak 's/\\N//g' $file
    psql -v ON_ERROR_STOP=1 --dbname f1 <<EOF
\copy ergast.${file%.*} FROM $file WITH (FORMAT CSV, HEADER true);
EOF
done
