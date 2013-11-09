#!/bin/bash


# This shell script enables you to perform a ping to remote host 
# and check whether the mentioned port is opened on that server. 
# This helps system admin for ping test and also make sure 
# if there any issues with specific ports.

Parent : http://www.linoxide.com/guide/scripts-pdf.html
Source : http://www.linoxide.com/how-tos/ping-check-open-port/


# check if service name passed to script as argument, if there no arguments (0) do next

if [ "$#" = "0" ];

then

#write to terminal usage

echo �Usage: $0 �

#since no arguments � we need to exit script and user re-run

exit 1
fi

#writing parameters to variables

host=$1
port=$2
email=�test@expertslogin.com�
subject=�Script result�

#Check if ping ok -q to quite mod, -c 4 for 4 checks

if ping -q -c 4 $host >/dev/null
then
# next lines writes result variable

ping_result=�OK�
else
ping_result=�NOT OK�

fi #end of fi loop

#next command check if port opened via nc command, and getting exit status of nc command

nc_result=`nc -z $host $port; echo $?`

#check of exit status of nc command, and write results to variables

if [ $nc_result != 0 ];
then
port_result=�not opened�
else
port_result=�opened�
fi #exit of fi loop

#writing message that script will email and write to output

message=�Ping to host � ${ping_result}, port $port ${port_result}.�

#next check if ping or port check is failed (ping if not OK and exit status of nc if not 0)

if [ "$ping_result" != "OK" -o "$nc_result" != "0" ];
then
echo �$message� #this line write warning message to terminal

echo �$message� | mail -s �$subject� $email #this line send email

fi

