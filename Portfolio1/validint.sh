#!/bin/bash

# Write a script that when run, prompts the user to enter a two digit numeric code_
# _(integer) that is either equal to 20 or equal to 40

code1=20 #assign variables to be tested against
code2=40

while true; do # begin loop
read -p 'Enter a two digit numeric code (integer) that is either equal to 20 or equal to 40: ' inpcode # Request the user for a variable
    if [[ $inpcode -ne "$code1" ]] && [[ $inpcode -ne "$code2" ]]; then #if invalid number given, loop back to prompt
    echo 'That is invalid, try again'
else
    break     #if valid input given, exit the loop
fi
done

echo "Thank you, you have entered $inpcode" #echo the input number to the terminal
exit 0
