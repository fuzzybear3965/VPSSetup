#!/bin/bash
/usr/bin/letsencrypt renew >> /var/log/letsencrypt-renew.log
/bin/systemctl reload nginx
