#!/bin/sh
cd "/data/webroot/admin.sanjieke.com"

read diNumber

if [ -n "$diNumber" ]
then
    echo "`git add .`"
    echo "`git commit -a -m '#DI-'$diNumber`"
    echo "`git push origin 'DI-'$diNumber`"
else
    echo "请输入DI号码，格式为纯数字"
fi

