#!/bin/bash
#Developed by: Giuseppe Gangi (@ggangix)

#----BEGIN CONFIG----
number_list=my_list.txt #file contain phone numbers
message="Here my message. " #max 155 character
wait_time=15 #time to wait for send the next message. (in seconds)
count=1
#----END CONFIG------ 

cut_line=$(wc -l "$number_list" | cut -d" " -f1)
total=$(wc -l < "$number_list")

#Confirmation before sending a lot SMS 
read -p "Are you sure to send $total SMS from $number_list? " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

# Function to generate a Random String to append in each message and avoid restrictions
randomstring() {
       randomstringLength=3 
       rstring=</dev/urandom tr -dc A-Za-z0-9 | head -c $randomstringLength
       echo $rstring
}

#process
cat "$number_list" | while read NUMBER
do
echo "$NUMBER" > /tmp/sms.tmp
echo "--------------------------------------------------------------------"	
echo "Sending to $NUMBER"
echo "Queue message number: $count of $total"
appendstring=`randomstring`
echo "$message $appendstring" | gammu -c /etc/gammu-smsdrc --sendsms TEXT $NUMBER
for a in `seq 1 $wait_time`; do
    echo -n "$a..." 
    sleep 1;
done
echo ""
echo "--------------------------------------------------------------------"	
count=$((count+1))
done
rm -rf /tmp/sms.tmp
exit 0

