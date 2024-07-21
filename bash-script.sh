#!/bin/bash

# Log file path
LOG_FILE="/var/log/system_info.log"

# Function to log messages with timestamp
log_message() {
    local log_message="$1"
    local timestamp=$(date +"%Y-%m-%d %T")
    echo "[$timestamp] $log_message" >> "$LOG_FILE"
}

# Function to gather system information and log it
log_system_status() {
    log_message "CPU Usage:"
    top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print "   Used : " 100 - $1 "%" }'
    log_message "RAM Usage:"
    free -m | awk '/Mem/{printf "   Total : %s MB\n   Used : %s MB\n", $2, $3}'
    log_message "Disk Usage:"
    df -h | awk '$NF=="/"{printf "   Total : %d GB\n   Used : %d GB (%s)\n", $2/1024/1024, $3/1024/1024,$5}'
}

# Log initial message
log_message "System status script started"

# Log system status
log_system_status

# Log final message
log_message "System status script finished"

