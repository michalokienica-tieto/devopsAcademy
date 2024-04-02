#!/bin/bash

##########################
# basic system statistcs #
# tieto intern           #
##########################

LOG_FILE="/var/log/system-stats.log"
ACCETABLE_USERS_NUMBER=1
MEM_WARNING_LIMIT=75

echo "SYSTEM STATISTICS: $(date)" >> "$LOG_FILE"

#############
# CPU  stat #
#############
cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print $1"%"}')
echo "CPU Usage:  $cpu_usage | " >> "$LOG_FILE"

#############
# RAM usage #
#############
mem_total=`cat /proc/meminfo  | awk '/^MemTotal/ {printf "%.0f", $2/1024}'`
mem_usage=$(free -m | awk '/Mem:/ {print $3}')
mem_perc=$(free | awk '/Mem/ {printf("%.0f", ($3/$2)*100)}')

if [ $mem_perc -gt $MEM_WARNING_LIMIT ];then
	MEM_MESSAGE="More than ${MEM_WARNING_LIMIT}% memory usage is used now"
else
	MEM_MESSAGE="Memory usage is normal"
fi

echo "Memory:     $mem_perc% | total: ${mem_total} MB, usage: $mem_usage MB | $MEM_MESSAGE" >> "$LOG_FILE"

####################
# DISK space usage #
####################
disk_data=`df --total -h | grep total | tr -s ' ' | cut -d ' ' -f2-5`
disk_total=`echo $disk_data | cut -d ' ' -f1`
disk_used=`echo $disk_data | cut -d ' ' -f2`
disk_avaiable=`echo $disk_data | cut -d ' ' -f3`
disk_used2=`echo $disk_data | cut -d ' ' -f4`
echo "Disk Usage: $disk_used2 | total: $disk_total, avaiable: $disk_avaiable " >> "$LOG_FILE"

#############
# PROCESSES #
#############
run_sys_proc=`ps -e | wc -l`
echo "All running processes: $run_sys_proc" >> "$LOG_FILE"

#########
# USERS #
#########
users=`who | sort --key=1,1 --unique | wc --lines`
if [ $users -gt $ACCETABLE_USERS_NUMBER ]; then
	users_message="More than ${ACCETABLE_USERS_NUMBER} users logged in"
else
	users_message="Number of logged-in users is normal"
fi
home_dirs=`ls /home | wc -l`
echo "Users: $users, Curr user: $USER. Home directories: $home_dirs | $users_message" >> "$LOG_FILE" 

######################
# Other instructions #
######################
echo "" >> "$LOG_FILE"
