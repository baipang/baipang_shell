#!/bin/bash
# program
# 每天下午5点钟，同步测试开发机的数据库到本地虚拟机的数据中
#author baipang111@gmail.com

source /home/vagrant/baipang/baipang_shell/.bashrc

`rm /home/vagrant/vagrant.sql 2>/dev/null`
csql
tolocal

