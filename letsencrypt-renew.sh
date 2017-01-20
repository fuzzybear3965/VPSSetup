#!/bin/bash
/usr/bin/letsencrypt renew >> /var/log/letsencrypt-renew.log
/usr/sbin/service nginx reload 
