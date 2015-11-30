#!/bin/bash

//The DBUS lines are required for the cron job to run properly.
//If you get errors, check the output of pgrep gnome-session.
//If you get more than one session, then you'll have to use tail or head to make sure the right session is saved to PID and sessionFile.

PID=$(pgrep gnome-session) 
export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-)

sessionfile=`find "${HOME}/.dbus/session-bus/" -type f`
echo $sessionFile
export `grep "DBUS_SESSION_BUS_ADDRESS" "$sessionFile" | sed '/^#/d'`	

//Your user name and/or directory to where you will store your wallpapaers
cd /home/your-username-here/Pictures/Wallpapers

//Pulls down all the memes
wget -q -o /dev/null -r -A jpg -nd -N -k http://memecdn.net/images/

//Picks the freshest and dankest meme
desktopImage=$(ls -Art | tail -n 1)

//Sets desktop for gnome desktops
imageRoot='file:///home/your-username-here/Pictures/Wallpapers/'
fullURI=$imageRoot$desktopImage
gsettings set org.gnome.desktop.background picture-uri $fullURI 
