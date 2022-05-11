#!/bin/bash
##only ubuntu
echo current hostname =  $(hostname)
echo Enter new host
read hostinput
currenthostname=$(hostname)
newhostname=$hostinput
echo New hostname will be = $hostinput
sed -i "s/$currenthostname/$newhostname/g" /etc/hosts
sed -i "s/$currenthostname/$newhostname/g" /etc/hostname
echo going to reboot ...
sleep 5
reboot
exit 0
