#!/bin/bash
sudo yum install httpd php -y
sudo systemctl enable httpd --now
echo 'Welcome to Rathinam Trainers!!<BR> ' > /var/www/html/index.php
echo 'HostName: <?php $name=gethostname(); echo "$name"; ?> <BR> ' >> /var/www/html/index.php
