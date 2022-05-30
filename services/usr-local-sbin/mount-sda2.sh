#! /bin/sh

mount=$"(lsblk -f | grep 9ec567e2-0a06-4db6-86e6-5fcd0be5f3a7 | awk '{print $1}')"

if [ ! -z "$mount" ] 
then
	mount /dev/sda2 /home/stderr/Storage
fi
