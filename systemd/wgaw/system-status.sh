#!/bin/bash

##########################
# basic system statistcs #
# tieto intern           #
##########################

bold=$(tput bold)
normal=$(tput sgr0)
LOG_FILE="./system-stats.log"
SLEEP_SECONDS=3
ACCETABLE_USERS_NUMBER=1
MEM_WARNING_LIMIT=75

while true; do
	echo "${bold}SYSTEM STATISTICS${normal}: $(date)" >> "$LOG_FILE"

	CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print $1"%"}')
	echo "${bold}CPU Usage${normal}: $CPU_USAGE" >> "$LOG_FILE"
	
	MEM_USAGE=$(free -m | awk '/Mem:/ {print $3}')
	MEM_PERC=$(free | awk '/Mem/{printf("%.2f%", ($3/$2)*100)}')
	echo "${bold}Memory Usage:${normal} $MEM_USAGE MB | $MEM_PERC" >> "$LOG_FILE"

	echo "${bold}Disk Usage${normal}: $(df -h / | awk '/\// {print $5}')" >> "$LOG_FILE"
	
	USERS=`who | sort --key=1,1 --unique | wc --lines`
	if [ $USERS -gt $ACCETABLE_USERS_NUMBER ]; then
		USERS_MESSAGE="More than ${ACCETABLE_USERS_NUMBER} users logged in"
	else
		USERS_MESSAGE="Number of logged-in users is normal"
	fi

	HOME_DIRS=`ls /home | wc -l`
	echo "${bold}Users${normal}: $USERS, $USERS_MESSAGE. Curr user: $USER. Home directories: $HOME_DIRS" >> "$LOG_FILE" 
	
	echo "" >> "$LOG_FILE"
	sleep "$SLEEP_SECONDS";
done
