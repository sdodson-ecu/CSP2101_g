#!/bin/bash

# Write a script that counts the number of files and child directories within a specified_
# _directory according to a specified property
cnt=0 cnt2=0 cnt3=0 cnt4=0   #set variables for the counters to be used
read -rp "Please input the directory to be checked: " dirname    # request the user for directory input
for f in $dirname/*   # commence for loop, using all items in $dirname
do
    if [ -f "$f" ]; then   #commence if else statement, identifying if item is a file
    var1=$(du "$f" | cut -f1)   # identify the file size of each file and strip it to the number
        if [[ $var1 -gt 0 ]]; then cnt=$((cnt+1)) #commence additional if else statement, adding to the first counter if the file size is greater than 0
        else
        cnt2=$((cnt2+1)) #otherwise add to the second counter, as the file must have 0 size
        fi #end the second if else statement
    else #if the item isn't a file, it must be a directory
    var2=$(du "$f" | cut -f1) # identify the size of the directory
      if [[ $var2 -gt 0 ]]; then cnt3=$((cnt3+1)) # if the size of the directory is greater than 0, increase count 3
      else
      cnt4=$((cnt4+1)) #otherwise the directory size must be 0, so add to counter 4
      fi #close the third if else statement
    fi   #close the first if else statement
done #end the loop
      echo "The $dirname directory contains:"
      echo "$cnt files that contain data"
      echo "$cnt2 files that are empty"
      echo "$cnt3 non-empty directories"
      echo "$cnt4 empty directories"   #echo the results to the terminal
exit 0