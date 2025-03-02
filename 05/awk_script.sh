#!/bin/bash

LOG_FILE="../04/*.log"

check_logs_files(){
    if [[ -z $(ls $LOG_FILE 2>/dev/null) ]]; then
        echo "Error: Log file not found. Please add log files to \"../04/\""
        exit 1
    fi
}

sort_response_cod() {
    awk '
    {
        response_cod = $9
        if (response_cod ~ /^[0-9]+$/) {
            cods_array[response_cod] = cods_array[response_cod] $0 "\n"
        }
    }
    END {
        for (cod in cods_array){
            printf "%s", cods_array[cod]  
        }    
    }' $LOG_FILE > sort_response_cod.log
    
}

unique_ip() {
    awk '
    {
        ip = $1
        if (ip ~ /^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$/) {
            ip_array[ip] = 1
        }
    }
    END {
        for (uniq_ip in ip_array) {
            print uniq_ip
        }
    }' $LOG_FILE > unique_ip.log
}


4xx_5xx_response() {
    awk '
    {
        response_cod = $9
            if (response_cod ~ /^[45][0-9][0-9]$/) {
                print $0
            }
    }' $LOG_FILE > 4xx_5xx_response.log
    
}

unique_ip_4xx_5xx() {
    awk '
    {
        ip = $1
        response_cod = $9
        if (ip ~ /^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$/ && response_cod ~ /^[45][0-9][0-9]$/) {
            ip_array[ip] = 1
        }
    }
    END {
        for (uniq_ip in ip_array) {
            print uniq_ip
        }
    }' $LOG_FILE > unique_ip_4xx_5xx.log
}



awk_script(){
check_logs_files
case $NUM_OPTION in
    1)
    sort_response_cod
    ;;
    2)
    unique_ip
    ;;
    3)
    4xx_5xx_response
    ;;
    4)
    unique_ip_4xx_5xx
    ;;
esac
}