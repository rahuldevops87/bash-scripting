#!/bin/bash

USER_ID=$(id -u)

if [ $USER_ID -ne 0 ] ; then
    echo -e "\e[31mPlease run as a root user \e[0m"
    exit 2
fi

