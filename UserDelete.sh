#/bin/bash
#author:liuzhei
unset ANSWER
unset count
count=0
while [ -z "$ANSWER" ]
do
echo " Please enter the account you want to delete:"
read -t 30 ANSWER
count=$[ $count + 1 ]
if [ $count -eq 3 ]
then
	echo "time out"
	exit 1
fi
done


finduser () {
if [ -z "$1" ]
then
	echo "Lack of user parameters"
	exit 1
else
	USERS=$(cat /etc/passwd | awk -F : '{print $1}')
	USERS=(${USERS// / })
	for USER in "${USERS[@]}"
	do
		if [ "$USER" == "$1" ]
		then
			return 0
		fi
	done
	echo "${1} dose not exist! "
	exec exit 1
	
fi 
}


insureDeleteAction () {
echo "Are you sure delete ${ANSWER}[y/n]?"
USER=$ANSWER
read -t 30 ANSWER
case "$ANSWER" in
y|Y|Yes|YEs|YES|YeS|yes|yEs|yES|yeS)
;;
*)
exit 1;;
esac
}

killProgressForUser () {
if [ -n "$1" ]
then
	ps -u "$1" | gawk 'NR>1{print $1}' | xargs -d \\n sudo kill -9	

else
	echo 'username of parameters required'
	exit 1
fi

}


deleteFilesForUser(){ 

if [ -n "$1" ]
then
	find /home -user $1 | xargs   rm -rf
else
	echo 'username of parameters required'
	exit 1
fi


}
finduser $ANSWER
insureDeleteAction
echo "begin delete Progress"
killProgressForUser $USER
echo "begin delete files"
deleteFilesForUser $USER
userdel $USER
