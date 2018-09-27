#!/bin/bash

if [ ! -d "sjk_tau" ]
then
    mkdir sjk_tau
fi

cd "sjk_tau"
`rm *`

i=0;

# 构造今天的数据
while [ $i -lt 10 ]
do
    file_name=`date +%Y%m%d-%H-%M-%S`
    make_name="tableau_server-"$file_name".tsbak"
    touch "$make_name"
    i=`expr $i + 1`
done
    
# 构造17年的数据
j=0
while [ $j -lt 10 ]
do
    file_name=`date -d '1 years ago' +%Y%m%d-%H-%M-%S`
    make_name="tableau_server-"$file_name".tsbak"
    touch "$make_name"
    j=`expr $j + 1`
done

# 构造4个月前数据
k=0
while [ $k -lt 10 ]
do
    file_name=`date -d '4 months ago' +%Y%m%d-%H-%M-%S`
    make_name="tableau_server-"$file_name".tsbak"
    touch "$make_name"
    k=`expr $k + 1`
done

# 构造3天内数据
l=0
while [ $l -lt 10 ]
do
    file_name=`date -d '3 days ago' +%Y%m%d-%H-%M-%S`
    make_name="tableau_server-"$file_name".tsbak"
    touch "$make_name"
    l=`expr $l + 1`
done

# 构造三天前数据
m=0
while [ $m -lt 10 ]
do
    file_name=`date -d '5 days ago' +%Y%m%d-%H-%M-%S`
    make_name="tableau_server-"$file_name".tsbak"
    touch "$make_name"

    ## 取三天前00时间
    file_name=`date -d '5 days ago' -d '12 hours ago' +%Y%m%d-%H-%M-%S`
    make_name="tableau_server-"$file_name".tsbak"
    touch "$make_name"


    ## 取三天前12时间
    file_name='20180802-12-00-00'
    make_name="tableau_server-"$file_name".tsbak"
    touch "$make_name"


    ## 取三天前17时间
    file_name='20180802-17-00-00'
    make_name="tableau_server-"$file_name".tsbak"
    touch "$make_name"


    ## 取三天前 13时间
    file_name='20180802-13-00-00'
    make_name="tableau_server-"$file_name".tsbak"
    touch "$make_name"
    m=`expr $m + 1`
done
exit 0

