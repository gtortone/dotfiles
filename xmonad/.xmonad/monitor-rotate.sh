
#!/bin/bash

IFS=$'\n'
monitor_id=( $(mons  | grep "^[0-9]" | cut -d: -f1) )
monitor_name=( $(mons  | grep "^[0-9]" | awk '{print $2}') )
primary=`mons | grep '*' | cut -d: -f1`

#echo "len is ${#monitor_id[@]}"

index=0
for m in ${monitor_id[@]}
do
   if [ $m -eq $primary ]; then
      #echo "primary is $m - index $index"
      break
   fi
   ((index=index+1))
done

#echo "index is $index"
((max_index=${#monitor_id[@]}-1))

nextmonitor=0
if [ $index -eq $max_index ]; then
   nextmonitor_id=${monitor_id[0]} 
   nextmonitor_name=${monitor_name[0]} 
else
   ((index=index+1))
   nextmonitor_id=${monitor_id[$index]}
   nextmonitor_name=${monitor_name[$index]}
fi

#echo "nextmonitor is $nextmonitor"

/usr/bin/mons --primary $nextmonitor_name
/usr/bin/mons -O $nextmonitor_id
