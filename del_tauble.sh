#!/bin/bash

# 切换到维护log目录
cd "$1"

now_year=`date +%Y`
now_month=`date +%m`
now_day=`date +%d`
now_hour=`date +%H`
now_min=`date +%M`
now_sec=`date +%S`


function judge_file_del(){
    # 不是当年的数据全部清空
    if [ $1 != $now_year ]
    then
        echo 1
        exit 0
    fi

    # 不是最近三个月的数据全部清空
    month_ahead_three=`expr $now_month - 3`
    if [ $2 -lt $month_ahead_three ]
    then
        echo 1
        exit 0 
    fi

    # 如果是当天的数据不清空，全部保留
    if [ $3 -eq $now_day ]
    then
        echo 0
        exit 0
    fi

    #day_ahead_three=`expr $now_day - 3`
    # 最近三天的数据全部保留
    #if [ $3 -ge $day_ahead_three ]
    #then
    #    echo 0
    #    exit 0
    #fi

   # 三个月之内的不是当天的，每天的数据只留三份数, 分别是小时为00, 12,17
   if [ $4 -ne 00 -a $4 -ne 12 -a $4 -ne 17 ]
   then
       echo 1
       exit 0
   else
       echo 0
       exit 0
   fi
}


file_name=`ls`;
for one in $file_name
do
    var=${one//-/ }    #这里是将one中的-替换为空格,组装成数组
    arr_key=0
    for i in $var
    do
        arr[$arr_key]=$i
        arr_key=`expr $arr_key + 1`
    done

    ymd=${arr[1]}
    y=`echo ${arr[1]} | cut -c 1,2,3,4`
    m=`echo ${arr[1]} | cut -c 5,6`
    d=`echo ${arr[1]} | cut -c 7,8`
    hr=${arr[2]}
    min=${arr[3]}
    sec=`echo ${arr[4]} | cut -d '.' -f 1,3`;

    is_del="`judge_file_del $y $m $d $hr $min $sec`";
    if [ $is_del -eq 1 ]
    then
        rm $one
    fi
done
