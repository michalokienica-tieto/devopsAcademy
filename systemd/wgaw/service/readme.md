##### Table of Contents  
1. [System stats service](#system-stats-service)

### System stats service
- sh script: ```/usr/sbin/system-stats.sh```
- service: ```/etc/systemd/system/system-stats.service```
- logs: ```/var/log/system-stats.log```

```bash
sudo systemctl daemon-reload

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