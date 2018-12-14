#!/bin/bash

i=1  # 这是累计的数值，亦即是 1, 2, 3....
while [ "$i" != "65" ]
do
    res=$((2**$i))  # 每次都会加总一次！
    echo $i :  $res;
    i=$(($i+1))   # 每次 i 都会添加 1 
done
