#!/bin/bash

# 提高操作效率的bash命令




case "$1" in
    lg   )
	ls -la | grep --color $2	
	;;
    ma  )
	go run main.go
	;;
esac
