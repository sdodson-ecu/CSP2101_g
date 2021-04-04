#!/bin/bash

# Write a script that calculates the sum of 3 integers passed to it through the command line
# and display this to the terminal. If however this sum exceeds 30, give the user a warning
# indicating this and then exit the script.

Sumvar=$(($1+$2+$3)) #Declare a variable for the sum of standard variables 1,2 & 3
if [ $Sumvar -le 30 ]; then #Commence an if else operation, if the $Sumvar variable is equal to or less than 30_
    echo "The sum of $1 and $2 and $3 is $Sumvar" #_declare the echoed script
else
    echo " Sum exceeds maximum allowable" #if the $Sumvar variable is greater than 30, declare the echoed script
fi

exit 0