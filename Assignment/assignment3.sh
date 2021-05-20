#!/bin/bash

declare -a logs                 #declare an array named logs
patt="serv_acc_log.+$"                 #identify pattern of files to be utilised
mennum=1                                #declare some variables
mennum2=1

savefun()                       #declare function named savefun
{
    read -p "Please enter the name of the directory you would like to save the file to, or . for the current folder:  " pathname            #requests the user input the name of the directory they wish to save the file to
                            if [[ $pathname == . ]]; then                               #if the input directory is ., then save the file to the current directory
                            read -p "Please enter the name of the file: " filename 
                            cat tempres.csv > $filename.txt                         #copy the results of the tempres.csv file to the user chosen filename
                            echo "Your results have been saved to $pathname/$filename.txt"
                            else mkdir -p $pathname
                            read -p "Please enter the name of the file:  "  filename
                            cat tempres.csv > $pathname/$filename.txt
                            echo "Your results have been saved to $pathname/$filename.txt."         #echo to the user the location the file was saved
                            fi
                        exit 0
}

allprotsearch()         #declare function named allprotsearch
{
    for file in ./*; do                 #for all files in the current folder
    if [[ $file =~ $patt ]]; then       #if they match the listed pattern
        logs+=($(basename $file))       #add the basename of the files to array called logs
    fi
done

count=${#logs[*]}                                       #declare to terminal the number of files located
echo -e "The logs array contains $count files.\n"

if test -f "tempfile.csv"; then                     #confirm if the file tempfile.csv exists, if it does, remove it and create an empty one
rm tempfile.csv
fi
touch tempfile.csv

cat ${logs[@]} | grep "suspicious" >> tempfile.csv              # print the contents of the logs array to grep, checking for the tag suspicious and updating the file tempfile.csv with the data

            while : ; do                                        #commence menu loop
            echo -e "1) TCP\n2) UDP\n3) ICMP\n4) GRE\n5) Exit" #echo the case menu options to the terminal

                read -p 'Please select your type of search: ' selopt        #define the case variable as 'selopt'

                    case $selopt in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                        1)  grep "TCP" tempfile.csv | awk ' BEGIN {FS=","} {printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9 }' >tempres.csv         #grep the chosen search term, obtaining the data from the tempfile, editing the layout using AWK & publishing to tempres.csv
                        cat tempres.csv                                                                             #cat the results to the terminal
                        break                                                                                       #break out of the menu loop
                        ;;                                                 #move on to the next case selection
                        2)  grep "UDP" tempfile.csv | awk ' BEGIN {FS=","} {printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9 }' >tempres.csv 
                        cat tempres.csv  
                        break
                        ;;
                        3) grep "ICMP" tempfile.csv | awk ' BEGIN {FS=","} {printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9 }' >tempres.csv 
                        cat tempres.csv 
                        break
                        ;;
                        4) grep "GRE" tempfile.csv | awk ' BEGIN {FS=","} {printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9 }' >tempres.csv 
                        cat tempres.csv 
                        break
                        ;;
                        5) echo "Good Bye"
                        exit 0           #if exit is selected, then exit the script
                        ;;
                        *) echo "That is not a valid choice, please try again"
                                   
                    esac        #end of case statement, returns to the initial search or exit menu
            done            #conclusion of loop

            while : ; do            #commencement of secondary menu
            echo -e "1) Search Again\n2) Save Results and Exit\n3) Search Another File\n4) Exit\n"
                read -p "Please enter your choice:  " selopt
                   
                    case $selopt in             #commence case function of listed selections

                        1) echo -e "You have selected to search again, please note, this will remove your previous search results\n"            #commencement of new search, clearing old results
                       
                       if test -f "tempfile.csv"; then
                        rm tempfile.csv
                        fi
                        touch tempfile.csv

                       cat ${logs[@]} | grep "suspicious" >> tempfile.csv

                         while : ; do                                               #commence further menu within secondary search again menu
                                echo -e "1) TCP\n2) UDP\n3) ICMP\n4) GRE\n5) Exit" #echo the case menu options to the terminal

                                 read -p 'Please select your type of search: ' selopt        #define the case variable as 'selopt'

                                case $selopt in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                                 1)  grep "TCP" tempfile.csv | awk ' BEGIN {FS=","} {printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9 }' >tempres.csv
                                cat tempres.csv     
                                 break                                      
                                ;;                                                 #move on to the next case selection
                                 2)  grep "UDP" tempfile.csv | awk ' BEGIN {FS=","} {printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9 }' >tempres.csv 
                                cat tempres.csv  
                                 break
                                ;;
                                3) grep "ICMP" tempfile.csv | awk ' BEGIN {FS=","} {printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9 }' >tempres.csv 
                                cat tempres.csv 
                                break
                                ;;
                                4) grep "GRE" tempfile.csv | awk ' BEGIN {FS=","} {printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9 }' >tempres.csv 
                                cat tempres.csv 
                                break
                                ;;
                                5) echo "Good Bye"
                                exit 0          #if exit is selected, then exit the script
                                ;;
                                *) echo "That is not a valid choice, please try again"
                                   
                                esac        #end of case statement, returns to the initial search or exit menu
                                done            #conclude the loop - no break at this stage as we want the loop to continue asking to search again
                                
                        ;;
                        2) savefun          #call function savefun
                        ;;
                        3) echo "You have selected to search again, please note, this will add to your previous results"

                                while : ; do        #enter into menu within the menu to search again
                                echo -e "1) TCP\n2) UDP\n3) ICMP\n4) GRE\n5) Exit" #echo the case menu options to the terminal

                                read -p 'Please select your type of search: ' selopt2        #define the case variable as 'selopt'

                                case $selopt2 in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                                    1)  grep "TCP" tempfile.csv | awk ' BEGIN {FS=","} {printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9 }' >>tempres.csv            #same as previous selection, except to update the tempres.csv file, instead of overwrite
                                    cat tempres.csv     
                                    break                                      
                                    ;;                                                 #move on to the next case selection
                                    2)  grep "UDP" tempfile.csv | awk ' BEGIN {FS=","} {printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9 }' >>tempres.csv 
                                    cat tempres.csv  
                                    break
                                    ;;
                                    3) grep "ICMP" tempfile.csv | awk ' BEGIN {FS=","} {printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9 }' >>tempres.csv 
                                    cat tempres.csv 
                                    break
                                    ;;
                                    4) grep "GRE" tempfile.csv | awk ' BEGIN {FS=","} {printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9 }' >>tempres.csv 
                                    cat tempres.csv 
                                    break
                                    ;;
                                    5) echo "Good Bye"
                                    exit 0          #if exit is selected, then exit the script
                                    ;;
                                    *) echo "That is not a valid choice, please try again"
                                   
                                esac        #end of case statement, returns to the initial search or exit menu
                                done
                        ;;
                        4) echo "Good bye"
                        exit 0
                        ;;
                        *) echo "That is not a valid selection, please try again"
                        esac                            #conclude the case statement
            done                                           # end the menu loop
}

searchip()
{
    while true ; do
            echo -e "1) SRC IP\n2) DEST IP\n3) Exit" #echo the case menu options to the terminal

                read -p 'Please select your type of search: ' selopt        #define the case variable as 'selopt'

                    case $selopt in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                        1)  read -p "Please enter a search term (e.g ext):  " usrchoice             #request the user input the search term they would like
                        usrchoice2=${usrchoice^^}                                                   #declare variable of the user input entirely capitalised - to allow for ease of user use
                        grep -i "$usrchoice" tempfile.csv | awk -v CHOICE=$usrchoice2 ' BEGIN {FS=","} {if ($4 ~ CHOICE) {printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9 }}' >tempres.csv      #do a case insensitive grep search of the input against the results, then format them with awk for matching the user input
                        cat tempres.csv         #output the result to the terminal
                        break                                      #exit the menu loop
                        ;;                                                 #move on to the next case selection
                        2)  read -p "Please enter a search term (e.g ext):  " usrchoice     
                        usrchoice2=${usrchoice^^}
                        grep -i "$usrchoice" tempfile.csv | awk -v CHOICE=$usrchoice2 ' BEGIN {FS=","} {if ($6 ~ CHOICE) {printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9 }}' >tempres.csv 
                        cat tempres.csv 
                        break       #exit the menu loop
                        ;;
                        3) echo "Good Bye"
                        exit 0          #if exit is selected, then exit the script
                        ;;
                        *) echo "That is not a valid choice, please try again"
                                   
                    esac        #end of case statement, returns to the initial search or exit menu
            done        #conclude the menu loop  
}

searchip2()
{
    while true ; do
            echo -e "1) SRC IP\n2) DEST IP\n3) Exit" #echo the case menu options to the terminal

                read -p 'Please select your type of search: ' selopt        #define the case variable as 'selopt'

                    case $selopt in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                        1)  read -p "Please enter a search term (e.g ext):  " usrchoice                     #request the user for input to search
                        usrchoice2=${usrchoice^^}                           #declare variable as the user choice in capitals
                        grep -i "$usrchoice" tempfile.csv | awk -v CHOICE=$usrchoice2 ' BEGIN {FS=","} {if ($4 ~ CHOICE) print $0}' >>tempres.csv            #case insensitive grep search 
                        break                                      
                        ;;                                                 #move on to the next case selection
                        2)  read -p "Please enter a search term (e.g ext):  " usrchoice
                        usrchoice2=${usrchoice^^}
                        grep -i "$usrchoice" tempfile.csv | awk -v CHOICE=$usrchoice2 ' BEGIN {FS=","} {if ($6 ~ CHOICE) print $0}' >>tempres.csv
                        break
                        ;;
                        3) echo "Good Bye"
                        exit 0          #if exit is selected, then break the loop
                        ;;
                        *) echo "That is not a valid choice, please try again"
                                   
                    esac        #end of case statement, returns to the initial search or exit menu
            done
}

searchfun()
{
    awk ' BEGIN {FS=","; ttlpackets=0}          
                                {
                                    if ( $8 '"$seloper"' '"$input"' )
                                    {
                                        ttlpackets=ttlpackets+$8
                                        printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9
                                    }
                                }
                                END { print "Total packets for all matching rows is ", ttlpackets }
                                ' tempfile.csv > tempres.csv
                                cat tempres.csv        #awk function for adding the total packets within the logs and formatting the output
}

searchfun2()
{
    awk ' BEGIN {FS=","; ttlbytes=0}
                                {
                                    if ( $9 '"$seloper"' '"$input"' )
                                    {
                                        ttlbytes=ttlbytes+$9
                                        printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9
                                    }
                                }
                                END { print "Total bytes for all matching rows is ", ttlbytes }
                                ' tempfile.csv > tempres.csv
                                cat tempres.csv            #awk function for adding the total packets within the logs and formatting the output
}

searchfun3()
{
    awk ' BEGIN {FS=","; ttlpackets=0}
                                {
                                    if ( $8 '"$seloper"' '"$input"' )
                                    {
                                        ttlpackets=ttlpackets+$8
                                        printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9
                                    }
                                }
                                END { print "Total packets for all matching rows is ", ttlpackets }
                                ' tempfile.csv >> tempres.csv
                                cat tempres.csv                #awk function for adding the total packets within the logs, formatting the ouput and updating the tempres.csv
}

searchfun4()
{
    awk ' BEGIN {FS=","; ttlbytes=0}
                                {
                                    if ( $9 '"$seloper"' '"$input"' )
                                    {
                                        ttlbytes=ttlbytes+$9
                                        printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9
                                    }
                                }
                                END { print "Total bytes for all matching rows is ", ttlbytes }
                                ' tempfile.csv >> tempres.csv
                                cat tempres.csv            #awk function for adding the total packets within the logs, formatting the output and updating the tempres.csv
}

searchfun5()
{
    awk ' BEGIN {FS=","; ttlpackets=0}          
                                {
                                    if ( $8 '"$seloper"' '"$input"' )
                                    {
                                        ttlpackets=ttlpackets+$8
                                        printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9
                                    }
                                }
                                END { print "Total packets for all matching rows is ", ttlpackets }
                                ' tempres.csv > tempres2.csv
                                cat tempres2.csv        #awk function for adding the total packets within the logs and formatting the output
}

searchfun6()
{
    awk ' BEGIN {FS=","; ttlpackets=0}          
                                {
                                    if ( $9 '"$seloper"' '"$input"' )
                                    {
                                        ttlpackets=ttlpackets+$9
                                        printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9
                                    }
                                }
                                END { print "Total packets for all matching rows is ", ttlpackets }
                                ' tempres.csv > tempres2.csv
                                cat tempres2.csv        #awk function for adding the total packets within the logs and formatting the output
}

searchfun7()
{
    awk ' BEGIN {FS=","; ttlpackets=0}          
                                {
                                    if ( $8 '"$seloper"' '"$input"' )
                                    {
                                        ttlpackets=ttlpackets+$8
                                        printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9
                                    }
                                }
                                END { print "Total packets for all matching rows is ", ttlpackets }
                                ' tempres.csv >> tempres2.csv
                                cat tempres2.csv        #awk function for adding the total packets within the logs and formatting the output
}

searchfun8()
{
    awk ' BEGIN {FS=","; ttlpackets=0}          
                                {
                                    if ( $9 '"$seloper"' '"$input"' )
                                    {
                                        ttlpackets=ttlpackets+$9
                                        printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9
                                    }
                                }
                                END { print "Total packets for all matching rows is ", ttlpackets }
                                ' tempres.csv >> tempres2.csv
                                cat tempres2.csv        #awk function for adding the total packets within the logs and formatting the output
}

searchfun9()
{
    awk ' BEGIN {FS=","; ttlpackets=0}
                                {
                                    if ( $8 '"$seloper"' '"$input"' )
                                    {
                                        ttlpackets=ttlpackets+$8
                                        printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9
                                    }
                                }
                                END { print "Total packets for all matching rows is ", ttlpackets }
                                ' tempres2.csv > tempres3.csv
                                cat tempres3.csv

}

searchfun10()
{
    awk ' BEGIN {FS=","; ttlbytes=0}
                                {
                                    if ( $9 '"$seloper"' '"$input"' )
                                    {
                                        ttlbytes=ttlbytes+$9
                                        printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9
                                    }
                                }
                                END { print "Total bytes for all matching rows is ", ttlbytes }
                                ' tempres2.csv > tempres3.csv
                                cat tempres3.csv
}

searchfun11()
{
    awk ' BEGIN {FS=","; ttlpackets=0}
                                {
                                    if ( $8 '"$seloper"' '"$input"' )
                                    {
                                        ttlpackets=ttlpackets+$8
                                        printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9
                                    }
                                }
                                END { print "Total packets for all matching rows is ", ttlpackets }
                                ' tempres2.csv >> tempres3.csv
                                cat tempres3.csv
}

searchfun12()
{
    awk ' BEGIN {FS=","; ttlbytes=0}
                                {
                                    if ( $9 '"$seloper"' '"$input"' )
                                    {
                                        ttlbytes=ttlbytes+$9
                                        printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9
                                    }
                                }
                                END { print "Total bytes for all matching rows is ", ttlbytes }
                                ' tempres2.csv >> tempres3.csv
                                cat tempres3.csv
}

searchpack()
{
    while true ; do
            echo -e "1) Packets\n2) Bytes\n3) Exit" #echo the case menu options to the terminal

                read -p 'Please select if you would like to search for packets, bytes or exit (1, 2 or 3): ' selopt        #define the case variable as 'selopt'

                    case $selopt in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                        1)  while true ; do                     #commence case menu loop for search
                            echo -e "1) Greater than\n2) Less than\n3) Equal to\n4) Not equal to\n5) Exit"
                            read -p "Please select the type of search you would like to perform: " selopt2          #request the user input a selection and declares this as variable selop2

                            case $selopt2 in

                            1) seloper=">"
                            read -p "Please enter the value you would like your result to be greater than (in whole numbers only):  " input     #declares variable as per the chosen option from the user, to be used within awk 'searchfun' functions
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi
                           
                            ;;
                            2) seloper="<"
                            read -p "Please enter the value you would like your result to be less than (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi
                            
                            ;;
                            3) seloper="="
                            read -p "Please enter the value you would like your result to be equal to (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi
                            
                            ;;
                            4) seloper="!="
                            read -p "Please enter the value you would like your result to not equal (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi  
                                                               
                            ;;
                            5) echo "Good Bye"           #if exit is selected, then exit the script
                            exit 0
                            ;;
                            *) echo "That is not a valid choice, please try again"
                            esac            #end the case & break loop
                            done
                            break
                        ;;
                        2) while true ; do
                            echo -e "1) Greater than\n2) Less than\n3) Equal to\n4) Not equal to\n5) Exit"          #the same as previously, except for the bytes
                            read -p "Please select the type of search you would like to perform: " selopt2

                            case $selopt2 in

                            1) seloper=">"
                            read -p "Please enter the value you would like your result to be greater than (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun2
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi
                            
                            ;;
                            2) seloper="<"
                            read -p "Please enter the value you would like your result to be less than (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun2
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi
                            
                            ;;
                            3) seloper="="
                            read -p "Please enter the value you would like your result to be equal to (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun2
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi
                            
                            ;;
                            4) seloper="!="
                            read -p "Please enter the value you would like your result to not equal (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun2
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi  
                                                               
                            ;;
                            5) echo "Good Bye"          #if exit is selected, then break the loop
                            exit 0
                            ;;
                            *) echo "That is not a valid choice, please try again"
                            esac
                            done
                            break
                        ;;
                        3) echo "Good Bye"
                          exit 0
                        ;;
                        *) echo "That is not a valid choice, please try again"
                    esac
    done
}

searchpack3()
{
    while true ; do
            echo -e "1) Packets\n2) Bytes\n3) Exit" #echo the case menu options to the terminal

                read -p 'Please select if you would like to search for packets, bytes or exit (1, 2 or 3): ' selopt        #define the case variable as 'selopt'

                    case $selopt in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                        1)  while true ; do                     #commence case menu loop for search
                            echo -e "1) Greater than\n2) Less than\n3) Equal to\n4) Not equal to\n5) Exit"
                            read -p "Please select the type of search you would like to perform: " selopt2          #request the user input a selection and declares this as variable selop2

                            case $selopt2 in

                            1) seloper=">"
                            read -p "Please enter the value you would like your result to be greater than (in whole numbers only):  " input     #declares variable as per the chosen option from the user, to be used within awk 'searchfun' functions
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun5
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi
                           
                            ;;
                            2) seloper="<"
                            read -p "Please enter the value you would like your result to be less than (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun5
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi
                            
                            ;;
                            3) seloper="="
                            read -p "Please enter the value you would like your result to be equal to (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun5
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi
                            
                            ;;
                            4) seloper="!="
                            read -p "Please enter the value you would like your result to not equal (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun5
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi  
                                                               
                            ;;
                            5) echo "Good Bye"           #if exit is selected, then exit the script
                            exit 0
                            ;;
                            *) echo "That is not a valid choice, please try again"
                            esac            #end the case & break loop
                            done
                            break
                        ;;
                        2) while true ; do
                            echo -e "1) Greater than\n2) Less than\n3) Equal to\n4) Not equal to\n5) Exit"          #the same as previously, except for the bytes
                            read -p "Please select the type of search you would like to perform: " selopt2

                            case $selopt2 in

                            1) seloper=">"
                            read -p "Please enter the value you would like your result to be greater than (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun6
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi
                            
                            ;;
                            2) seloper="<"
                            read -p "Please enter the value you would like your result to be less than (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun6
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi
                            
                            ;;
                            3) seloper="="
                            read -p "Please enter the value you would like your result to be equal to (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun6
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi
                            
                            ;;
                            4) seloper="!="
                            read -p "Please enter the value you would like your result to not equal (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun6
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi  
                                                               
                            ;;
                            5) echo "Good Bye"          #if exit is selected, then break the loop
                            exit 0
                            ;;
                            *) echo "That is not a valid choice, please try again"
                            esac
                            done
                            break
                        ;;
                        3) echo "Good Bye"
                          exit 0
                        ;;
                        *) echo "That is not a valid choice, please try again"
                    esac
    done
}

searchpack2()       #declare function searchpack2, the same as previous except it adds to the tempres3.csv instead of overwriting it
{
    while true ; do
            echo -e "1) Packets\n2) Bytes\n3) Exit" #echo the case menu options to the terminal

                read -p 'Please select if you would like to search for packets, bytes or exit (1, 2 or 3): ' selopt        #define the case variable as 'selopt'

                    case $selopt in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                        1)  while true ; do
                            echo -e "1) Greater than\n2) Less than\n3) Equal to\n4) Not equal to\n5) Exit"
                            read -p "Please select the type of search you would like to perform: " selopt2

                            case $selopt2 in

                            1) seloper=">"
                            read -p "Please enter the value you would like your result to be greater than (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun3
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi
                           
                            ;;
                            2) seloper="<"
                            read -p "Please enter the value you would like your result to be less than (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun3
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi
                            
                            ;;
                            3) seloper="="
                            read -p "Please enter the value you would like your result to be equal to (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun3
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi
                            
                            ;;
                            4) seloper="!="
                            read -p "Please enter the value you would like your result to not equal (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun3
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi  
                                                               
                            ;;
                            5) echo "Good Bye"           #if exit is selected, then break the loop
                            exit 0
                            ;;
                            *) echo "That is not a valid choice, please try again"
                            esac
                            done
                            break
                        ;;
                        2) while true ; do
                            echo -e "1) Greater than\n2) Less than\n3) Equal to\n4) Not equal to\n5) Exit"
                            read -p "Please select the type of search you would like to perform: " selopt2

                            case $selopt2 in

                            1) seloper=">"
                            read -p "Please enter the value you would like your result to be greater than (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun4
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi
                            
                            ;;
                            2) seloper="<"
                            read -p "Please enter the value you would like your result to be less than (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun4
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi
                            
                            ;;
                            3) seloper="="
                            read -p "Please enter the value you would like your result to be equal to (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun4
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi
                            
                            ;;
                            4) seloper="!="
                            read -p "Please enter the value you would like your result to not equal (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun4
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi  
                                                               
                            ;;
                            5) echo "Good Bye"          #if exit is selected, then break the loop
                            exit 0
                            ;;
                            *) echo "That is not a valid choice, please try again"
                            esac
                            done
                            break
                        ;;
                        3) echo "Good Bye"
                          exit 0
                        ;;
                        *) echo "That is not a valid choice, please try again"
                    esac
    done
}

searchpack4()       #declare function searchpack2, the same as previous except it adds to the tempres3.csv instead of overwriting it
{
    while true ; do
            echo -e "1) Packets\n2) Bytes\n3) Exit" #echo the case menu options to the terminal

                read -p 'Please select if you would like to search for packets, bytes or exit (1, 2 or 3): ' selopt        #define the case variable as 'selopt'

                    case $selopt in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                        1)  while true ; do
                            echo -e "1) Greater than\n2) Less than\n3) Equal to\n4) Not equal to\n5) Exit"
                            read -p "Please select the type of search you would like to perform: " selopt2

                            case $selopt2 in

                            1) seloper=">"
                            read -p "Please enter the value you would like your result to be greater than (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun7
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi
                           
                            ;;
                            2) seloper="<"
                            read -p "Please enter the value you would like your result to be less than (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun7
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi
                            
                            ;;
                            3) seloper="="
                            read -p "Please enter the value you would like your result to be equal to (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun7
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi
                            
                            ;;
                            4) seloper="!="
                            read -p "Please enter the value you would like your result to not equal (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun7
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi  
                                                               
                            ;;
                            5) echo "Good Bye"           #if exit is selected, then break the loop
                            exit 0
                            ;;
                            *) echo "That is not a valid choice, please try again"
                            esac
                            done
                            break
                        ;;
                        2) while true ; do
                            echo -e "1) Greater than\n2) Less than\n3) Equal to\n4) Not equal to\n5) Exit"
                            read -p "Please select the type of search you would like to perform: " selopt2

                            case $selopt2 in

                            1) seloper=">"
                            read -p "Please enter the value you would like your result to be greater than (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun8
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi
                            
                            ;;
                            2) seloper="<"
                            read -p "Please enter the value you would like your result to be less than (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun8
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi
                            
                            ;;
                            3) seloper="="
                            read -p "Please enter the value you would like your result to be equal to (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun8
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi
                            
                            ;;
                            4) seloper="!="
                            read -p "Please enter the value you would like your result to not equal (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun8
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi  
                                                               
                            ;;
                            5) echo "Good Bye"          #if exit is selected, then break the loop
                            exit 0
                            ;;
                            *) echo "That is not a valid choice, please try again"
                            esac
                            done
                            break
                        ;;
                        3) echo "Good Bye"
                          exit 0
                        ;;
                        *) echo "That is not a valid choice, please try again"
                    esac
    done
}

searchpack5()           #additional variation of searchpack function, allowing for the use of packet searching in 'all' search functions
{
    while true ; do
            echo -e "1) Packets\n2) Bytes\n3) Exit" #echo the case menu options to the terminal

                read -p 'Please select if you would like to search for packets, bytes or exit (1, 2 or 3): ' selopt        #define the case variable as 'selopt'

                    case $selopt in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                        1)  while true ; do                     #commence case menu loop for search
                            echo -e "1) Greater than\n2) Less than\n3) Equal to\n4) Not equal to\n5) Exit"
                            read -p "Please select the type of search you would like to perform: " selopt2          #request the user input a selection and declares this as variable selop2

                            case $selopt2 in

                            1) seloper=">"
                            read -p "Please enter the value you would like your result to be greater than (in whole numbers only):  " input     #declares variable as per the chosen option from the user, to be used within awk 'searchfun' functions
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun9
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi
                           
                            ;;
                            2) seloper="<"
                            read -p "Please enter the value you would like your result to be less than (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun9
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi
                            
                            ;;
                            3) seloper="="
                            read -p "Please enter the value you would like your result to be equal to (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun9
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi
                            
                            ;;
                            4) seloper="!="
                            read -p "Please enter the value you would like your result to not equal (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun9
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi  
                                                               
                            ;;
                            5) echo "Good Bye"           #if exit is selected, then exit the script
                            exit 0
                            ;;
                            *) echo "That is not a valid choice, please try again"
                            esac            #end the case & break loop
                            done
                            break
                        ;;
                        2) while true ; do
                            echo -e "1) Greater than\n2) Less than\n3) Equal to\n4) Not equal to\n5) Exit"          #the same as previously, except for the bytes
                            read -p "Please select the type of search you would like to perform: " selopt2

                            case $selopt2 in

                            1) seloper=">"
                            read -p "Please enter the value you would like your result to be greater than (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun10
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi
                            
                            ;;
                            2) seloper="<"
                            read -p "Please enter the value you would like your result to be less than (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun10
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi
                            
                            ;;
                            3) seloper="="
                            read -p "Please enter the value you would like your result to be equal to (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun10
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi
                            
                            ;;
                            4) seloper="!="
                            read -p "Please enter the value you would like your result to not equal (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun10
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi  
                                                               
                            ;;
                            5) echo "Good Bye"          #if exit is selected, then break the loop
                            exit 0
                            ;;
                            *) echo "That is not a valid choice, please try again"
                            esac
                            done
                            break
                        ;;
                        3) echo "Good Bye"
                          exit 0
                        ;;
                        *) echo "That is not a valid choice, please try again"
                    esac
    done
}

searchpack6()
{
    while true ; do
            echo -e "1) Packets\n2) Bytes\n3) Exit" #echo the case menu options to the terminal

                read -p 'Please select if you would like to search for packets, bytes or exit (1, 2 or 3): ' selopt        #define the case variable as 'selopt'

                    case $selopt in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                        1)  while true ; do
                            echo -e "1) Greater than\n2) Less than\n3) Equal to\n4) Not equal to\n5) Exit"
                            read -p "Please select the type of search you would like to perform: " selopt2

                            case $selopt2 in

                            1) seloper=">"
                            read -p "Please enter the value you would like your result to be greater than (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun11
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi
                           
                            ;;
                            2) seloper="<"
                            read -p "Please enter the value you would like your result to be less than (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun11
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi
                            
                            ;;
                            3) seloper="="
                            read -p "Please enter the value you would like your result to be equal to (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun11
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi
                            
                            ;;
                            4) seloper="!="
                            read -p "Please enter the value you would like your result to not equal (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun11
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi  
                                                               
                            ;;
                            5) echo "Good Bye"           #if exit is selected, then break the loop
                            exit 0
                            ;;
                            *) echo "That is not a valid choice, please try again"
                            esac
                            done
                            break
                        ;;
                        2) while true ; do
                            echo -e "1) Greater than\n2) Less than\n3) Equal to\n4) Not equal to\n5) Exit"
                            read -p "Please select the type of search you would like to perform: " selopt2

                            case $selopt2 in

                            1) seloper=">"
                            read -p "Please enter the value you would like your result to be greater than (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun12
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi
                            
                            ;;
                            2) seloper="<"
                            read -p "Please enter the value you would like your result to be less than (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun12
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi
                            
                            ;;
                            3) seloper="="
                            read -p "Please enter the value you would like your result to be equal to (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun12
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi
                            
                            ;;
                            4) seloper="!="
                            read -p "Please enter the value you would like your result to not equal (in whole numbers only):  " input
                            if [[ $input =~ ^[0-9]+$ ]]
                            then

                            searchfun12
                            break
                            else
                            echo -e "That is invalid, please try again\n"
                            fi  
                                                               
                            ;;
                            5) echo "Good Bye"          #if exit is selected, then break the loop
                            exit 0
                            ;;
                            *) echo "That is not a valid choice, please try again"
                            esac
                            done
                            break
                        ;;
                        3) echo "Good Bye"
                          exit 0
                        ;;
                        *) echo "That is not a valid choice, please try again"
                    esac
    done
}

allipsearch ()      # declare function named allipsearch
{
    for file in ./*; do                 #for all files in the current folder
    if [[ $file =~ $patt ]]; then       #if they match the listed pattern
        logs+=($(basename $file))       #add the basename of the files to array called logs
    fi
done

count=${#logs[*]}                                       #declare to terminal the number of files located
echo -e "The logs array contains $count files.\n"

if test -f "tempfile.csv"; then                     #confirm if the file tempfile.csv exists, if it does, remove it and create an empty one
rm tempfile.csv
fi
touch tempfile.csv

cat ${logs[@]} | grep "suspicious" >> tempfile.csv              # print the contents of the logs array to grep, checking for the tag suspicious and updating the file tempfile.csv with the data

            searchip         

            while : ; do                        #commence loop for case menu
            echo -e "1) Search Again\n2) Save Results and Exit\n3) Search Another File\n4) Exit\n"
                read -p "Please enter your choice:  " selopt
                   
                    case $selopt in

                        1) echo -e "You have selected to search again, please note, this will remove your previous search results\n"

                        if test -f "tempfile.csv"; then                 #check for, delete and create tempfile.csv
                        rm tempfile.csv
                        fi
                        touch tempfile.csv

                        cat ${logs[@]} | grep "suspicious" >> tempfile.csv          #input the content of logs array into tempfile.csv

                        searchip                    #call function searchip
                                         
                        ;;
                        2)  savefun         #call function searchfun
                        ;;
                        3) echo "You have selected to search again, please note, this will add to your previous results"

                            searchip2               #call function searchip2
                        ;;
                        4) echo "Good bye"
                        exit 0
                        ;;
                        *) echo "That is not a valid selection, please try again"
                        esac                    
            done
}

allpacksearch()
{
for file in ./*; do                 #for all files in the current folder
    if [[ $file =~ $patt ]]; then       #if they match the listed pattern
        logs+=($(basename $file))       #add the basename of the files to array called logs
    fi
done

count=${#logs[*]}                                       #declare to terminal the number of files located
echo -e "The logs array contains $count files.\n"

if test -f "tempfile.csv"; then                     #confirm if the file tempfile.csv exists, if it does, remove it and create an empty one
rm tempfile.csv
fi
touch tempfile.csv

cat ${logs[@]} | grep "suspicious" >> tempfile.csv              # print the contents of the logs array to grep, checking for the tag suspicious and updating the file tempfile.csv with the data

searchpack          #call the searchpack function

while : ; do                #commence loop for case menu
            echo -e "1) Search Again\n2) Save Results and Exit\n3) Search Another File\n4) Exit\n"
                read -p "Please enter your choice:  " selopt
                   
                    case $selopt in

                        1) echo -e "You have selected to search again, please note, this will remove your previous search results\n"

                        if test -f "tempfile.csv"; then             #check for, delete and creat tempfile.csv
                        rm tempfile.csv
                        fi
                        touch tempfile.csv

                        cat ${logs[@]} | grep "suspicious" >> tempfile.csv          #fill tempfile.csv with data from logs array

                        searchpack          #call searchpack function
                                         
                        ;;
                        2)  savefun #call function savefun
                        ;;
                        3) echo "You have selected to search again, please note, this will add to your previous results"

                            searchpack2
                        ;;
                        4) echo "Good bye"
                        exit 0
                        ;;
                        *) echo "That is not a valid selection, please try again"
                        esac                    
            done
}

allprotpacksearch()
{
for file in ./*; do                 #for all files in the current folder
    if [[ $file =~ $patt ]]; then       #if they match the listed pattern
        logs+=($(basename $file))       #add the basename of the files to array called logs
    fi
done

count=${#logs[*]}                                       #declare to terminal the number of files located
echo -e "The logs array contains $count files.\n"

if test -f "tempfile.csv"; then                     #confirm if the file tempfile.csv exists, if it does, remove it and create an empty one
rm tempfile.csv
fi
touch tempfile.csv

cat ${logs[@]} | grep "suspicious" >> tempfile.csv              # print the contents of the logs array to grep, checking for the tag suspicious and updating the file tempfile.csv with the data

            while : ; do
            echo -e "1) TCP\n2) UDP\n3) ICMP\n4) GRE\n5) Exit" #echo the case menu options to the terminal

                read -p 'Please select your type of search: ' selopt        #define the case variable as 'selopt'

                    case $selopt in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                        1)  grep "TCP" tempfile.csv >tempres.csv
                        break                                      
                        ;;                                                 #move on to the next case selection
                        2)  grep "UDP" tempfile.csv >tempres.csv  
                        break
                        ;;
                        3) grep "ICMP" tempfile.csv >tempres.csv 
                        break
                        ;;
                        4) grep "GRE" tempfile.csv >tempres.csv
                        break
                        ;;
                        5) echo "Good Bye"
                        exit 0          #if exit is selected, then break the loop
                        ;;
                        *) echo "That is not a valid choice, please try again"
                                   
                    esac        #end of case statement, returns to the initial search or exit menu
                done
                                
                searchpack3   

            while : ; do
            echo -e "1) Search Again\n2) Save Results and Exit\n3) Search Another File\n4) Exit\n"
                read -p "Please enter your choice:  " selopt
                   
                    case $selopt in

                        1) echo -e "You have selected to search again, please note, this will remove your previous search results\n"

                             if test -f "tempfile.csv"; then             #check for, delete and creat tempfile.csv
                            rm tempfile.csv
                            fi
                            touch tempfile.csv

                            cat ${logs[@]} | grep "suspicious" >> tempfile.csv          #fill tempfile.csv with data from logs array

                            while : ; do
                            echo -e "1) TCP\n2) UDP\n3) ICMP\n4) GRE\n5) Exit" #echo the case menu options to the terminal

                            read -p 'Please select your type of search: ' selopt        #define the case variable as 'selopt'

                            case $selopt in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                                1)  grep "TCP" tempfile.csv >tempres.csv
                                 break                                      
                                ;;                                                 #move on to the next case selection
                                2)  grep "UDP" tempfile.csv >tempres.csv  
                                break
                                ;;
                                3) grep "ICMP" tempfile.csv >tempres.csv 
                                break
                                ;;
                                4) grep "GRE" tempfile.csv >tempres.csv
                                break
                                ;;
                                5) echo "Good Bye"
                                exit 0          #if exit is selected, then break the loop
                                ;;
                                *) echo "That is not a valid choice, please try again"
                                   
                                esac        #end of case statement, returns to the initial search or exit menu
                            done
                
                            searchpack3
                        ;;
                        2)  read -p "Please enter the name of the directory you would like to save the file to, or . for the current folder:  " pathname
                            if [[ $pathname == . ]]; then
                            read -p "Please enter the name of the file: " filename 
                            cat tempres2.csv > $filename.txt
                            echo "Your results have been saved to $pathname/$filename.txt"
                            else mkdir -p $pathname
                            read -p "Please enter the name of the file:  "  filename
                            cat tempres2.csv > $pathname/$filename.txt
                            echo "Your results have been saved to $pathname/$filename.txt."
                            fi
                        exit 0
                        ;;
                        3) echo "You have selected to search again, please note, this will add to your previous results"

                                while : ; do
                                echo -e "1) TCP\n2) UDP\n3) ICMP\n4) GRE\n5) Exit" #echo the case menu options to the terminal

                                read -p 'Please select your type of search: ' selopt2        #define the case variable as 'selopt'

                                case $selopt2 in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                                    1)  grep "TCP" tempfile.csv >tempres.csv   
                                    break                                      
                                    ;;                                                 #move on to the next case selection
                                    2)  grep "UDP" tempfile.csv >tempres.csv 
                                    break
                                    ;;
                                    3) grep "ICMP" tempfile.csv >tempres.csv 
                                    break
                                    ;;
                                    4) grep "GRE" tempfile.csv >tempres.csv 
                                    break
                                    ;;
                                    5) echo "Good Bye"
                                    exit 0          #if exit is selected, then break the loop
                                    ;;
                                    *) echo "That is not a valid choice, please try again"
                                   
                                esac        #end of case statement, returns to the initial search or exit menu
                                done
                                
                                searchpack4                          
                        ;;
                        4) echo "Good bye"
                        exit 0
                        ;;
                        *) echo "That is invalid, please try again"
                        esac                    
            done        #done for packet search loop
                                 # done for protocol search loop
}

searchip3()         #declare function called searchip3
{
    while : ; do
            echo -e "1) SRC IP\n2) DEST IP\n3) Exit" #echo the case menu options to the terminal

                read -p 'Please select your type of search: ' selopt        #define the case variable as 'selopt'

                    case $selopt in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                        1)  read -p "Please enter a search term (e.g ext):  " usrchoice
                        usrchoice2=${usrchoice^^}
                        grep -i "$usrchoice" tempres.csv | awk -v CHOICE=$usrchoice2 ' BEGIN {FS=","} {if ($4 ~ CHOICE) {printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9 }}' >tempres2.csv      #as in previous ip searches, case insensitive saerch and formatted appropriately
                        cat tempres2.csv
                        break                                      
                        ;;                                                 #move on to the next case selection
                        2)  read -p "Please enter a search term (e.g ext):  " usrchoice
                        usrchoice2=${usrchoice^^}
                        grep -i "$usrchoice" tempres.csv | awk -v CHOICE=$usrchoice2 ' BEGIN {FS=","} {if ($6 ~ CHOICE) {printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9 }}' >tempres2.csv 
                        cat tempres2.csv 
                        break
                        ;;
                        3) echo "Good Bye"
                        exit 0          #if exit is selected, then break the loop
                        ;;
                        *) echo "That is not a valid choice, please try again"
                                   
                    esac        #end of case statement, returns to the initial search or exit menu
            done
}

searchip4()
{
    while true ; do
            echo -e "1) SRC IP\n2) DEST IP\n3) Exit" #echo the case menu options to the terminal

                read -p 'Please select your type of search: ' selopt        #define the case variable as 'selopt'

                    case $selopt in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                        1)  read -p "Please enter a search term (e.g ext):  " usrchoice
                        usrchoice2=${usrchoice^^}
                        grep -i "$usrchoice" tempres.csv | awk -v CHOICE=$usrchoice2 ' BEGIN {FS=","} {if ($4 ~ CHOICE) {printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9 }}' >>tempres2.csv 
                        cat tempres2.csv
                        break                                      
                        ;;                                                 #move on to the next case selection
                        2)  read -p "Please enter a search term (e.g ext):  " usrchoice
                        usrchoice2=${usrchoice^^}
                        grep -i "$usrchoice" tempres.csv | awk -v CHOICE=$usrchoice2 ' BEGIN {FS=","} {if ($6 ~ CHOICE) {printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9 }}' >>tempres2.csv 
                        cat tempres2.csv 
                        break
                        ;;
                        3) echo "Good Bye"
                        exit 0          #if exit is selected, then break the loop
                        ;;
                        *) echo "That is not a valid choice, please try again"
                                   
                    esac        #end of case statement, returns to the initial search or exit menu
            done
}

searchip5()
{
    while true ; do
            echo -e "1) SRC IP\n2) DEST IP\n3) Exit" #echo the case menu options to the terminal

                read -p 'Please select your type of search: ' selopt        #define the case variable as 'selopt'

                    case $selopt in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                        1)  read -p "Please enter a search term (e.g ext):  " usrchoice
                        usrchoice2=${usrchoice^^}
                        grep -i "$usrchoice" tempres.csv | awk -v CHOICE=$usrchoice2 ' BEGIN {FS=","} {if ($4 ~ CHOICE) print $0}' >tempres2.csv
                        break                                      
                        ;;                                                 #move on to the next case selection
                        2)  read -p "Please enter a search term (e.g ext):  " usrchoice
                        usrchoice2=${usrchoice^^}
                        grep -i "$usrchoice" tempres.csv | awk -v CHOICE=$usrchoice2 ' BEGIN {FS=","} {if ($6 ~ CHOICE) print $0}' >tempres2.csv
                        break
                        ;;
                        3) echo "Good Bye"
                        exit 0          #if exit is selected, then break the loop
                        ;;
                        *) echo "That is not a valid choice, please try again"
                                   
                    esac        #end of case statement, returns to the initial search or exit menu
            done
}

searchip6()
{
    while true ; do
            echo -e "1) SRC IP\n2) DEST IP\n3) Exit" #echo the case menu options to the terminal

                read -p 'Please select your type of search: ' selopt        #define the case variable as 'selopt'

                    case $selopt in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                        1)  read -p "Please enter a search term (e.g ext):  " usrchoice
                        usrchoice2=${usrchoice^^}
                        grep -i "$usrchoice" tempres.csv | awk -v CHOICE=$usrchoice2 ' BEGIN {FS=","} {if ($4 ~ CHOICE) print $0}' >>tempres2.csv
                        break                                      
                        ;;                                                 #move on to the next case selection
                        2)  read -p "Please enter a search term (e.g ext):  " usrchoice
                        usrchoice2=${usrchoice^^}
                        grep -i "$usrchoice" tempres.csv | awk -v CHOICE=$usrchoice2 ' BEGIN {FS=","} {if ($6 ~ CHOICE) print $0}' >>tempres2.csv
                        break
                        ;;
                        3) echo "Good Bye"
                        exit 0          #if exit is selected, then break the loop
                        ;;
                        *) echo "That is not a valid choice, please try again"
                                   
                    esac        #end of case statement, returns to the initial search or exit menu
            done
}

allprotipsearch()
{

for file in ./*; do                 #for all files in the current folder
    if [[ $file =~ $patt ]]; then       #if they match the listed pattern
        logs+=($(basename $file))       #add the basename of the files to array called logs
    fi
done

count=${#logs[*]}                                       #declare to terminal the number of files located
echo -e "The logs array contains $count files.\n"

if test -f "tempfile.csv"; then                     #confirm if the file tempfile.csv exists, if it does, remove it and create an empty one
rm tempfile.csv
fi
touch tempfile.csv

cat ${logs[@]} | grep "suspicious" >> tempfile.csv              # print the contents of the logs array to grep, checking for the tag suspicious and updating the file tempfile.csv with the data

            while : ; do
            echo -e "1) TCP\n2) UDP\n3) ICMP\n4) GRE\n5) Exit" #echo the case menu options to the terminal

                read -p 'Please select your type of search: ' selopt        #define the case variable as 'selopt'

                    case $selopt in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                        1)  grep "TCP" tempfile.csv >tempres.csv
                        break                                      
                        ;;                                                 #move on to the next case selection
                        2)  grep "UDP" tempfile.csv >tempres.csv  
                        break
                        ;;
                        3) grep "ICMP" tempfile.csv >tempres.csv 
                        break
                        ;;
                        4) grep "GRE" tempfile.csv >tempres.csv
                        break
                        ;;
                        5) echo "Good Bye"
                        exit 0          #if exit is selected, then break the loop
                        ;;
                        *) echo "That is not a valid choice, please try again"
                                   
                    esac        #end of case statement, returns to the initial search or exit menu
                done
                                
                searchip3       #call function searchip3

            while : ; do            #enter into loop for case menu
            echo -e "1) Search Again\n2) Save Results and Exit\n3) Search Another File\n4) Exit\n"
                read -p "Please enter your choice:  " selopt
                   
                    case $selopt in

                        1) echo -e "You have selected to search again, please note, this will remove your previous search results\n"

                        if test -f "tempfile.csv"; then
                        rm tempfile.csv
                        fi
                        touch tempfile.csv

                       cat ${logs[@]} | grep "suspicious" >> tempfile.csv

                            while : ; do
                            echo -e "1) TCP\n2) UDP\n3) ICMP\n4) GRE\n5) Exit" #echo the case menu options to the terminal

                            read -p 'Please select your type of search: ' selopt        #define the case variable as 'selopt'

                            case $selopt in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                                1)  grep "TCP" tempfile.csv >tempres.csv
                                 break                                      
                                ;;                                                 #move on to the next case selection
                                2)  grep "UDP" tempfile.csv >tempres.csv  
                                break
                                ;;
                                3) grep "ICMP" tempfile.csv >tempres.csv 
                                break
                                ;;
                                4) grep "GRE" tempfile.csv >tempres.csv
                                break
                                ;;
                                5) echo "Good Bye"
                                exit 0          #if exit is selected, then break the loop
                                ;;
                                *) echo "That is not a valid choice, please try again"
                                   
                                esac        #end of case statement, returns to the initial search or exit menu
                            done
                
                        searchip3
                        ;;
                        2)  read -p "Please enter the name of the directory you would like to save the file to, or . for the current folder:  " pathname
                            if [[ $pathname == . ]]; then
                            read -p "Please enter the name of the file: " filename 
                            cat tempres2.csv > $filename.txt
                            echo "Your results have been saved to $pathname/$filename.txt"
                            else mkdir -p $pathname
                            read -p "Please enter the name of the file:  "  filename
                            cat tempres2.csv > $pathname/$filename.txt
                            echo "Your results have been saved to $pathname/$filename.txt."
                            fi
                        exit 0
                        ;;
                        3) echo "You have selected to search again, please note, this will add to your previous results"

                                while : ; do
                                echo -e "1) TCP\n2) UDP\n3) ICMP\n4) GRE\n5) Exit" #echo the case menu options to the terminal

                                read -p 'Please select your type of search: ' selopt2        #define the case variable as 'selopt'

                                case $selopt2 in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                                    1)  grep "TCP" tempfile.csv >tempres.csv   
                                    break                                      
                                    ;;                                                 #move on to the next case selection
                                    2)  grep "UDP" tempfile.csv >tempres.csv 
                                    break
                                    ;;
                                    3) grep "ICMP" tempfile.csv >tempres.csv 
                                    break
                                    ;;
                                    4) grep "GRE" tempfile.csv >tempres.csv 
                                    break
                                    ;;
                                    5) echo "Good Bye"
                                    exit 0          #if exit is selected, then break the loop
                                    ;;
                                    *) echo "That is not a valid choice, please try again"
                                   
                                esac        #end of case statement, returns to the initial search or exit menu
                                done
                                
                                searchip4                         
                                ;;
                                4) echo "Good bye"
                                exit 0
                                 ;;
                                *) echo "That is invalid, please try again"
                                esac                    
                                done        #done for packet search loop
                                 # done for protocol search loop
                                                       
}

allippacksearch()
{
for file in ./*; do                 #for all files in the current folder
    if [[ $file =~ $patt ]]; then       #if they match the listed pattern
        logs+=($(basename $file))       #add the basename of the files to array called logs
    fi
done

count=${#logs[*]}                                       #declare to terminal the number of files located
echo -e "The logs array contains $count files.\n"

if test -f "tempfile.csv"; then                     #confirm if the file tempfile.csv exists, if it does, remove it and create an empty one
rm tempfile.csv
fi
touch tempfile.csv

cat ${logs[@]} | grep "suspicious" >> tempfile.csv              # print the contents of the logs array to grep, checking for the tag suspicious and updating the file tempfile.csv with the data

            while : ; do
            echo -e "1) SRC IP\n2) DEST IP\n3) Exit" #echo the case menu options to the terminal

                read -p 'Please select your type of search: ' selopt        #define the case variable as 'selopt'

                    case $selopt in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                        1)  read -p "Please enter a search term (e.g ext):  " usrchoice
                        usrchoice2=${usrchoice^^}
                        grep -i "$usrchoice" tempfile.csv | awk -v CHOICE=$usrchoice2 ' BEGIN {FS=","} {if ($4 ~ CHOICE) print $0}' >tempres.csv 
                        break                                      
                        ;;                                                 #move on to the next case selection
                        2)  read -p "Please enter a search term (e.g ext):  " usrchoice
                        usrchoice2=${usrchoice^^}
                        grep -i "$usrchoice" tempfile.csv | awk -v CHOICE=$usrchoice2 ' BEGIN {FS=","} {if ($6 ~ CHOICE) print $0}' >tempres.csv 
                        break
                        ;;
                        3) echo "Good Bye"
                        exit 0          #if exit is selected, then break the loop
                        ;;
                        *) echo "That is not a valid choice, please try again"
                                   
                    esac        #end of case statement, returns to the initial search or exit menu
            done
                                
                searchpack3         #call searchfile3 function

            while : ; do
            echo -e "1) Search Again\n2) Save Results and Exit\n3) Search Another File\n4) Exit\n"
                read -p "Please enter your choice:  " selopt
                   
                    case $selopt in

                        1) echo -e "You have selected to search again, please note, this will remove your previous search results\n"

                       if test -f "tempfile.csv"; then
                        rm tempfile.csv
                        fi
                        touch tempfile.csv

                       cat ${logs[@]} | grep "suspicious" >> tempfile.csv

                            while : ; do
                             echo -e "1) SRC IP\n2) DEST IP\n3) Exit" #echo the case menu options to the terminal

                            read -p 'Please select your type of search: ' selopt        #define the case variable as 'selopt'

                            case $selopt in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                            1)  read -p "Please enter a search term (e.g ext):  " usrchoice
                            usrchoice2=${usrchoice^^}
                             grep -i "$usrchoice" tempfile.csv | awk -v CHOICE=$usrchoice2 ' BEGIN {FS=","} {if ($4 ~ CHOICE) print $0}' >tempres.csv 
                             break                                      
                            ;;                                                 #move on to the next case selection
                            2)  read -p "Please enter a search term (e.g ext):  " usrchoice
                            usrchoice2=${usrchoice^^}
                            grep -i "$usrchoice" tempfile.csv | awk -v CHOICE=$usrchoice2 ' BEGIN {FS=","} {if ($6 ~ CHOICE) print $0}' >tempres.csv 
                            break
                            ;;
                            3) echo "Good Bye"
                            exit 0          #if exit is selected, then break the loop
                            ;;
                            *) echo "That is not a valid choice, please try again"
                                   
                            esac        #end of case statement, returns to the initial search or exit menu
                done
                
                    searchpack3
                        ;;
                        2)  read -p "Please enter the name of the directory you would like to save the file to, or . for the current folder:  " pathname
                            if [[ $pathname == . ]]; then
                            read -p "Please enter the name of the file: " filename 
                            cat tempres2.csv > $filename.txt
                            echo "Your results have been saved to $pathname/$filename.txt"
                            else mkdir -p $pathname
                            read -p "Please enter the name of the file:  "  filename
                            cat tempres2.csv > $pathname/$filename.txt
                            echo "Your results have been saved to $pathname/$filename.txt."
                            fi
                        exit 0
                        ;;
                        3) echo "You have selected to search again, please note, this will add to your previous results"

                                while : ; do

                                echo -e "1) SRC IP\n2) DEST IP\n3) Exit" #echo the case menu options to the terminal

                                read -p 'Please select your type of search: ' selopt        #define the case variable as 'selopt'

                                 case $selopt in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                                 1)  read -p "Please enter a search term (e.g ext):  " usrchoice
                                usrchoice2=${usrchoice^^}
                                grep -i "$usrchoice" tempfile.csv | awk -v CHOICE=$usrchoice2 ' BEGIN {FS=","} {if ($4 ~ CHOICE) print $0}' >tempres.csv 
                                break                                      
                                ;;                                                 #move on to the next case selection
                                2)  read -p "Please enter a search term (e.g ext):  " usrchoice
                                usrchoice2=${usrchoice^^}
                                grep -i "$usrchoice" tempfile.csv | awk -v CHOICE=$usrchoice2 ' BEGIN {FS=","} {if ($6 ~ CHOICE) print $0}' >tempres.csv 
                                break
                                ;;
                                3) echo "Good Bye"
                                exit 0          #if exit is selected, then break the loop
                                ;;
                                *) echo "That is not a valid choice, please try again"
                                   
                                esac        #end of case statement, returns to the initial search or exit menu
                                done
                                
                                searchpack4                          
                        ;;
                        4) echo "Good bye"
                        exit 0
                        ;;
                        *) echo "That is invalid, please try again"
                        esac                    
                        done        #done for packet search loop
                                 # done for protocol search loop
}

allsearch()
{
 for file in ./*; do                 #for all files in the current folder
    if [[ $file =~ $patt ]]; then       #if they match the listed pattern
        logs+=($(basename $file))       #add the basename of the files to array called logs
    fi
done

count=${#logs[*]}                                       #declare to terminal the number of files located
echo -e "The logs array contains $count files.\n"

if test -f "tempfile.csv"; then                     #confirm if the file tempfile.csv exists, if it does, remove it and create an empty one
rm tempfile.csv
fi
touch tempfile.csv

cat ${logs[@]} | grep "suspicious" >> tempfile.csv              # print the contents of the logs array to grep, checking for the tag suspicious and updating the file tempfile.csv with the data

            while : ; do
            echo -e "1) TCP\n2) UDP\n3) ICMP\n4) GRE\n5) Exit" #echo the case menu options to the terminal

                read -p 'Please select your type of search: ' selopt        #define the case variable as 'selopt'

                    case $selopt in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                        1)  grep "TCP" tempfile.csv >tempres.csv
                        break                                      
                        ;;                                                 #move on to the next case selection
                        2)  grep "UDP" tempfile.csv >tempres.csv  
                        break
                        ;;
                        3) grep "ICMP" tempfile.csv >tempres.csv 
                        break
                        ;;
                        4) grep "GRE" tempfile.csv >tempres.csv
                        break
                        ;;
                        5) echo "Good Bye"
                        exit 0          #if exit is selected, then break the loop
                        ;;
                        *) echo "That is not a valid choice, please try again"
                                   
                    esac        #end of case statement, returns to the initial search or exit menu
                done
                                
                searchip5
                searchpack5

            while : ; do
            echo -e "1) Search Again\n2) Save Results and Exit\n3) Search Another File\n4) Exit\n"
                read -p "Please enter your choice:  " selopt
                   
                    case $selopt in

                        1) echo -e "You have selected to search again, please note, this will remove your previous search results\n"

                            if test -f "tempfile.csv"; then
                            rm tempfile.csv
                            fi
                            touch tempfile.csv

                             cat ${logs[@]} | grep "suspicious" >> tempfile.csv

                            while : ; do
                            echo -e "1) TCP\n2) UDP\n3) ICMP\n4) GRE\n5) Exit" #echo the case menu options to the terminal

                            read -p 'Please select your type of search: ' selopt        #define the case variable as 'selopt'

                            case $selopt in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                                1)  grep "TCP" tempfile.csv >tempres.csv
                                 break                                      
                                ;;                                                 #move on to the next case selection
                                2)  grep "UDP" tempfile.csv >tempres.csv  
                                break
                                ;;
                                3) grep "ICMP" tempfile.csv >tempres.csv 
                                break
                                ;;
                                4) grep "GRE" tempfile.csv >tempres.csv
                                break
                                ;;
                                5) echo "Good Bye"
                                exit 0          #if exit is selected, then break the loop
                                ;;
                                *) echo "That is not a valid choice, please try again"
                                   
                                esac        #end of case statement, returns to the initial search or exit menu
                            done
                
                        searchip5
                        searchpack5
                        ;;
                        2)  read -p "Please enter the name of the directory you would like to save the file to, or . for the current folder:  " pathname
                            if [[ $pathname == . ]]; then
                            read -p "Please enter the name of the file: " filename 
                            cat tempres3.csv > $filename.txt
                            echo "Your results have been saved to $pathname/$filename.txt"
                            else mkdir -p $pathname
                            read -p "Please enter the name of the file:  "  filename
                            cat tempres3.csv > $pathname/$filename.txt
                            echo "Your results have been saved to $pathname/$filename.txt."
                            fi
                        exit 0
                        ;;
                        3) echo "You have selected to search again, please note, this will add to your previous results"

                                while : ; do
                                echo -e "1) TCP\n2) UDP\n3) ICMP\n4) GRE\n5) Exit" #echo the case menu options to the terminal

                                read -p 'Please select your type of search: ' selopt2        #define the case variable as 'selopt'

                                case $selopt2 in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                                    1)  grep "TCP" tempfile.csv >tempres.csv   
                                    break                                      
                                    ;;                                                 #move on to the next case selection
                                    2)  grep "UDP" tempfile.csv >tempres.csv 
                                    break
                                    ;;
                                    3) grep "ICMP" tempfile.csv >tempres.csv 
                                    break
                                    ;;
                                    4) grep "GRE" tempfile.csv >tempres.csv 
                                    break
                                    ;;
                                    5) echo "Good Bye"
                                    exit 0          #if exit is selected, then break the loop
                                    ;;
                                    *) echo "That is not a valid choice, please try again"
                                   
                                esac        #end of case statement, returns to the initial search or exit menu
                                done
                                
                                searchip6
                                searchpack6                       
                                ;;
                                4) echo "Good bye"
                                 exit 0
                                ;;
                                *) echo "That is invalid, please try again"
                                esac                    
                                done        #done for packet search loop
                                 # done for protocol search loop
}

fileprotsearch()
{
    for file in ./*; do
    if [[ $file =~ $patt ]]; then
        logs+=($(basename $file))
    fi
done

count=${#logs[*]}
echo -e "The logs array contains $count files.\n"

while true : ; do
for file in "${logs[@]}"; do                #generate menu numbers based off of the number of elements in the array
   echo "$mennum  $file"
  ((mennum++))
done
mennum=1
   
    echo -e  "\t"
    read -p "Enter the number of the file in the menu above that you wish to search, i.e 1,2,3 etc  " sel           #as array is 0 based, correct chosen value will be the listed number -1
    echo "You have entered $sel"
    let seltrue=$sel-1
    choice="${logs[$seltrue]}"

    if ! grep -qe "$seltrue" <(echo "${!logs[@]}"); then
        printf 'That is an invalid selection, please try again\n'
    else
        
        grep "suspicious" < $choice > tempfile.csv

            while true ; do
            echo -e "1) TCP\n2) UDP\n3) ICMP\n4) GRE\n5) Exit" #echo the case menu options to the terminal

                read -p 'Please select your type of search: ' selopt        #define the case variable as 'selopt'

                    case $selopt in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                        1)  grep "TCP" tempfile.csv | awk ' BEGIN {FS=","} {printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9 }' >tempres.csv
                        cat tempres.csv     
                        break                                      
                        ;;                                                 #move on to the next case selection
                        2)  grep "UDP" tempfile.csv | awk ' BEGIN {FS=","} {printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9 }' >tempres.csv 
                        cat tempres.csv  
                        break
                        ;;
                        3) grep "ICMP" tempfile.csv | awk ' BEGIN {FS=","} {printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9 }' >tempres.csv 
                        cat tempres.csv 
                        break
                        ;;
                        4) grep "GRE" tempfile.csv | awk ' BEGIN {FS=","} {printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9 }' >tempres.csv 
                        cat tempres.csv 
                        break
                        ;;
                        5) echo "Good Bye"
                        exit 0           #if exit is selected, then break the loop
                        ;;
                        *) echo "That is not a valid choice, please try again"
                                   
                    esac        #end of case statement, returns to the initial search or exit menu
            done
            break
            fi
            done

            while true ; do
            echo -e "1) Search Again\n2) Save Results and Exit\n3) Search Another File\n4) Exit\n"
                read -p "Please enter your choice:  " selopt
                   
                    case $selopt in

                        1) echo -e "You have selected to search again, please note, this will remove your previous search results\n"
                       
                       while true : ; do
                        for file in "${logs[@]}"; do
                         echo "$mennum  $file"
                        ((mennum++))
                        done
                        mennum=1
   
                         echo -e  "\t"
                          read -p "Enter the number of the file in the menu above that you wish to search, i.e 1,2,3 etc  " sel
                         echo "You have entered $sel"
                          let seltrue=$sel-1
                          choice="${logs[$seltrue]}"

                        if ! grep -qe "$seltrue" <(echo "${!logs[@]}"); then
                        printf 'That is an invalid selection, please try again\n'
                        else
        
                         grep "suspicious" < $choice > tempfile.csv

                         while true ; do
                                echo -e "1) TCP\n2) UDP\n3) ICMP\n4) GRE\n5) Exit" #echo the case menu options to the terminal

                                 read -p 'Please select your type of search: ' selopt        #define the case variable as 'selopt'

                                case $selopt in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                                 1)  grep "TCP" tempfile.csv | awk ' BEGIN {FS=","} {printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9 }' >tempres.csv
                                cat tempres.csv     
                                 break                                      
                                ;;                                                 #move on to the next case selection
                                 2)  grep "UDP" tempfile.csv | awk ' BEGIN {FS=","} {printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9 }' >tempres.csv 
                                cat tempres.csv  
                                 break
                                ;;
                                3) grep "ICMP" tempfile.csv | awk ' BEGIN {FS=","} {printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9 }' >tempres.csv 
                                cat tempres.csv 
                                break
                                ;;
                                4) grep "GRE" tempfile.csv | awk ' BEGIN {FS=","} {printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9 }' >tempres.csv 
                                cat tempres.csv 
                                break
                                ;;
                                5) echo "Good Bye"
                                exit 0          #if exit is selected, then break the loop
                                ;;
                                *) echo "That is not a valid choice, please try again"
                                   
                                esac        #end of case statement, returns to the initial search or exit menu
                                done
                                break
                        fi
                        done
                        ;;
                        2)  savefun
                        ;;
                        3) echo "You have selected to search again, please note, this will add to your previous results"

                            while true ; do
                            for file in "${logs[@]}"; do
                            echo "$mennum2  $file"
                            ((mennum2++))
                            done
                                
                            mennum2=1
                                
                            echo -e  "\t"
                            read -p "Enter the number of the file in the menu above that you wish to search, i.e 1,2,3 etc  " sel
                            echo -e "You have entered $sel\n"
                            let seltrue=$sel-1
                            choice="${logs[$seltrue]}"

                            if ! grep -qe "$seltrue" <(echo "${!logs[@]}"); then
                                printf 'That is an invalid selection, please try again\n'
                                else
                                
                                grep "suspicious" < $choice > tempfile.csv

                                while true ; do
                                echo -e "1) TCP\n2) UDP\n3) ICMP\n4) GRE\n5) Exit" #echo the case menu options to the terminal

                                read -p 'Please select your type of search: ' selopt2        #define the case variable as 'selopt'

                                case $selopt2 in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                                    1)  grep "TCP" tempfile.csv | awk ' BEGIN {FS=","} {printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9 }' >>tempres.csv
                                    cat tempres.csv     
                                    break                                      
                                    ;;                                                 #move on to the next case selection
                                    2)  grep "UDP" tempfile.csv | awk ' BEGIN {FS=","} {printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9 }' >>tempres.csv 
                                    cat tempres.csv  
                                    break
                                    ;;
                                    3) grep "ICMP" tempfile.csv | awk ' BEGIN {FS=","} {printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9 }' >>tempres.csv 
                                    cat tempres.csv 
                                    break
                                    ;;
                                    4) grep "GRE" tempfile.csv | awk ' BEGIN {FS=","} {printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9 }' >>tempres.csv 
                                    cat tempres.csv 
                                    break
                                    ;;
                                    5) echo "Good Bye"
                                    exit 0          #if exit is selected, then break the loop
                                    ;;
                                    *) echo "That is not a valid choice, please try again"
                                   
                                esac        #end of case statement, returns to the initial search or exit menu
                                done
                                break
                                fi
                                done
                        ;;
                        4) echo "Good bye"
                        exit 0
                        ;;
                        *) echo "That is not a valid selection, please try again"
                        esac                    
            done
}

fileipsearch()
{
    for file in ./*; do
    if [[ $file =~ $patt ]]; then
        logs+=($(basename $file))
    fi
done

count=${#logs[*]}
echo -e "The logs array contains $count files.\n"

while true : ; do
for file in "${logs[@]}"; do
   echo "$mennum  $file"
  ((mennum++))
done
mennum=1
   
    echo -e  "\t"
    read -p "Enter the number of the file in the menu above that you wish to search, i.e 1,2,3 etc  " sel
    echo "You have entered $sel"
    let seltrue=$sel-1
    choice="${logs[$seltrue]}"

    if ! grep -qe "$seltrue" <(echo "${!logs[@]}"); then
        printf 'That is an invalid selection, please try again\n'
    else
        
        grep "suspicious" < $choice > tempfile.csv

            while true ; do
            echo -e "1) SRC IP\n2) DEST IP\n3) Exit" #echo the case menu options to the terminal

                read -p 'Please select your type of search: ' selopt        #define the case variable as 'selopt'

                    case $selopt in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                        1)  read -p "Please enter a search term (e.g ext):  " usrchoice
                        usrchoice2=${usrchoice^^}
                        grep -i "$usrchoice" tempfile.csv | awk -v CHOICE=$usrchoice2 ' BEGIN {FS=","} {if ($4 ~ CHOICE) {printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9 }}' >tempres.csv 
                        cat tempres.csv
                        break                                      
                        ;;                                                 #move on to the next case selection
                        2)  read -p "Please enter a search term (e.g ext):  " usrchoice
                        usrchoice2=${usrchoice^^}
                        grep -i "$usrchoice" tempfile.csv | awk -v CHOICE=$usrchoice2 ' BEGIN {FS=","} {if ($6 ~ CHOICE) {printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9 }}' >tempres.csv 
                        cat tempres.csv 
                        break
                        ;;
                        3) echo "Good Bye"
                        exit 0          #if exit is selected, then break the loop
                        ;;
                        *) echo "That is not a valid choice, please try again"
                                   
                    esac        #end of case statement, returns to the initial search or exit menu
            done
            break
            fi
            done

            while true ; do
            echo -e "1) Search Again\n2) Save Results and Exit\n3) Search Another File\n4) Exit\n"
                read -p "Please enter your choice:  " selopt
                   
                    case $selopt in

                        1) echo -e "You have selected to search again, please note, this will remove your previous search results\n"
                        while true : ; do
                                for file in "${logs[@]}"; do
                                echo "$mennum  $file"
                                 ((mennum++))
                                done
                                mennum=1
   
                                 echo -e  "\t"
                                 read -p "Enter the number of the file in the menu above that you wish to search, i.e 1,2,3 etc  " sel
                                echo "You have entered $sel"
                                 let seltrue=$sel-1
                                 choice="${logs[$seltrue]}"

                                  if ! grep -qe "$seltrue" <(echo "${!logs[@]}"); then
                                   printf 'That is an invalid selection, please try again\n'
                                  else
        
                                 grep "suspicious" < $choice > tempfile.csv

                                 while true ; do
                                echo -e "1) SRC IP\n2) DEST IP\n3) Exit" #echo the case menu options to the terminal

                                   read -p 'Please select your type of search: ' selopt        #define the case variable as 'selopt'

                                  case $selopt in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                                          1)  read -p "Please enter a search term (e.g ext):  " usrchoice
                                          usrchoice2=${usrchoice^^}
                                           grep -i "$usrchoice" tempfile.csv | awk -v CHOICE=$usrchoice2 ' BEGIN {FS=","} {if ($4 ~ CHOICE) {printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9 }}' >tempres.csv 
                                             cat tempres.csv
                                          break                                      
                                            ;;                                                 #move on to the next case selection
                                          2)  read -p "Please enter a search term (e.g ext):  " usrchoice
                                         usrchoice2=${usrchoice^^}
                                           grep -i "$usrchoice" tempfile.csv | awk -v CHOICE=$usrchoice2 ' BEGIN {FS=","} {if ($6 ~ CHOICE) {printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9 }}' >tempres.csv 
                                         cat tempres.csv 
                                         break
                                          ;;
                                         3) echo "Good Bye"
                                         exit 0          #if exit is selected, then break the loop
                                        ;;
                                         *) echo "That is not a valid choice, please try again"
                                   
                                          esac        #end of case statement, returns to the initial search or exit menu
                                            done
                                         break
                                          fi
                                        done
                        ;;
                        2)  savefun
                        ;;
                        3) echo "You have selected to search again, please note, this will add to your previous results"

                            while true ; do
                            for file in "${logs[@]}"; do
                            echo "$mennum2  $file"
                            ((mennum2++))
                            done
                            
                            mennum2=1

                            echo -e  "\t"
                            read -p "Enter the number of the file in the menu above that you wish to search, i.e 1,2,3 etc  " sel
                            echo -e "You have entered $sel\n"
                            let seltrue=$sel-1
                            choice="${logs[$seltrue]}"

                            if ! grep -qe "$seltrue" <(echo "${!logs[@]}"); then
                                printf 'That is an invalid selection, please try again\n'
                                else
                                
                                grep "suspicious" < $choice > tempfile.csv

                                while true ; do
                                    echo -e "1) SRC IP\n2) DEST IP\n3) Exit" #echo the case menu options to the terminal

                                    read -p 'Please select your type of search: ' selopt        #define the case variable as 'selopt'

                                    case $selopt in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                                    1)  read -p "Please enter a search term (e.g ext):  " usrchoice
                                        usrchoice2=${usrchoice^^}
                                        grep -i "$usrchoice" tempfile.csv | awk -v CHOICE=$usrchoice2 ' BEGIN {FS=","} {if ($4 ~ CHOICE) {printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9 }}' >>tempres.csv 
                                        cat tempres.csv
                                        break                                   
                                    ;;                                                 #move on to the next case selection
                                    2)  read -p "Please enter a search term (e.g ext):  " usrchoice
                                        usrchoice2=${usrchoice^^}
                                        grep -i "$usrchoice" tempfile.csv | awk -v CHOICE=$usrchoice2 ' BEGIN {FS=","} {if ($6 ~ CHOICE) {printf "%-6s %-15s %-10s %-15s %-10s %-5s %-10s \n", $3, $4, $5, $6, $7, $8, $9 }}' >>tempres.csv 
                                        cat tempres.csv
                                    break    
                                    ;;
                                    3) echo "Good Bye"
                                    exit 0      #if exit is selected, then break the loop
                                    ;;
                                    *) echo "That is not a valid choice, please try again"
                                   
                                    esac        #end of case statement, returns to the initial search or exit menu
                                done
                                break
                                fi  
                                done
                        ;;
                        4) echo "Good bye"
                        exit 0
                        ;;
                        *) echo "That is not a valid selection, please try again"
                        esac                    
            done
}

filepacksearch()
{
    for file in ./*; do
    if [[ $file =~ $patt ]]; then
        logs+=($(basename $file))
    fi
done

count=${#logs[*]}
echo -e "The logs array contains $count files.\n"

while true ; do
for file in "${logs[@]}"; do
   echo "$mennum  $file"
  ((mennum++))
done
mennum=1
   
    
    echo -e  "\t"
    read -p "Enter the number of the file in the menu above that you wish to search, i.e 1,2,3 etc  " sel
    echo "You have entered $sel"
    let seltrue=$sel-1
    choice="${logs[$seltrue]}"

    if ! grep -qe "$seltrue" <(echo "${!logs[@]}"); then
        printf 'That is an invalid selection, please try again\n'
    else
        
        grep "suspicious" < $choice > tempfile.csv

            searchpack
break
    fi
done
            while true ; do
            echo -e "1) Search Again\n2) Save Results and Exit\n3) Search Another File\n4) Exit\n"
                read -p "Please enter your choice:  " selopt
                   
                    case $selopt in

                        1) echo -e "You have selected to search again, please note, this will remove your previous search results\n"

                            while true ; do
                            for file in "${logs[@]}"; do
                            echo "$mennum  $file"
                            ((mennum++))
                            done
                            
                            mennum=1
   
                            echo -e  "\t"
                            read -p "Enter the number of the file in the menu above that you wish to search, i.e 1,2,3 etc  " sel
                            echo "You have entered $sel"
                            let seltrue=$sel-1
                            choice="${logs[$seltrue]}"

                            if ! grep -qe "$seltrue" <(echo "${!logs[@]}"); then
                            printf 'That is an invalid selection, please try again\n'
                            else
        
                            grep "suspicious" < $choice > tempfile.csv

                            searchpack
                            break
                            fi
                            done
                        ;;
                        2) savefun
                        ;;
                        3) echo "You have selected to search again, please note, this will add to your previous results"

                            while true ; do
                            for file in "${logs[@]}"; do
                            echo "$mennum2  $file"
                            ((mennum2++))
                            done

                            mennum2=1

                            echo -e  "\t"
                            read -p "Enter the number of the file in the menu above that you wish to search, i.e 1,2,3 etc  " sel
                            echo "You have entered $sel"
                            let seltrue=$sel-1
                            choice="${logs[$seltrue]}"

                            if ! grep -qe "$seltrue" <(echo "${!logs[@]}"); then
                            printf 'That is an invalid selection, please try again\n'
                            else
        
                            grep "suspicious" < $choice > tempfile.csv

                                searchpack2
                            break
                            fi
                            done
                        ;;
                        4) echo "Good Bye"
                            exit 0
                        ;;
                        *) echo "That is not a valid choice, please try again"
                    esac
            done
}

fileprotpacksearch()
{
    for file in ./*; do
    if [[ $file =~ $patt ]]; then
        logs+=($(basename $file))
    fi
done

count=${#logs[*]}
echo -e "The logs array contains $count files.\n"

while true : ; do
for file in "${logs[@]}"; do
   echo "$mennum  $file"
  ((mennum++))
done
mennum=1
   
    echo -e  "\t"
    read -p "Enter the number of the file in the menu above that you wish to search, i.e 1,2,3 etc  " sel
    echo "You have entered $sel"
    let seltrue=$sel-1
    choice="${logs[$seltrue]}"

    if ! grep -qe "$seltrue" <(echo "${!logs[@]}"); then
        printf 'That is an invalid selection, please try again\n'
    else
        
        grep "suspicious" < $choice > tempfile.csv

            while true ; do
            echo -e "1) TCP\n2) UDP\n3) ICMP\n4) GRE\n5) Exit" #echo the case menu options to the terminal

                read -p 'Please select your type of search: ' selopt        #define the case variable as 'selopt'

                    case $selopt in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                        1)  grep "TCP" tempfile.csv >tempres.csv
                        break                                      
                        ;;                                                 #move on to the next case selection
                        2)  grep "UDP" tempfile.csv >tempres.csv  
                        break
                        ;;
                        3) grep "ICMP" tempfile.csv >tempres.csv 
                        break
                        ;;
                        4) grep "GRE" tempfile.csv >tempres.csv
                        break
                        ;;
                        5) echo "Good Bye"
                        exit 0          #if exit is selected, then break the loop
                        ;;
                        *) echo "That is not a valid choice, please try again"
                                   
                    esac        #end of case statement, returns to the initial search or exit menu
                done
                                
                searchpack
            break
            fi        #done for packet search loop
            done                # done for protocol search loop

            while true ; do
            echo -e "1) Search Again\n2) Save Results and Exit\n3) Search Another File\n4) Exit\n"
                read -p "Please enter your choice:  " selopt
                   
                    case $selopt in

                        1) echo -e "You have selected to search again, please note, this will remove your previous search results\n"
                        while true : ; do
                            for file in "${logs[@]}"; do
                            echo "$mennum  $file"
                            ((mennum++))
                            done
                            mennum=1
   
                            echo -e  "\t"
                            read -p "Enter the number of the file in the menu above that you wish to search, i.e 1,2,3 etc  " sel
                            echo "You have entered $sel"
                            let seltrue=$sel-1
                            choice="${logs[$seltrue]}"

                            if ! grep -qe "$seltrue" <(echo "${!logs[@]}"); then
                            printf 'That is an invalid selection, please try again\n'
                            else
        
                            grep "suspicious" < $choice > tempfile.csv

                            while true ; do
                            echo -e "1) TCP\n2) UDP\n3) ICMP\n4) GRE\n5) Exit" #echo the case menu options to the terminal

                            read -p 'Please select your type of search: ' selopt        #define the case variable as 'selopt'

                            case $selopt in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                                1)  grep "TCP" tempfile.csv >tempres.csv
                                 break                                      
                                ;;                                                 #move on to the next case selection
                                2)  grep "UDP" tempfile.csv >tempres.csv  
                                break
                                ;;
                                3) grep "ICMP" tempfile.csv >tempres.csv 
                                break
                                ;;
                                4) grep "GRE" tempfile.csv >tempres.csv
                                break
                                ;;
                                5) echo "Good Bye"
                                exit 0          #if exit is selected, then break the loop
                                ;;
                                *) echo "That is not a valid choice, please try again"
                                   
                                esac        #end of case statement, returns to the initial search or exit menu
                            done
                
                    searchpack
                break
                fi        #done for packet search loop
                done                # done for protocol search loop
                        ;;
                        2)  read -p "Please enter the name of the directory you would like to save the file to, or . for the current folder:  " pathname
                            if [[ $pathname == . ]]; then
                            read -p "Please enter the name of the file: " filename 
                            cat tempres2.csv > $filename.txt
                            echo "Your results have been saved to $pathname/$filename.txt"
                            else mkdir -p $pathname
                            read -p "Please enter the name of the file:  "  filename
                            cat tempres2.csv > $pathname/$filename.txt
                            echo "Your results have been saved to $pathname/$filename.txt."
                            fi
                        exit 0
                        ;;
                        3) echo "You have selected to search again, please note, this will add to your previous results"

                            while true ; do
                            for file in "${logs[@]}"; do
                            echo "$mennum2  $file"
                            ((mennum2++))
                            done

                            mennum2=1

                            echo -e  "\t"
                            read -p "Enter the number of the file in the menu above that you wish to search, i.e 1,2,3 etc  " sel
                            echo -e "You have entered $sel\n"
                            let seltrue=$sel-1
                            choice="${logs[$seltrue]}"

                            if ! grep -qe "$seltrue" <(echo "${!logs[@]}"); then
                                printf 'That is an invalid selection, please try again\n'
                                else
                                
                                grep "suspicious" < $choice > tempfile.csv

                                while true ; do
                                echo -e "1) TCP\n2) UDP\n3) ICMP\n4) GRE\n5) Exit" #echo the case menu options to the terminal

                                read -p 'Please select your type of search: ' selopt2        #define the case variable as 'selopt'

                                case $selopt2 in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                                    1)  grep "TCP" tempfile.csv >tempres.csv   
                                    break                                      
                                    ;;                                                 #move on to the next case selection
                                    2)  grep "UDP" tempfile.csv >tempres.csv 
                                    break
                                    ;;
                                    3) grep "ICMP" tempfile.csv >tempres.csv 
                                    break
                                    ;;
                                    4) grep "GRE" tempfile.csv >tempres.csv 
                                    break
                                    ;;
                                    5) echo "Good Bye"
                                    exit 0          #if exit is selected, then break the loop
                                    ;;
                                    *) echo "That is not a valid choice, please try again"
                                   
                                esac        #end of case statement, returns to the initial search or exit menu
                                done
                                
                                searchpack2
                                break
                                fi
                                done                            
                        ;;
                        4) echo "Good bye"
                        exit 0
                        ;;
                        *) echo "That is invalid, please try again"
                        esac                    
            done        #done for packet search loop
                                 # done for protocol search loop
}

fileprotipsearch()
{
    for file in ./*; do
    if [[ $file =~ $patt ]]; then
        logs+=($(basename $file))
    fi
done

count=${#logs[*]}
echo -e "The logs array contains $count files.\n"

while true : ; do
for file in "${logs[@]}"; do
   echo "$mennum  $file"
  ((mennum++))
done
mennum=1
   
    echo -e  "\t"
    read -p "Enter the number of the file in the menu above that you wish to search, i.e 1,2,3 etc  " sel
    echo "You have entered $sel"
    let seltrue=$sel-1
    choice="${logs[$seltrue]}"

    if ! grep -qe "$seltrue" <(echo "${!logs[@]}"); then
        printf 'That is an invalid selection, please try again\n'
    else
        
        grep "suspicious" < $choice > tempfile.csv

            while true ; do
            echo -e "1) TCP\n2) UDP\n3) ICMP\n4) GRE\n5) Exit" #echo the case menu options to the terminal

                read -p 'Please select your type of search: ' selopt        #define the case variable as 'selopt'

                    case $selopt in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                        1)  grep "TCP" tempfile.csv >tempres.csv
                        break                                      
                        ;;                                                 #move on to the next case selection
                        2)  grep "UDP" tempfile.csv >tempres.csv  
                        break
                        ;;
                        3) grep "ICMP" tempfile.csv >tempres.csv 
                        break
                        ;;
                        4) grep "GRE" tempfile.csv >tempres.csv
                        break
                        ;;
                        5) echo "Good Bye"
                        exit 0          #if exit is selected, then break the loop
                        ;;
                        *) echo "That is not a valid choice, please try again"
                                   
                    esac        #end of case statement, returns to the initial search or exit menu
                done
                                
                searchip3
            break
            fi        #done for packet search loop
            done                # done for protocol search loop

            while true ; do
            echo -e "1) Search Again\n2) Save Results and Exit\n3) Search Another File\n4) Exit\n"
                read -p "Please enter your choice:  " selopt
                   
                    case $selopt in

                        1) echo -e "You have selected to search again, please note, this will remove your previous search results\n"
                        while true : ; do
                            for file in "${logs[@]}"; do
                            echo "$mennum  $file"
                            ((mennum++))
                            done
                            mennum=1
   
                            echo -e  "\t"
                            read -p "Enter the number of the file in the menu above that you wish to search, i.e 1,2,3 etc  " sel
                            echo "You have entered $sel"
                            let seltrue=$sel-1
                            choice="${logs[$seltrue]}"

                            if ! grep -qe "$seltrue" <(echo "${!logs[@]}"); then
                            printf 'That is an invalid selection, please try again\n'
                            else
        
                            grep "suspicious" < $choice > tempfile.csv

                            while true ; do
                            echo -e "1) TCP\n2) UDP\n3) ICMP\n4) GRE\n5) Exit" #echo the case menu options to the terminal

                            read -p 'Please select your type of search: ' selopt        #define the case variable as 'selopt'

                            case $selopt in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                                1)  grep "TCP" tempfile.csv >tempres.csv
                                 break                                      
                                ;;                                                 #move on to the next case selection
                                2)  grep "UDP" tempfile.csv >tempres.csv  
                                break
                                ;;
                                3) grep "ICMP" tempfile.csv >tempres.csv 
                                break
                                ;;
                                4) grep "GRE" tempfile.csv >tempres.csv
                                break
                                ;;
                                5) echo "Good Bye"
                                exit 0          #if exit is selected, then break the loop
                                ;;
                                *) echo "That is not a valid choice, please try again"
                                   
                                esac        #end of case statement, returns to the initial search or exit menu
                            done
                
                    searchip3
                break
                fi        #done for packet search loop
                done                # done for protocol search loop
                        ;;
                        2)  read -p "Please enter the name of the directory you would like to save the file to, or . for the current folder:  " pathname
                            if [[ $pathname == . ]]; then
                            read -p "Please enter the name of the file: " filename 
                            cat tempres2.csv > $filename.txt
                            echo "Your results have been saved to $pathname/$filename.txt"
                            else mkdir -p $pathname
                            read -p "Please enter the name of the file:  "  filename
                            cat tempres2.csv > $pathname/$filename.txt
                            echo "Your results have been saved to $pathname/$filename.txt."
                            fi
                        exit 0
                        ;;
                        3) echo "You have selected to search again, please note, this will add to your previous results"

                            while true ; do
                            for file in "${logs[@]}"; do
                            echo "$mennum2  $file"
                            ((mennum2++))
                            done

                            mennum2=1

                            echo -e  "\t"
                            read -p "Enter the number of the file in the menu above that you wish to search, i.e 1,2,3 etc  " sel
                            echo -e "You have entered $sel\n"
                            let seltrue=$sel-1
                            choice="${logs[$seltrue]}"

                            if ! grep -qe "$seltrue" <(echo "${!logs[@]}"); then
                                printf 'That is an invalid selection, please try again\n'
                                else
                                
                                grep "suspicious" < $choice > tempfile.csv

                                while true ; do
                                echo -e "1) TCP\n2) UDP\n3) ICMP\n4) GRE\n5) Exit" #echo the case menu options to the terminal

                                read -p 'Please select your type of search: ' selopt2        #define the case variable as 'selopt'

                                case $selopt2 in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                                    1)  grep "TCP" tempfile.csv >tempres.csv   
                                    break                                      
                                    ;;                                                 #move on to the next case selection
                                    2)  grep "UDP" tempfile.csv >tempres.csv 
                                    break
                                    ;;
                                    3) grep "ICMP" tempfile.csv >tempres.csv 
                                    break
                                    ;;
                                    4) grep "GRE" tempfile.csv >tempres.csv 
                                    break
                                    ;;
                                    5) echo "Good Bye"
                                    exit 0          #if exit is selected, then break the loop
                                    ;;
                                    *) echo "That is not a valid choice, please try again"
                                   
                                esac        #end of case statement, returns to the initial search or exit menu
                                done
                                
                                searchip4
                                break
                                fi
                                done                            
                        ;;
                        4) echo "Good bye"
                        exit 0
                        ;;
                        *) echo "That is invalid, please try again"
                        esac                    
            done        #done for packet search loop
}

fileippacksearch()
{
    for file in ./*; do
    if [[ $file =~ $patt ]]; then
        logs+=($(basename $file))
    fi
done

count=${#logs[*]}
echo -e "The logs array contains $count files.\n"

while true : ; do
for file in "${logs[@]}"; do
   echo "$mennum  $file"
  ((mennum++))
done
mennum=1
   
    echo -e  "\t"
    read -p "Enter the number of the file in the menu above that you wish to search, i.e 1,2,3 etc  " sel
    echo "You have entered $sel"
    let seltrue=$sel-1
    choice="${logs[$seltrue]}"

    if ! grep -qe "$seltrue" <(echo "${!logs[@]}"); then
        printf 'That is an invalid selection, please try again\n'
    else
        
        grep "suspicious" < $choice > tempfile.csv

            while true ; do
            echo -e "1) SRC IP\n2) DEST IP\n3) Exit" #echo the case menu options to the terminal

                read -p 'Please select your type of search: ' selopt        #define the case variable as 'selopt'

                    case $selopt in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                        1)  read -p "Please enter a search term (e.g ext):  " usrchoice
                        usrchoice2=${usrchoice^^}
                        grep -i "$usrchoice" tempfile.csv | awk -v CHOICE=$usrchoice2 ' BEGIN {FS=","} {if ($4 ~ CHOICE) print $0}' >tempres.csv 
                        break                                      
                        ;;                                                 #move on to the next case selection
                        2)  read -p "Please enter a search term (e.g ext):  " usrchoice
                        usrchoice2=${usrchoice^^}
                        grep -i "$usrchoice" tempfile.csv | awk -v CHOICE=$usrchoice2 ' BEGIN {FS=","} {if ($6 ~ CHOICE) print $0}' >tempres.csv 
                        break
                        ;;
                        3) echo "Good Bye"
                        exit 0          #if exit is selected, then break the loop
                        ;;
                        *) echo "That is not a valid choice, please try again"
                                   
                    esac        #end of case statement, returns to the initial search or exit menu
            done
                                
                searchpack
            break
            fi        #done for packet search loop
            done                # done for protocol search loop

            while true ; do
            echo -e "1) Search Again\n2) Save Results and Exit\n3) Search Another File\n4) Exit\n"
                read -p "Please enter your choice:  " selopt
                   
                    case $selopt in

                        1) echo -e "You have selected to search again, please note, this will remove your previous search results\n"
                        while true : ; do
                            for file in "${logs[@]}"; do
                            echo "$mennum  $file"
                            ((mennum++))
                            done
                            mennum=1
   
                            echo -e  "\t"
                            read -p "Enter the number of the file in the menu above that you wish to search, i.e 1,2,3 etc  " sel
                            echo "You have entered $sel"
                            let seltrue=$sel-1
                            choice="${logs[$seltrue]}"

                            if ! grep -qe "$seltrue" <(echo "${!logs[@]}"); then
                            printf 'That is an invalid selection, please try again\n'
                            else
        
                            grep "suspicious" < $choice > tempfile.csv

                            while true ; do
            echo -e "1) SRC IP\n2) DEST IP\n3) Exit" #echo the case menu options to the terminal

                read -p 'Please select your type of search: ' selopt        #define the case variable as 'selopt'

                    case $selopt in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                        1)  read -p "Please enter a search term (e.g ext):  " usrchoice
                        usrchoice2=${usrchoice^^}
                        grep -i "$usrchoice" tempfile.csv | awk -v CHOICE=$usrchoice2 ' BEGIN {FS=","} {if ($4 ~ CHOICE) print $0}' >tempres.csv 
                        break                                      
                        ;;                                                 #move on to the next case selection
                        2)  read -p "Please enter a search term (e.g ext):  " usrchoice
                        usrchoice2=${usrchoice^^}
                        grep -i "$usrchoice" tempfile.csv | awk -v CHOICE=$usrchoice2 ' BEGIN {FS=","} {if ($6 ~ CHOICE) print $0}' >tempres.csv 
                        break
                        ;;
                        3) echo "Good Bye"
                        exit 0          #if exit is selected, then break the loop
                        ;;
                        *) echo "That is not a valid choice, please try again"
                                   
                    esac        #end of case statement, returns to the initial search or exit menu
            done
                
                    searchpack
                break
                fi        #done for packet search loop
                done                # done for protocol search loop
                        ;;
                        2)  read -p "Please enter the name of the directory you would like to save the file to, or . for the current folder:  " pathname
                            if [[ $pathname == . ]]; then
                            read -p "Please enter the name of the file: " filename 
                            cat tempres2.csv > $filename.txt
                            echo "Your results have been saved to $pathname/$filename.txt"
                            else mkdir -p $pathname
                            read -p "Please enter the name of the file:  "  filename
                            cat tempres2.csv > $pathname/$filename.txt
                            echo "Your results have been saved to $pathname/$filename.txt."
                            fi
                        exit 0
                        ;;
                        3) echo "You have selected to search again, please note, this will add to your previous results"

                            while true ; do
                            for file in "${logs[@]}"; do
                            echo "$mennum2  $file"
                            ((mennum2++))
                            done

                            mennum2=1

                            echo -e  "\t"
                            read -p "Enter the number of the file in the menu above that you wish to search, i.e 1,2,3 etc  " sel
                            echo -e "You have entered $sel\n"
                            let seltrue=$sel-1
                            choice="${logs[$seltrue]}"

                            if ! grep -qe "$seltrue" <(echo "${!logs[@]}"); then
                                printf 'That is an invalid selection, please try again\n'
                                else
                                
                                grep "suspicious" < $choice > tempfile.csv

                                while true ; do
            echo -e "1) SRC IP\n2) DEST IP\n3) Exit" #echo the case menu options to the terminal

                read -p 'Please select your type of search: ' selopt        #define the case variable as 'selopt'

                    case $selopt in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                        1)  read -p "Please enter a search term (e.g ext):  " usrchoice
                        usrchoice2=${usrchoice^^}
                        grep -i "$usrchoice" tempfile.csv | awk -v CHOICE=$usrchoice2 ' BEGIN {FS=","} {if ($4 ~ CHOICE) print $0}' >tempres.csv 
                        break                                      
                        ;;                                                 #move on to the next case selection
                        2)  read -p "Please enter a search term (e.g ext):  " usrchoice
                        usrchoice2=${usrchoice^^}
                        grep -i "$usrchoice" tempfile.csv | awk -v CHOICE=$usrchoice2 ' BEGIN {FS=","} {if ($6 ~ CHOICE) print $0}' >tempres.csv 
                        break
                        ;;
                        3) echo "Good Bye"
                        exit 0          #if exit is selected, then break the loop
                        ;;
                        *) echo "That is not a valid choice, please try again"
                                   
                    esac        #end of case statement, returns to the initial search or exit menu
            done
                                
                                searchpack2
                                break
                                fi
                                done                            
                        ;;
                        4) echo "Good bye"
                        exit 0
                        ;;
                        *) echo "That is invalid, please try again"
                        esac                    
            done        #done for packet search loop
                                 # done for protocol search loop
}

fileallsearch()
{
    for file in ./*; do
    if [[ $file =~ $patt ]]; then
        logs+=($(basename $file))
    fi
done

count=${#logs[*]}
echo -e "The logs array contains $count files.\n"

while true : ; do
for file in "${logs[@]}"; do
   echo "$mennum  $file"
  ((mennum++))
done
mennum=1
   
    echo -e  "\t"
    read -p "Enter the number of the file in the menu above that you wish to search, i.e 1,2,3 etc  " sel
    echo "You have entered $sel"
    let seltrue=$sel-1
    choice="${logs[$seltrue]}"

    if ! grep -qe "$seltrue" <(echo "${!logs[@]}"); then
        printf 'That is an invalid selection, please try again\n'
    else
        
        grep "suspicious" < $choice > tempfile.csv

            while true ; do
            echo -e "1) TCP\n2) UDP\n3) ICMP\n4) GRE\n5) Exit" #echo the case menu options to the terminal

                read -p 'Please select your type of search: ' selopt        #define the case variable as 'selopt'

                    case $selopt in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                        1)  grep "TCP" tempfile.csv >tempres.csv
                        break                                      
                        ;;                                                 #move on to the next case selection
                        2)  grep "UDP" tempfile.csv >tempres.csv  
                        break
                        ;;
                        3) grep "ICMP" tempfile.csv >tempres.csv 
                        break
                        ;;
                        4) grep "GRE" tempfile.csv >tempres.csv
                        break
                        ;;
                        5) echo "Good Bye"
                        exit 0          #if exit is selected, then break the loop
                        ;;
                        *) echo "That is not a valid choice, please try again"
                                   
                    esac        #end of case statement, returns to the initial search or exit menu
                done
                                
                searchip5
                searchpack5
            break
            fi        #done for packet search loop
            done                # done for protocol search loop

            while true ; do
            echo -e "1) Search Again\n2) Save Results and Exit\n3) Search Another File\n4) Exit\n"
                read -p "Please enter your choice:  " selopt
                   
                    case $selopt in

                        1) echo -e "You have selected to search again, please note, this will remove your previous search results\n"
                        while true : ; do
                            for file in "${logs[@]}"; do
                            echo "$mennum  $file"
                            ((mennum++))
                            done
                            mennum=1
   
                            echo -e  "\t"
                            read -p "Enter the number of the file in the menu above that you wish to search, i.e 1,2,3 etc  " sel
                            echo "You have entered $sel"
                            let seltrue=$sel-1
                            choice="${logs[$seltrue]}"

                            if ! grep -qe "$seltrue" <(echo "${!logs[@]}"); then
                            printf 'That is an invalid selection, please try again\n'
                            else
        
                            grep "suspicious" < $choice > tempfile.csv

                            while true ; do
                            echo -e "1) TCP\n2) UDP\n3) ICMP\n4) GRE\n5) Exit" #echo the case menu options to the terminal

                            read -p 'Please select your type of search: ' selopt        #define the case variable as 'selopt'

                            case $selopt in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                                1)  grep "TCP" tempfile.csv >tempres.csv
                                 break                                      
                                ;;                                                 #move on to the next case selection
                                2)  grep "UDP" tempfile.csv >tempres.csv  
                                break
                                ;;
                                3) grep "ICMP" tempfile.csv >tempres.csv 
                                break
                                ;;
                                4) grep "GRE" tempfile.csv >tempres.csv
                                break
                                ;;
                                5) echo "Good Bye"
                                exit 0          #if exit is selected, then break the loop
                                ;;
                                *) echo "That is not a valid choice, please try again"
                                   
                                esac        #end of case statement, returns to the initial search or exit menu
                            done
                
                    searchip5
                    searchpack5
                break
                fi        #done for packet search loop
                done                # done for protocol search loop
                        ;;
                        2)  read -p "Please enter the name of the directory you would like to save the file to, or . for the current folder:  " pathname
                            if [[ $pathname == . ]]; then
                            read -p "Please enter the name of the file: " filename 
                            cat tempres3.csv > $filename.txt
                            echo "Your results have been saved to $pathname/$filename.txt"
                            else mkdir -p $pathname
                            read -p "Please enter the name of the file:  "  filename
                            cat tempres3.csv > $pathname/$filename.txt
                            echo "Your results have been saved to $pathname/$filename.txt."
                            fi
                        exit 0
                        ;;
                        3) echo "You have selected to search again, please note, this will add to your previous results"

                            while true ; do
                            for file in "${logs[@]}"; do
                            echo "$mennum2  $file"
                            ((mennum2++))
                            done

                            mennum2=1

                            echo -e  "\t"
                            read -p "Enter the number of the file in the menu above that you wish to search, i.e 1,2,3 etc  " sel
                            echo -e "You have entered $sel\n"
                            let seltrue=$sel-1
                            choice="${logs[$seltrue]}"

                            if ! grep -qe "$seltrue" <(echo "${!logs[@]}"); then
                                printf 'That is an invalid selection, please try again\n'
                                else
                                
                                grep "suspicious" < $choice > tempfile.csv

                                while true ; do
                                echo -e "1) TCP\n2) UDP\n3) ICMP\n4) GRE\n5) Exit" #echo the case menu options to the terminal

                                read -p 'Please select your type of search: ' selopt2        #define the case variable as 'selopt'

                                case $selopt2 in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)

                                    1)  grep "TCP" tempfile.csv >tempres.csv   
                                    break                                      
                                    ;;                                                 #move on to the next case selection
                                    2)  grep "UDP" tempfile.csv >tempres.csv 
                                    break
                                    ;;
                                    3) grep "ICMP" tempfile.csv >tempres.csv 
                                    break
                                    ;;
                                    4) grep "GRE" tempfile.csv >tempres.csv 
                                    break
                                    ;;
                                    5) echo "Good Bye"
                                    exit 0          #if exit is selected, then break the loop
                                    ;;
                                    *) echo "That is not a valid choice, please try again"
                                   
                                esac        #end of case statement, returns to the initial search or exit menu
                                done
                                
                                searchip6
                                searchpack6
                                break
                                fi
                                done                            
                        ;;
                        4) echo "Good bye"
                        exit 0
                        ;;
                        *) echo "That is invalid, please try again"
                        esac                    
            done        #done for packet search loop
}

 while : ; do                                           #preliminary loop to select whether to search for all logs or individual logs
            echo -e "1) All Logs\n2) Individual Logs\n3) Exit" #echo the case menu options to the terminal

                read -p 'Please select if you would like to search across all logs, individual files or exit the script (1, 2 or 3): ' selopt        #define the case variable as 'selopt'

                    case $selopt in     #if option $selopt is chosen, then commence the appropriate case - 1), 2) or 3)
                    1) while : ; do
                        echo -e "1) Protocol Search\n2) SRC IP/ DEST IP Search\n3) Packets/ Bytes Search\n4) Protocol and Packets/Bytes Search\n5) Protocol and SRC IP/DEST IP Search\n6) SRC IP/ DEST IP and Packets/ Bytes Search\n7) All options search\n8) Exit the Search"  #echo options to the terminal

                        read -p 'Please select the type of search you would like to perform:  ' selopt

                            case $selopt in

                            1) allprotsearch
                            ;;
                            2) allipsearch
                            ;;
                            3) allpacksearch
                            ;;
                            4) allprotpacksearch
                            ;;
                            5) allprotipsearch
                            ;;
                            6) allippacksearch
                            ;;
                            7) allsearch
                            ;;
                            8) echo "Good Bye"
                            exit 0
                            ;;
                            *) echo "That is invalid, please try again"

                            esac
                        done
                    ;;
                    2) while : ; do
                        echo -e "1) Protocol Search\n2) SRC IP/ DEST IP Search\n3) Packets/ Bytes Search\n4) Protocol and Packets/Bytes Search\n5) Protocol and SRC IP/DEST IP Search\n6) SRC IP/ DEST IP and Packets/ Bytes Search\n7) All options search\n8) Exit the Search"  #echo options to the terminal

                        read -p 'Please select the type of search you would like to perform:  ' selopt

                            case $selopt in

                            1) fileprotsearch
                            ;;
                            2) fileipsearch
                            ;;
                            3) filepacksearch
                            ;;
                            4) fileprotpacksearch
                            ;;
                            5) fileprotipsearch
                            ;;
                            6) fileippacksearch
                            ;;
                            7) fileallsearch
                            ;;
                            8) echo "Good Bye"
                            exit 0
                            ;;
                            *) echo "That is invalid, please try again"

                            esac
                        done

                       # done
                    ;;
                    3) echo "Good Bye"
                    exit 0
                    ;;
                    *) echo "That is invalid, please try again"
                    esac
                    
done

exit 0