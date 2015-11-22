#!/bin/bash

PID=$(pgrep gnome-session | tail -n 1) 
export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-)

sessionfile=`find "${HOME}/.dbus/session-bus/" -type f | tail -n 1`
echo $sessionFile
export `grep "DBUS_SESSION_BUS_ADDRESS" "$sessionFile" | sed '/^#/d'`	

cd /home/luxcapto/Pictures/Wallpapers
wget -q -o /dev/null -r -A jpg -nd -N -k http://memecdn.net/images/
desktopImage=$(ls -Art | tail -n 1)
imageRoot='file:///home/luxcapto/Pictures/Wallpapers/'
fullURI=$imageRoot$desktopImage
gsettings set org.gnome.desktop.background picture-uri $fullURI 
