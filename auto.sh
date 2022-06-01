#!/bin/bash



#   Change Network settings
ifconfig -a | egrep "eth|ens" | awk '{ print "SUBSYSTEM==\"net\", ACTION==\"add\", DRIVERS==\"?*\", ATTR{address}==\"" $5 "\", ATTR{dev_id}==\"0x0\", ATTR{type}==\"1\", KERNEL==\"eth*\", NAME=\""$1"\""}' > /etc/udev/rules.d/70-persistent-net.rules

#   Blackmagic firmware status 
echo Showing Black Magic status
BlackmagicFirmwareUpdater status

#   Ask user if he/she wants to update Blackmagic Firmware
while true; do
    read -p "Do you wish to update Blackmagic Firmware y for YES n for NO? " yn
    case $yn in
        [Yy]* ) BlackmagicFirmwareUpdater update 0 && BlackmagicFirmwareUpdater update 1 && BlackmagicFirmwareUpdater update 2 && BlackmagicFirmwareUpdater update 3; break;;
        [Nn]* ) break;;
        * )
    esac
done

#   Screen Flashing section
supervisorctl stop all && php /root/dv_control_new.php number > /etc/digitcode 
cd /root/CFA635_Flasher && ./test.py -c ./config/cfa_635.conf 

#   Re-Flash screen
for i in {3..01}
do
printf '%s\n' "Falashing screen again in $i"
sleep 1
done
./test.py -c ./config/cfa_635.conf




#   Reboot in 5 secs
for i in {5..01}
do
printf '%s\n' "Rebooting in $i"
sleep 1
done
reboot
