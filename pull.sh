#!/bin/sh
cd "/data/webroot/admin.sanjieke.com"

read diNumber

if [ -n "$diNumber" ]
then
    echo "`git checkout pre`"
    echo "`git pull`"
    echo "`git checkout -b DI-"$diNumber"`"
else
    echo "请输入DI号码，格式为纯数字"
fi
