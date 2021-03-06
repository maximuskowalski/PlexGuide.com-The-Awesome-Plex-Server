#!/bin/bash
#
# [PlexGuide Menu]
#
# GitHub:   https://github.com/Admin9705/PlexGuide.com-The-Awesome-Plex-Server
# Author:   Admin9705 & Deiteq
# URL:      https://plexguide.com
#
# PlexGuide Copyright (C) 2018 PlexGuide.com
# Licensed under GNU General Public License v3.0 GPL-3 (in short)
#
#   You may copy, distribute and modify the software as long as you track
#   changes/dates in source files. Any modifications to our software
#   including (via compiler) GPL-licensed code must also be made available
#   under the GPL along with build & install instructions.
#
#################################################################################
edition=$( cat /var/plexguide/pg.edition ) 1>/dev/null 2>&1
version=$( cat /var/plexguide/pg.version ) 1>/dev/null 2>&1
echo 'INFO - @Settings Menu - Drives Edition' > /var/plexguide/pg.log && bash /opt/plexguide/scripts/log.sh

HEIGHT=14
WIDTH=58
CHOICE_HEIGHT=7
BACKTITLE="Visit https://PlexGuide.com - Automations Made Simple"
TITLE="PG Settings"
MENU="Make Your Selection Choice:"

OPTIONS=(A "Domain/Traefik: Setup/Change Domain & Trefik"
         B "Domain App    : Select Default App for Domain"
         C "Hard Drive 2nd: Use a Second HD for Processing"
         D "Processor     : Enhance Processing Power"
         E "Kernel Mods   : Enhance Network Throughput"
         F "WatchTower    : Auto-Update Application Manager"
         Z "Exit")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
    A)
        bash /opt/plexguide/menus/traefik/main.sh
        echo 'INFO - Selected Domain/Traefik' > /var/plexguide/pg.log && bash /opt/plexguide/scripts/log.sh
        ;;
    B)
        bash /opt/plexguide/menus/tld/main.sh 
        echo 'INFO - Selected Top Level Domain App' > /var/plexguide/pg.log && bash /opt/plexguide/scripts/log.sh
        ;; 
    C)
        #### Solo Drive Edition
        if [ "$edition" == "PG Edition: HD Solo" ]
          then
          dialog --title "-- NOTE --" --msgbox "\nNOT enabled for HD Solo Edition! You only have ONE DRIVE!" 0 0
          echo 'WARNING - Utilizing HD Solo Edition - Cannot Configure Drives' > /var/plexguide/pg.log && bash /opt/plexguide/scripts/log.sh
          bash /opt/plexguide/menus/settings/drives.sh
          exit
        echo 'INFO - Selected 2nd HD' > /var/plexguide/pg.log && bash /opt/plexguide/scripts/log.sh
        fi 
        ;;
    D)
        bash /opt/plexguide/scripts/menus/processor/processor-menu.sh 
        echo "INFO - Selected Processor Power Change" > /var/plexguide/pg.log && bash /opt/plexguide/scripts/log.sh
        ;;
    E)
        echo "INFO - Selected Kernel Modifications" > /var/plexguide/pg.log && bash /opt/plexguide/scripts/log.sh
        bash /opt/plexguide/scripts/menus/kernel-mod-menu.sh 
        ;;
    F)
        echo "INFO - Selected WatchTower Change" > /var/plexguide/pg.log && bash /opt/plexguide/scripts/log.sh
        bash /opt/plexguide/menus/watchtower/main.sh 
        ;;
    Z)
        clear
        echo "INFO - Exited Settings Menu" > /var/plexguide/pg.log && bash /opt/plexguide/scripts/log.sh
        exit 0
        ;;
    esac
clear

bash /opt/plexguide/menus/settings/drives.sh
exit 0
