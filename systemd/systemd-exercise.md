# Task Description:
## Create a custom systemd service named system-stats.service that serves the following functionality:

### Every 10 seconds, update the file /var/log/system-stats.log with the following information:

- Date
- Number of users logged in
- Memory usage in %
- If the number of logged-in users is greater than {USERS_NUMBER}, add the information "More than {USERS_NUMBER} users logged in"; otherwise, add "Number of logged-in users is normal".
- If memory usage is greater than {MEM_WARNING_LIMIT}%, add the information "More than {MEM_WARNING_LIMIT}% memory usage is used now"; otherwise, add "Memory usage is normal".
- The values of {USERS_NUMBER} and {MEM_WARNING_LIMIT} should be placed in a service.config file and sourced to the main script file for use.

### Service config should be configured to include:

- Custom description
- Start after other service
- Require active state of another service
- Have an env file and config file
- Have a reload signal configured
- Restart on failure
- Delay between service restarts
- Be "wanted" for another target unit

# Verification:
- The service should be listed on an enabled services list (systemctl list-unit-files --state=enabled).
- The service should be in an active, running state.
- The service should be able to reload config:
    - Users can change service config by editing values {USERS_NUMBER} and {MEM_WARNING_LIMIT} in the service.config file.
    - systemctl reload system-stats.service should work.
- All needed information can be found in /var/log/system-stats.log every 10 seconds.

## Create a custom systemd timer named system-stats.timer that serves the following functionality:
- It will run periodically system-stats.service
- Periods:
- Every 10 seconds, every day at midnight
- timer should be started when the timers.target is reached during system startup
- timer reuquires to system-stats.servic be active and running before timer started
