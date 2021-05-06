#!/bin/bash

# Write a script that uses grep, sed and awk in combination to extract specific information from a .html file and echo it to the terminal as a formatted summary
# the script is required to output each attack type and the total number of such attacks

read -p "Please input the file to be formatted: " filename  

pre="<tr><td>"          #declare a number of variables to identify the html tags
post="<\/td><\/tr>"
mid="<\/td><td>"

cat $filename | grep "<td>" | sed -e "s/^$pre//g; s/$post//g; s/$mid/ /g" | awk 'BEGIN {print "ATTACK TYPES    TOTAL ATTACKS"} { sum=($2+$3+$4); printf "%-15s %-10s \n", $1, sum }'        # cat command the file, then pipe this to grep to identify the sections that contain data that we want_
exit 0                                                                                          #_ pipe this data to sed to clear the html tags and leave just the results we want, then pipe that through to awk to format the results, combining the numbers of results into one data point