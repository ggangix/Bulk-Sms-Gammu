#!/bin/bash
#Developed by: Giuseppe Gangi (@ggangix)

#----BEGIN CONFIG----
number_list=my_list.txt
cut_line=$(wc -l "$number_list" | cut -d" " -f1)
count=1
message="Here my message. "
wait_time=15 #time to wait for send the next message. (in seconds)
#----END CONFIG------ 

# Function to generate a Random String to append in each message and avoid restrictions
randomstring() {
       randomstringLength=3 
       rstring=</dev/urandom tr -dc A-Za-z0-9 | head -c $randomstringLength
       echo $rstring
}

cat "$number_list" | while read NUMBER
do
echo "$NUMBER" > /tmp/sms.tmp
echo "--------------------------------------------------------------------"	
count=$((count+1))
echo "Sending to $NUMBER"
echo "Queue message number: $count"
appendstring=`randomstring`
echo "$message $appendstring" | gammu -c /etc/gammu-smsdrc --sendsms TEXT $NUMBER
for a in `seq 1 $wait_time`; do
    echo -n "$a..." 
    sleep 1;
done
echo ""
echo "--------------------------------------------------------------------"	
done
rm -rf /tmp/sms.tmp
exit 0

