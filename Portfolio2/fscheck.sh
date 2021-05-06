#!/bin/bash

# Write a script that retrieves the following information about a file;
# Its size in kilobytes, the number of words it contains, the date/time it was last modified
# All code involved in retrieving this information is to be included in a function called getprop()

getprop()                                   # declare function called getprop()
{
    if ! [ -f $filename ] ; then            # Check for existence of specified file, if it does not exist, advise the user and exit the script
        echo "No file to process."
        exit 0
    else
        filesize=$(ls -l $filename | awk '{ result= $5/1000; printf"%.2fK\n", result }')        # determine the file size to a maximum of 2 decimal places in kilobytes and save the result as variable filesize
        filecount=$(wc -w $filename | awk '{ printf $1; printf "\n" }')                             # determine the wordcount of the file and save as a variable filecount
        filedate=$(date -r $filename +%d-%m-%Y_%H:%M:%S | sed 's/_/ /g' )                          # determine the date and time the file was modified in dd-mm-yyyy HH:MM:SS and save it as variable filedate
    fi

printf "The file $filename contains $filecount words and is $filesize in size and was last modified $filedate."     # conclude the function by declaring the results in the specified format
printf "\n"
}

read -p "Please input the file to be checked: " filename    # request the user to input a filename       
getprop                                                     # call the getprop() function    

exit 0