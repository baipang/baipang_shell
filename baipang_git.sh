#!/bin/sh
# program
# this program is for git to reduce command number,reduce enter DI and number time for sjk develop
#author  baipang111@gmail.com

#history
# change echo `git status` to git status 
# change can run in parents process not in child process,diff can have color

function projectTo(){
	project=`ls cd ../`;
	first=0;
	for name in $project
	do
		echo $name;
		cd "/data/webroot/$name"
		if [ $1 = "pre" ]; then
		    git checkout -b pre
		else
		    git checkout pre
		    git pull
		    git checkout -b DI-"$1"
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
        if [ $2 = "pre" ]; then
            git checkout pre
            displayVersion
        else
            git checkout DI-"$2"
            displayVersion
        fi
        displayVersion
        ;;
    pco  ) 
        if [ $2 = "pre" ]; then
            git pull
            git checkout pre
            displayVersion
        else
            git pull
            git checkout DI-"$2"
            displayVersion
        fi
        displayVersion
        ;;
    cof  ) 
        if [ $2 = "pre" ]; then
            git checkout -f pre
        else
            git checkout -f DI-"$2"
        fi
        displayVersion
	;;
    cob  ) 
        if [ $2 = "pre" ]; then
            git checkout -b pre
        else
            git checkout pre
            git pull
            git checkout -b DI-"$2"
        fi
        displayVersion
	;;
    brd  ) 
        if [ $2 = "pre" ]; then
            git branch -d pre
        else
            git branch -d DI-"$2"
        fi
        ;;
    brD  )
        if [ $2 = "pre" ]; then
            git branch -D pre
        else
            git branch -D DI-"$"
        fi
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
    stcl ) 
           echo -n "Clear the stash content,Are you sure? "
           read delConfirm
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
    coba )
	projectTo $2
	;;
    *    ) 
        shift 0
        git $@
	;;
esac
