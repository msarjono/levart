#!/bin/bash

# Directory containing the log files
log_directory=${PWD}

# Get the current date and time
current_time=$(date +%d/%b/%Y:%H:%M:%S)
# Get the date and time 10 minutes ago
start_time=$(date --date="10 minutes ago" +%d/%b/%Y:%H:%M:%S)

# Function to count HTTP 500 errors in the last 10 minutes for a given log file
count_http_500_errors() {
    local log_file=$1
    local count=$(awk -v start="$start_time" -v end="$current_time" '$4 > "["start && $4 < "["end && $9 ~ /^500$/' "$log_file" | wc -l)
    echo "There were $count HTTP 500 errors in $log_file in the last 10 minutes."
}

# Iterate over each log file in the directory
for log_file in "$log_directory"/*.log; do
    count_http_500_errors "$log_file"
done
