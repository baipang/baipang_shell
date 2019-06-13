#!/bin/sh
# program
# this program is for git to reduce command number,reduce enter DI and number time for sjk develop
#author  baipang111@gmail.com

#history
# change echo `git status` to git status 
# change can run in parents process not in child process,diff can have color

re='^[0-9]+([.][0-9]+)?$'

function getBranchName(){
	if [ $1 = 'dev' ]; then
		branchName='develop'
	elif [ $1 = 'mas' ];then
		branchName=master
	elif [ $1 = 'rel' ];then
		branchName=release
	elif [[ $1 =~ $re ]] ; then
		branchName=DI-$1
	else
		branchName=$1
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

function isBranchExist(){
    git fetch origin # 更新远程跟踪分支，所有本地分支(跟踪分支)都是依赖于远程跟踪分支
	branch=$1
	isBranchExist=$(git branch --remote -v | grep $branch)

	if [ "$isBranchExist" != "" ];then
		return 1
	fi
}

function checkout(){
	branchName=$1
	isLocal=$(isLocalBranch $branchName)
	#isAt=$(isAtBranch $branchName)

    if [ "$isLocal" != 1 ];then # if the branch is not local branch to judge is remote branch
        isRemoteExist=$(isBranchExist $branchName)
    fi

	if [ "$isLocal" == 1 ] ;then
		git checkout $branchName
	elif [ "$isRemoteExist" == 1 ];then
		git checkout -b $branchName origin/$branchName
    else
        git checkout master
	git fetch origin/master
        git merge origin/master
        git checkout -b $branchName
	fi
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
	done
}

version=`git symbolic-ref --short -q HEAD 2>/dev/null`
case "$1" in
    s   )
        git status
	;;
    d  )
	git diff
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
	;;
    diss )
        git checkout -- $2
	;;
    co  ) 
	    branchName=$(getBranchName $2)
	    checkout $branchName
	;;
    cof  ) 
	branchName=$(getBranchName $2)
	git checkout -f $branchName
	;;
    brd  ) 
	branchName=$(getBranchName $2)
	git branch -d $branchName
        ;;
    brD  )
	branchName=$(getBranchName $2)
	git branch -D $branchName
        ;;
    pu   ) 
        git push origin $version
	;;
    pl   ) 
        git pull
	;;
    mg  )
	git pull
	branchName=$(getBranchName $2)
	git merge origin $branchName
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
    bind   )
        git branch --set-upstream-to=origin/$version
	;;
    bindm   )
        git branch --set-upstream-to=origin/$version
	;;
    dr )
        git push origin --delete $2	
	;;
    *    ) 
        shift 0
        git $@
	;;
esac
