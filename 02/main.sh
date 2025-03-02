#!/bin/bash

source ./check_params.sh
source ./make_dir_files.sh

START_TIME=$(date +%X)
START_TIME_SEC=$(date +%s)

check_params "$@"

make_dir_files


END_TIME=$(date +%X)
END_TIME_SEC=$(date +%s)

EXECUTION_TIME=$(echo "$END_TIME_SEC - $START_TIME_SEC" | bc)

echo "Script start time = $START_TIME"
echo "Script end time = $END_TIME"
echo "Script execution time = $EXECUTION_TIME sec"