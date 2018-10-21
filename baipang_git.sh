#!/bin/sh
# program
# this program is for git to reduce command number,reduce enter DI and number time for sjk develop
#author  baipang111@gmail.com

#history
# change echo `git status` to git status 
# change can run in parents process not in child process,diff can have color

# 2018-10-21 
# change function projectTo add egrep to validate the project is normal project. isNormalProject
# add function getBranchName and isAtBranch and isLocalBranch and checkout

function getBranchName(){
	if [ $1 = 'pre' ]; then
		branchName='pre'
	elif [ $1 = 'master' ];then
		branchName=master
	else
		branchName=DI-$1
	fi
	echo $branchName
}

function isAtBranch(){
	branchCheckout=$1
	branchAt=$(git symbolic-ref --short -q HEAD 2>/dev/null)
	isAt=$(echo $branchAt | egrep $branchCheckout)

	if [ "$isAt" != "" ];then
		echo 1
	fi	
}

function isLocalBranch(){
	branchCheckout=$1
	isBranchLocal=$(git branch -v | grep $branchCheckout)

	if [ "$isBranchLocal" != "" ];then
		echo 1
	fi	
}

function checkout(){
	branchName=$1
	isLocal=$(isLocalBranch $branchName)
	isAt=$(isAtBranch $branchName)

	if [ "$isLocal" != "" ] && [ "$isAt" = "" ] ;then
		git checkout $branchName
	elif [ "$isLocal" = "" ];then
		git checkout pre
		git pull
		git checkout -b $branchName
	fi
	displayVersion
}

function projectTo(){
	cd ../
	project=$(ls)
	for name in $project
	do
		cd "/data/webroot/$name"
		isNormalProject=$(echo $name | egrep '(([^devutil].*\.sanjieke\.)(com|cn))|(deployment)')
		branchName=$(getBranchName $1)
		if [ "$isNormalProject" != "" ]; then
			echo -e "\033[40;37m $name \033[0m"
			checkout $branchName
		fi
		displayVersion
	done
}

case "$1" in
    i   )
        displayVersion
	;;
    s   )
        git status
        displayVersion
	;;
    d  )
	git diff
        displayVersion
	;;
    capi)
        git add .
        git commit -a -m '#'$version
        git push origin $version
	;;
    cap)
        git add .
        git commit -a -m "$2"
        git push origin $version
	;;
    cia )
        git add .
        git commit -a -m "$2"
	;;
    ss  )
        git status -s
        displayVersion
	;;
    diss )
        git checkout -- $2
	;;
    co  ) 
	branchName=$(getBranchName $2)
	checkout $branchName
	;;
    pco  ) 
	branchName=$(getBranchName $2)
	git pull
	git checkout $branchName
	displayVersion
        ;;
    cof  ) 
	branchName=$(getBranchName $2)
	git checkout -f $branchName
        displayVersion
	;;
    brd  ) 
	branchName=$(getBranchName $2)
	git branch -d $branchName
        ;;
    brD  )
	branchName=$(getBranchName $2)
	git branch -D $branchName
        ;;
    p    )
        git push origin "DI-$2"
	;;
    pp   ) 
        git push origin $version
	;;
    st  ) 
        git stash
	;;
    stl ) 
	git stash list
	;;
    stc ) 
           read -p "Clear the stash content,Are you sure? please input y or n: " delConfirm
           if [ $delConfirm = 'y' ]; then
               git stash clear
           fi
           ;;
    stp  ) 
	git stash apply "stash@{0}"
	;;
    e    )
	 PS1="[\u@\h \W]$"
  	;;
    de   )
         versionNumber=${version#DI-}
         mkdir $versionNumber
         cd $versionNumber
         touch $2
       	;;
    copy )
         versionNumber=${version#DI-}
         mkdir $versionNumber
         cd $versionNumber
         touch 'post'
	 echo "cd /data/webroot/admin.sanjieke.com/src
yes Y | /usr/local/sanjieke/php-5.6/bin/php index.php Temp/copyCourseToAnotherCourse $2 $3" > 'post'
	;;
    copydel )
         versionNumber=${version#DI-}
         mkdir $versionNumber
         cd $versionNumber
         touch 'post'
	 echo "cd /data/webroot/admin.sanjieke.com/src
yes Y | /usr/local/sanjieke/php-5.6/bin/php index.php Temp/copyCourseToAnotherCourse $2 $3 -f del" > 'post'
	;;
    bind   )
        git branch --set-upstream-to=origin/$version
	;;
    bindm   )
        git branch --set-upstream-to=origin/$version
        git pull
        git merge origin/pre
	;;
    dr )
        git push origin --delete DI-"$2"
	;;
    coa )
	projectTo $2
	;;
    *    ) 
        shift 0
        git $@
	;;
esac
