#!/bin/sh

vpnlist="$(nmcli -t -f name,type connection show --order name --active 2>/dev/null | grep :vpn)"

for vpn in $vpnlist
do
   vpn="$(echo $vpn | cut -d':' -f1)"
   vpnlabel+="$vpn "
done

if [ -n "$vpnlabel" ]; then
	echo "$vpnlabel"
else
	echo "off"
fi
