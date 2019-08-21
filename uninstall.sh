#!/bin/sh

IMAGE="Sierra"
USRSBIN='/usr/local/sbin'
LDDIR='/Library/LaunchDaemons'
LADIR='/Library/LaunchAgents'
PROGDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Initiating _Anno graphics file"
if [ -f "/Library/Desktop Pictures/${IMAGE}.jpg" ] ; then
        cp -pR "/Library/Desktop Pictures/${IMAGE}.jpg" "/Library/Desktop Pictures/${IMAGE}_Anno.jpg" 
fi

for i in edu.berkeley.stat.cleanaccount.plist edu.berkeley.stat.updatesharedwifi.plist
    do echo "deleting ${i} to $LDDIR/${i}"
        if [ -f "$LDDIR/${i}" ] ; then
             launchctl unload -w $LDDIR/${i}
             rm $LDDIR/${i}
        fi
done

#if [ ! -f "$LADIR/edu.berkeley.stat.updatesnpbackground.plist" ] ; then
#     launchctl unload -w $LADIR/edu.berkeley.stat.updatesnpbackground.plist
#     rm $LADIR/edu.berkeley.stat.updatesnpbackground.plist
#fi

for i in update-shared-network-pass.sh clean-account.sh
    do echo "deleting ${i} to $USRSBIN/${i}" ;
    if [ -f "$USRSBIN/${i}" ] ; then
         rm $USRSBIN/${i}
    fi
done

if [ -d "/var/log/wifibg" ] ; then
     rm -rf /var/log/wifibg
fi

if [ -f "/Users/${USER}/wifibg.log" ] ; then
    rm -f /Users/${USER}/wifibg.log
fi
