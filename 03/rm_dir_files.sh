#!/bin/bash

LOG_FILE="../02/log.txt"

remove_by_log_file() {
    if [[ ! -f "$LOG_FILE" ]]; then
        echo "Error: Log file not found"
        exit 1
    fi

    while IFS= read -r line; do
        echo "$line" | awk '{print $3}'
        path=$(echo "$line" | awk '{gsub(",", "", $3); print $3}')
        if [[ -e "$path" ]]; then
            rm -rf "$path"
            echo "Removed: $path"
        fi
    done <"$LOG_FILE"
}


remove_by_date_time() {
    echo "Enter start date and time (format: YYYY-MM-DD HH:MM):"
    read -r start_datetime
    echo "Enter end date and time (format: YYYY-MM-DD HH:MM):"
    read -r end_datetime

    
    start_time=$(date -d "$start_datetime" +%s 2>/dev/null)
    end_time=$(date -d "$end_datetime" +%s 2>/dev/null)

    if [[ -z "$start_time" || -z "$end_time" ]]; then
        echo "Error: Invalid date and time format!"
        exit 1
    fi

    find / -path /bin -prune -o -path /sbin -prune -o -type f -newermt "@$start_time" ! -newermt "@$end_time" -exec rm -f {} \; -print 2>/dev/null
    find / -path /bin -prune -o -path /sbin -prune -o -type d -newermt "@$start_time" ! -newermt "@$end_time" -exec rm -rf {} \; -print 2>/dev/null
} 

remove_by_name_mask() {
    echo "Enter name mask like (_080125):"
    read -r name_mask
    
    find / -path /bin -prune -o -path /sbin -prune -o -type f -name "*${name_mask}*" -exec rm -f {} \; -print 2>/dev/null
    find / -path /bin -prune -o -path /sbin -prune -o -type d -name "*${name_mask}*" -exec rm -rf {} \; -print 2>/dev/null

}

rm_dir_files(){
case $NUM_OPTION in
    1)
    remove_by_log_file
    ;;
    2)
    remove_by_date_time
    ;;
    3)
    remove_by_name_mask
    ;;
esac
}