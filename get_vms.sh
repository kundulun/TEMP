#!/bin/bash

if [ -z "$1" ]
  then
    phost=`hostname`
  else
    phost=$1
fi


ids=($(pvesh get /nodes/$phost/qemu|grep -v vmid|awk -F"│" '{ print $3 }'|egrep -v '^\s*#|^$'|sed 's/\s//g'))
echo Name CPU MEM DISKs

for vm in ${ids[@]}; do

 hwn=($(pvesh get /nodes/$phost/qemu/$vm/config|grep 'cores\|name\|memory\|-disk-'|grep -v efidisk|sed 's/│//g'|awk '{print $2}'|sed 's/.*=//g; s/G//g'))
 mem=`expr ${hwn[1]} / 1024`
 tot=0

 for ds in ${hwn[@]:3}; do
   let tot+=$ds
 done
 echo "id: $vm ${hwn[2]},${hwn[0]},$mem,$tot"

done
