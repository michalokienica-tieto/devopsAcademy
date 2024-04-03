##### Table of Contents  
1. [System stats service](#system-stats-service)
2. [Timer service](#timer-service)

### System stats service
- sh script: ```/usr/sbin/system-stats.sh```
- service: ```/etc/systemd/system/system-stats.service```
- logs: ```/var/log/system-stats.log```

```bash
sudo systemctl daemon-reload
s
# start service
sudo systemctl start system-stats.service

# check the status
systemctl status system-stats.service

# enable service
sudo systemctl enable system-stats.service

# stop service
sudo systemctl stop system-stats.service

# disable service
sudo systemctl disable system-stats.service
```

## Timer service
- ```/etc/systemd/system/system-stats.timer```

Timers are systemd unit files whose name ends in .timer that control .service files or events. Timers can be used as an alternative to cron (ss a cron replacement). Timers have built-in support for calendar time events, monotonic time events, and can be run asynchronously.


```bash
sudo systemctl daemon-reload
sudo systemctl enable system-stats.timer
sudo systemctl start system-stats.timer
```