#!/bin/bash

##########################
# basic system statistcs #
# tieto intern           #
##########################

BOLD=$(tput bold)
FONT_NORMAL=$(tput sgr0)
GRAY='\033[90m'
RED='\033[0;31m'
LOG_FILE="./system-stats.log"
SLEEP_SECONDS=10
ACCETABLE_USERS_NUMBER=1
MEM_WARNING_LIMIT=75

while true; do
	echo "${BOLD}SYSTEM STATISTICS${FONT_NORMAL}: $(date)" >> "$LOG_FILE"

	#############
	# CPU  stat #
	#############
	cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print $1"%"}')
	echo "${BOLD}CPU Usage${FONT_NORMAL}:  $cpu_usage | " >> "$LOG_FILE"
	
	#############
	# RAM usage #
	#############
	mem_total=`cat /proc/meminfo  | awk '/^MemTotal/ {printf "%.0f", $2/1024}'`
	mem_usage=$(free -m | awk '/Mem:/ {print $3}')
	mem_perc=$(free | awk '/Mem/ {printf("%.0f", ($3/$2)*100)}')
	
	if [ $mem_perc -gt $MEM_WARNING_LIMIT ];then
		MEM_MESSAGE="${RED}More than ${MEM_WARNING_LIMIT}% memory usage is used now"
	else
		MEM_MESSAGE="Memory usage is normal"
	fi

	echo "${BOLD}Memory${FONT_NORMAL}:     $mem_perc% | total: ${mem_total} MB, usage: $mem_usage MB | ${BOLD}$MEM_MESSAGE ${FONT_NORMAL}" >> "$LOG_FILE"

	####################
	# DISK space usage #
	####################
	disk_data=`df --total -h | grep total | tr -s ' ' | cut -d ' ' -f2-5`
	disk_total=`echo $disk_data | cut -d ' ' -f1`
	disk_used=`echo $disk_data | cut -d ' ' -f2`
	disk_avaiable=`echo $disk_data | cut -d ' ' -f3`
	disk_used2=`echo $disk_data | cut -d ' ' -f4`
	echo "${BOLD}Disk Usage${FONT_NORMAL}: $disk_used2 | total: $disk_total, avaiable: $disk_avaiable " >> "$LOG_FILE"

	#############
	# PROCESSES #
	#############
	run_sys_proc=`ps -e | wc -l`
	echo "${GRAY}All running processes: $run_sys_proc${FONT_NORMAL}" >> "$LOG_FILE"

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
	echo "Users: $users, Curr user: $USER. Home directories: $home_dirs | ${BOLD}$users_message${FONT_NORMAL}" >> "$LOG_FILE" 
	
	######################
	# Other instructions #
	######################
	echo "" >> "$LOG_FILE"
	sleep "$SLEEP_SECONDS";
done
