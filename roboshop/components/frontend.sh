#!/bin/bash

# Script will run the below commands sequentially
#if any command fails, script will exit by using 'set -e' option

set -e

source components/common.sh

COMPONENT=frontend
LOGFILE=/tmp/$COMPONENT.log

REPO_URL="https://github.com/stans-robot-project/frontend/archive/main.zip"

echo -n "Installing NGNIX:  "
yum install nginx -y &>> $LOGFILE

if [ $? -eq 0 ] ; then
    echo -e "\e[32mSUCCESS\e[0m"
else
    echo -e "\e[31mFAILURE\e[0m"
fi

systemctl enable nginx
systemctl start nginx
curl -s -L -o /tmp/frontend.zip $REPO_URL
cd /usr/share/nginx/html
rm -rf *
unzip /tmp/frontend.zip
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
