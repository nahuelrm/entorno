#! /bin/bash

cpu="$(lscpu | grep "AMD Ryzen 5 3600 6-Core Processor")"
gpu="$(lspci | grep "GeForce RTX 2060 SUPER")"

if [ ! -z "$cpu" ] && [ ! -z "$gpu" ]
then
	/usr/local/sbin/mount-sda2.sh
	/usr/local/sbin/obs-cam.sh
	cp /usr/local/sbin/10-monitor.conf /tmp/10-monitor.conf
	ln -sf /tmp/10-monitor.conf /etc/X11/xorg.conf.d/10-monitor.conf
fi



