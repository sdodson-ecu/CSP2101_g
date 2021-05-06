#!/bin/bash

# Write a script that employs a c-style loop to calculate the sum of two assignment scores as they appear ordinarily in separate arrays.

ass1=(12 18 20 10 12 16 15 19 8 11)    # declaring array 1 as ass1
ass2=(22 29 30 20 18 24 25 26 29 30)   # declaring array 2 ass ass2 

for i in "${!ass1[@]}"; do                  #for each entry i in array ass1, do
    result[i]=$(( ass1[i] + ass2[i] ))      #create new array called result, being the sum of ass1 & ass2
done

numres=${#result[*]}     # get the total number of elements in result array

for ((i=0; i<${numres}; i++)); do           #set counter to 1, set end condition to the length of the result array and increment by 1
    echo -e "Student_$(($i+1)) Result:\t${result[$i]}"       #echo the Student number by the increasing counter and echo the result to a neatly tabbed separate column.
done

exit 0