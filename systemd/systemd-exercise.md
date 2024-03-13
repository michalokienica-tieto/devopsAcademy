Task Description:
Create a custom system / user systemd service named system-stats.service that will serve below functionality:
- every 10 seconds, file /var/log/system-stats.log will be updated with information:
	-date
	-how many users are logged in 
	-memory usage in %
	-if number of logged in user is greater than {USERS_NUMBER} then also put an   information
	"More than {USERS_NUMBER} users logged in" else "Number of logged in users is normal"
	-if memory usage is greater than {MEM_WARNING_LIMIT} % then also put an information 
	"More than {MEM_WARNING_LIMIT} 50% memory usage is used now" else "Memory usage is normal"
	- value of {USERS_NUMBER} and {MEM_WARNING_LIMIT} should be placed in service.config file and sourced to main script file for use.
- service config should have configured:
	- custom description
	- to be started after other service 
	- require active state of ther service
	- have env file and config file
	- have reload signal configured
	- restart on failure
	- delay between service restart
	- to be "wanted" as other target unit

Verification:
- service can be listed on a enabled services list (systemctl list-unit-files --state=enabled)
- service should in active, running state
- service should be able to reload config:	
	- user can change service config by editing values {USERS_NUMBER} and {MEM_WARNING_LIMIT} in service.config ile
	- systemctl reload system-stats.service should work
- all needed information can be found in /var/log/system-stats.log every 10 seconds
	