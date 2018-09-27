#!/bin/bash 

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

function ..(){
	`cd ../`
}

function ....(){
	`cd ../../`
}
