1. sh script: /usr/sbin/system-stats.sh
2. service: /etc/systemd/system/system-stats.service
3. logs: /tmp/system-stats.log

```bash
sudo systemctl daemon-reload

# start service
sudo systemctl start system-stats.service

# check the status
systemctl status system-stats.service

# enable service
sudo systemctl enable system-stats.service

# disable service
sudo systemctl disable system-stats.service
```