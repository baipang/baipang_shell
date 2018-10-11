#!/bin/bash 
# program 
# this program is function to replace the default shell alias
# author baipang111@gmail.com 

#history 
# 2018-10-11 add alias


alias rm="rm -i"
alias c="clear"

# some more ls aliases
alias lm='ls -al | less'
alias ll='ls -al'
alias la='ls -A'

function csql(){
    `mysqldump -h 192.168.99.254 -u sanjieke_main -pIFKgD3iVicDXTD3Q sanjieke_main_beta > /home/vagrant/vagrant.sql`
}

function tolocal(){
    `mysql -uroot sanjieke_main_beta < /home/vagrant/vagrant.sql`
}

function displayVersion(){
    version=`git symbolic-ref --short -q HEAD 2>/dev/null`
    PS1="\e[44;37m\$version\e[m[\u@\h \W]$"
}

function cd(){
    new_directory="$*";
    if [ $# -eq 0 ]; then 
        new_directory=$HOME;
    fi;
    builtin cd "${new_directory}"
    displayVersion
}
