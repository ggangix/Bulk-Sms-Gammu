#!/bin/bash

wait_time=3000
number_list=lista.txt
TAM=$(wc -l "$number_list" | cut -d" " -f1)
CONT=1
cat "$number_list" | while read NUMBER
do
echo "$NUMBER" > /tmp/sms.tmp
/echo "$NUMBER" < /tmp/sms.tmp
 sleep ${wait_time}
done
rm -rf /tmp/sms.tmp
exit 0

