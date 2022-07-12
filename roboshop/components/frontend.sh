#!/bin/bash

# Script will run the below commands sequentially
#if any command fails, script will exit by using 'set -e' option

set -e

source components/common.sh

stat() {
if [ $1 -eq 0 ] ; then
    echo -e "\e[32mSUCCESS\e[0m"
else
    echo -e "\e[31mFAILURE\e[0m"
fi
}

COMPONENT=frontend
LOGFILE=/tmp/$COMPONENT.log

REPO_URL="https://github.com/stans-robot-project/frontend/archive/main.zip"

echo -n "Installing NGNIX:  "
yum install nginx -y &>> $LOGFILE
stat $?
systemctl enable nginx >> $LOGFILE

echo -n "Starting NGNIX:  "
systemctl start nginx
stat $?

echo -n "Downloading and Extracting $COMPONENT:  "
curl -s -L -o /tmp/frontend.zip $REPO_URL &>> $LOGFILE
stat $?

echo -n "Clearing the old content:  "
cd /usr/share/nginx/html
rm -rf *
stat $?

echo -n "Extracting the downloaded $COMPONENT:  "
unzip /tmp/frontend.zip >> $LOGFILE
stat $?

echo -n "Updating the proxy file:   "
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf