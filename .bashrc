#!/bin/bash 
# program 
# this program is function to replace the default shell alias
# author baipang111@gmail.com 

#history 
# 2018-10-11 add alias
# history add sea function to gerp file content 
# 2018-10-21 change ps1 color
# 2018-10-24 add global const $pa for map the pay.sanjieke.com path
# 2018-10-29 add global const $sy for map the system config

alias ip="ifconfig eth0 | grep 'inet addr' | sed 's/^.*inet addr://g'"
alias ips="ifconfig eth0 | grep 'inet addr' | sed 's/^.*inet addr://g' | sed 's/Bcast.*//g'"

alias rm="rm -i"

alias c="clear"

# some more ls aliases
alias ll='ls -al | less'
alias la='ls -A'

alias h="history"

# global const
export ad='/data/webroot/admin.sanjieke.com/'
export ww='/data/webroot/www.sanjieke.com/'
export ac='/data/webroot/accounts.sanjieke.com/'
export fr='/data/webroot/Framework/'
export de='/data/webroot/deployment/'
export st='/data/webroot/static.sanjieke.cn/'
export se='/data/webroot/service.sanjieke.com/'
export wi='/data/webroot/wiki.wiki/'
export pa='/data/webroot/pay.sanjieke.com/'
export bl='/data/webroot/blog.sanjieke.com'
export ba='/home/vagrant/baipang/baipang_shell/'
export sy='/data/webroot/system'

function csql(){
    `mysqldump -h 192.168.99.254 -u sanjieke_main -pIFKgD3iVicDXTD3Q sanjieke_main_beta > /home/vagrant/vagrant.sql`
}

function tolocal(){
    `mysql -uroot sanjieke_main_beta < /home/vagrant/vagrant.sql`
}

function displayVersion(){
    version=`git symbolic-ref --short -q HEAD 2>/dev/null`
    #PS1="\e[5;31;37m\$version\e[m[\u@\h \W]$"
    PS1="\e[5;31;37m\$version\[\e[36m\][\[\e[36m\]\u\[\e[0m\]@\h \[\e[32m\]\W\[\e[36m\]]\[\e[0m\]\\$ "
}

function cd(){
    new_directory="$*";
    if [ $# -eq 0 ]; then 
        new_directory=$HOME;
    fi;
    builtin cd "${new_directory}"
    displayVersion
}

function sea()
{
	if [ $# = 2 ]; then
		search_file_path=$1
	else
		search_file_path='./'
	fi
	test $# = 1 && search_content=$1 
	test $# = 2 && search_content=$2
	find $search_file_path -type f | xargs -n 10 grep -i --color=auto "$search_content"
}

function seal()
{
	if [ $# = 2 ]; then
		search_file_path=$1
	else
		search_file_path='./'
	fi
	test $# = 1 && search_content=$1 
	test $# = 2 && search_content=$2
	find $search_file_path -type f | xargs -n 10 grep -li --color=auto "$search_content"
}
