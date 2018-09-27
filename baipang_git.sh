#!/bin/sh
# program
# this program is for git to reduce command number,reduce enter DI and number time for sjk develop
#author  baipang111@gmail.com
function projectTo(){
	project=`ls cd ../`;
	first=0;
	for name in $project
	do
		echo $name;
		cd "/data/webroot/$name"
		if [ $1 = "pre" ]
		then
		    echo `git checkout -b pre`
		else
		    echo "`git checkout pre`"
		    echo "`git pull`"
		    echo "`git checkout -b DI-"$1"`"
		fi
		displayVersion
	done
}

case "$1" in
    i   )
        displayVersion;;
    s   )
        echo "`git status`"
        displayVersion;;
    d  )
        echo "`git diff`"
        displayVersion;;
    capi)
        echo "`git add .`"
        echo "`git commit -a -m '#'$version`"
        echo "`git push origin $version`";;
    cap)
        echo "`git add .`"
        echo "`git commit -a -m "$2"`"
        echo "`git push origin $version`";;
    cia )
        echo "`git add .`"
        echo "`git commit -a -m "$2"`";;
    ss  )
        echo "`git status -s`"
        displayVersion;;
    diss )
        echo "`git checkout -- $2`";;
    co  ) 
        if [ $2 = "pre" ]
        then
            echo "`git checkout pre`"

            displayVersion
        else
            echo "`git checkout DI-"$2"`"
            displayVersion
        fi
        displayVersion
        ;;
    pco  ) 
        if [ $2 = "pre" ]
        then
            echo "`git pull`"
            echo "`git checkout pre`"
            displayVersion
        else
            echo "`git pull`"
            echo "`git checkout DI-"$2"`"
            displayVersion
        fi
        displayVersion
        ;;
    cof  ) 
        if [ $2 = "pre" ]
        then
            echo "`git checkout -f pre`"
        else
            echo "`git checkout -f DI-"$2"`"
        fi
        displayVersion;;
    cob  ) 
        if [ $2 = "pre" ]
        then
            echo `git checkout -b pre`
        else
            echo "`git checkout pre`"
            echo "`git pull`"
            echo "`git checkout -b DI-"$2"`"
        fi
        displayVersion;;
    brd  ) 
        if [ $2 = "pre" ]
        then
            echo "`git branch -d pre`"
        else
            echo "`git branch -d DI-"$2"`"
        fi
        ;;
    brD  )
        if [ $2 = "pre" ]
        then
            echo "`git branch -D pre`"
        else
            echo "`git branch -D DI-"$2"`"
        fi
        ;;
    p    )
        echo "`git push origin "DI-$2"`";;
    pp   ) 
        echo "`git push origin $version`";;
    st  ) 
        echo "`git stash`";;
    stl ) echo "`git stash list`";;
    stcl ) 
           echo -n "Clear the stash content,Are you sure? "
           read delConfirm
           if [ $delConfirm = 'y' ]
           then
               echo "`git stash clear`"
           fi
           ;;
    stp  ) echo "`git stash apply "stash@{0}"`";;
    e    ) PS1="[\u@\h \W]$";;
    de   )
         versionNumber=${version#DI-}
         mkdir $versionNumber
         cd $versionNumber
         touch $2;;
    copy )
         versionNumber=${version#DI-}
         mkdir $versionNumber
         cd $versionNumber
         touch 'post'
	 echo "cd /data/webroot/admin.sanjieke.com/src
yes Y | /usr/local/sanjieke/php-5.6/bin/php index.php Temp/copyCourseToAnotherCourse $2 $3" > 'post';;

    copydel )
         versionNumber=${version#DI-}
         mkdir $versionNumber
         cd $versionNumber
         touch 'post'
	 echo "cd /data/webroot/admin.sanjieke.com/src
yes Y | /usr/local/sanjieke/php-5.6/bin/php index.php Temp/copyCourseToAnotherCourse $2 $3 -f del" > 'post';;

    bind   )
        echo "`git branch --set-upstream-to=origin/$version`";;
    bindm   )
        echo "`git branch --set-upstream-to=origin/$version`"
        echo "`git pull`"
        echo "`git merge origin/pre`";;
    dr )
        echo "`git push origin --delete DI-"$2"`";;
    coba )
	projectTo $2;;
    *    ) 
        shift 0
        echo "`git $@`";;
esac
