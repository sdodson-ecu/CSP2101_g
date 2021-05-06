#!/bin/bash

#Write a script that uses awk exclusively to check all user passwords in a text file to ensure they meet the following password rules:
# Must be at least eight characters in length, must contain at least one number, must contain at least one uppercase letter

read -p "Please input the file to be formatted: " filename  

noheader= awk 'NR>1 {print $2} ' $filename
   awk '{ if (length '"$noheader"' > 8) 
   {
    printf $0 "meets password strength requirements";
   }
   else
   {
       printf $0 "does NOT meet password strength requirements";
   }
   }'
    #if awk 'NR>1 {print $2} ' usrpwords.txt | awk 'length ($0) > 8 '
  #  print $0 "meets password strength requirements";

  #  else
  #  print $0 "does NOT meet password strength requirements";
  #  } ' usrpwords.txt #$filename

print $noheader

    exit 0