#!/bin/bash

user=YOUR_USER_NAME

//tail -n 1 needed if pgrep gnome-session returns more than one line
//i had multiiple dbus sessions going and session 1 was the right one

PID=$(pgrep gnome-session | tail -n 1) 
export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-)

//same deal as above with the tail -n 1

sessionfile=`find "${HOME}/.dbus/session-bus/" -type f | tail -n 1`
echo $sessionFile
export `grep "DBUS_SESSION_BUS_ADDRESS" "$sessionFile" | sed '/^#/d'`	

//your user name and/or directory to where you will store your wallpapaers

cd /home/$user/Pictures/Wallpapers


//pulls down all the memes
wget -q -o /dev/null -r -A jpg -nd -N -k http://memecdn.net/images/

//picks the freshest and dankest meme

desktopImage=$(ls -Art | tail -n 1)

//sets desktop for gnome desktops
imageRoot='file:///home/$user/Pictures/Wallpapers/'
fullURI=$imageRoot$desktopImage
gsettings set org.gnome.desktop.background picture-uri $fullURI 
