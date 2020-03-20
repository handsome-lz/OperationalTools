#!/bin/bash
#author: liuzhe
#统计每个用户的磁盘使用量
MAXDISKUSAGE=3000  #mb
for user in $(cat /etc/passwd | cut -d : -f1,3 | awk -F: '$2 > 99{print $1}')
do
	sum=$(find / -xdev -user "$user" -type f -ls | awk '{ sum += $7 }END{print sum / (1024*1024) "mb"}')
	echo ${user}:${sum}
done
exit 0
