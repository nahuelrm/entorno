#! /bin/sh

# Set-up screens

screen1="$(xrandr | grep -w "connected primary" | awk '{print $1}')"
screen2="$(xrandr | grep -w "connected" | grep -v "primary" | awk '{print $1}')"

s1="$(grep = $HOME/.config/polybar/screens.ini | grep -o $screen1)"
s2="$(grep = $HOME/.config/polybar/screens.ini | grep -o $screen2)"

if [ s1 != screen1 ] && [ s2 != screen2 ]
then
    if [ -z "$screen2" ]
    then
	echo \
    	'[screen]
    	screen1="'$screen1'"
    	screen2="/dev/null"
    	' > $HOME/.config/polybar/screens.ini
    else
	echo \
    	'[screen]
    	screen1="'$screen1'"
    	screen2="'$screen2'"
    	' > $HOME/.config/polybar/screens.ini
    fi
fi

# Set-up network interface devices

netdev="$(ip route | grep default | sed -e "s/^.*dev.//" -e "s/.proto.*//")"
if [ ! -z "$netdev" ]
then
	echo \
	'[network]
	interface="'$netdev'"
	' > $HOME/.config/polybar/network.ini
fi



