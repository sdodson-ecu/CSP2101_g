#!/bin/bash
#Write a script that allows the user to search for specific lines in a server access log
#_according to a pattern they provide and have these lines written to a new file for further use

scount=0 # declare variable for count

while true; do                  #commence while loop for search function
    if [[ $scount -eq 0 ]]; then    #basic use of counter & if else statement to allow for 'search' or 'search again'
        read -p "Enter [1] to Search or [2] to Exit: "
    else
        read -p "Enter [1] to Search Again or [2] to Exit: "
    fi

    if [[ $REPLY -eq 2 ]]; then # if the user selects 2 to exit, exit the while loop
        break
    else

        clear       #clear the terminal for ease of reading
        while : ; do        #enter into infinite loop for case menus to allow for constant searching
            echo -e "1) Whole word match\n2) Any match\n3) Inverted match\n4) Exit" #echo the case menu options to the terminal

            read -p 'Please select your type of search: ' selopt        #define the case variable as 'selopt'

                case $selopt in     #if option $selopt is chosen, then commence the appropriate case - 1), 2), 3) or 4)

                    1)  read -p 'Enter a search term: ' sterm           #request for the search term 'sterm'
                        if ! grep -qiwn "$sterm" access_log.txt; then   #enter into a if else statement, that if no term matching $sterm is located for an case insensitive whole word search,_ 
                        echo "No matches found"                         # _echo that no matches have been found to the terminal - note, the -n isn't required in this instance due to the -q, but has been kept for consistency in the script
                        else
                        numresult=$(grep -iwn "$sterm" access_log.txt | wc -l)  #pipe the result of the whole word search to a line word count, then echo the resulting number of matches to the terminal
                        echo "There are $numresult matches"
                        grep -iwn "$sterm" access_log.txt               #provide the results, including the line number using the -n option and -i option for case insensitive
                        fi                                              #conclude the if else option
                        ;;                                                 #move on to the next case selection
                    2)  read -p 'Enter a search term: ' sterm
                        if ! grep -qin "$sterm" access_log.txt; then        #nearly identical section of script, allowing for the same as option 1, except for any match, not whole word match
                        echo "No matches found"
                        else
                        numresult=$(grep -in "$sterm" access_log.txt | wc -l)
                        echo "There are $numresult matches"
                        grep -in "$sterm" access_log.txt
                        fi
                        ;;
                    3)  read -p "Enter [1] for inverted whole word match or [2] for inverted any match: " selop2        #for user ease of use, creating a sub menu to select what type of inverted search they wish
                        if [[ selop2 -eq 1 ]]; then                                                 #basic if else statement allowing for the above pair of options to function
                            read -p 'Enter a search term: ' sterm                               #following on from previous searches, same script except with the use of the -v operator to invert the results
                            if ! grep -qviwn "$sterm" access_log.txt; then
                            echo "No matches found"
                            else
                            numresult=$(grep -viwn "$sterm" access_log.txt | wc -l)
                            echo "There are $numresult matches"
                            grep -viwn "$sterm" access_log.txt
                            fi
                        else
                            read -p 'Enter a search term: ' sterm
                            if ! grep -qvin "sterm" access_log.txt; then
                            echo "No matches found"
                            else
                            numresult=$(grep -vin "$sterm" access_log.txt | wc -l)
                            echo "There are $numresult matches"
                            grep -vin "$sterm" access_log.txt
                            fi                                                  #conclusion of if else statements for option 3
                        fi                
                        ;; 
                     4) break           #if exit is selected, then break the loop
                                   
                esac        #end of case statement, returns to the initial search or exit menu
       done
    fi
    ((scount++))            #increase counter by 1, to allow for the use of search again
done

    exit 0