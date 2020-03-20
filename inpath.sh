#!/bin/bash
#author: liuzhe
inpath () {
if [ -n "$1" ] #参数校验，必须传入要查询的命令
then
  # 获取所有PATH
	ALL_PATHS=$(echo "$PATH" | sed 's/:/ /g')
	IFS=' '
	ALL_PATHS=($ALL_PATHS) # 用默认的分隔符转换成数组
	for ONE_PATH in "${ALL_PATHS[@]}"
	do
		if [ -f "$ONE_PATH/$1" ]
		then
			echo "${1} is existent"
			return 0
		else
			continue
		fi
	done
	echo "${1} not is found"
	return 1
else
	echo "need params"
	return 1
fi

}
inpath $1
