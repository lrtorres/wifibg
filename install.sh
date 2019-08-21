#!/bin/sh

IMAGE="Sierra"
USRSBIN='/usr/local/sbin'
LDDIR='/Library/LaunchDaemons'
LADIR='/Library/LaunchAgents'
PROGDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ ! -d "/var/log/wifibg" ] ; then
     mkdir /var/log/wifibg
     chmod 755 /var/log/wifibg
fi

for i in update-shared-network-pass.sh clean-account.sh
    do echo "copying ${i} to $USRSBIN/${i}" ;
    if [ ! -f "$USRSBIN/${i}" ] ; then
         cp $PROGDIR/${i} $USRSBIN/${i}
         chmod 755 $USRSBIN/${i}
    fi
done

echo "Initiating _Anno graphics file"
if [ -f "/Library/Desktop Pictures/${IMAGE}.jpg" ] ; then
    if [ ! -f "/Library/Desktop Pictures/${IMAGE}_Anno.jpg" ] ; then
         cp -pR "/Library/Desktop Pictures/${IMAGE}.jpg" "/Library/Desktop Pictures/${IMAGE}_Anno.jpg" 
    fi
fi

for i in edu.berkeley.stat.cleanaccount.plist edu.berkeley.stat.updatesharedwifi.plist
    do echo "copying ${i} to $LDDIR/${i}"
        if [ ! -f "$LDDIR/${i}" ] ; then
             cp $PROGDIR/LaunchDaemons/${i} $LDDIR/${i}
             launchctl load -w $LDDIR/${i}
        fi
done

cp $PROGDIR/etc/pf.anchors/* /etc/pf.anchors/ 

pfctl -d 
pfctl -e -f /etc/pf.conf

osascript -e "tell application \"System Events\" to set picture of every desktop to (\"/Library/Desktop Pictures/${IMAGE}_Anno.jpg\" as POSIX file as alias)"
