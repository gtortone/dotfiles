#!/bin/bash

lidstate=`cat /proc/acpi/button/lid/LID/state | cut -d: -f2`

echo $lidstate

if [[ "$lidstate" == *closed* ]]; then
   /usr/bin/mons -S 7,6:R
else
   /usr/bin/mons -O 0
fi
