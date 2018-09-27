#usage: ./tmpct.sh <sleep time in seconds> KB|MB
rm -rf tmscript*
mkdir -p tmscript
touch ./tmscript/avg.txt
touch ./tmscript/avgmb.txt
counter=0

echo "The time between runs is $1 seconds"
iterations=$(wc -l tmscript/avg.txt | awk '{print $1}' | bc)

while true;
    do


    iterations=$(wc -l tmscript/avg.txt | awk '{print $1}' | bc)
    fixediter=$(($iterations + 1))
    echo "Total number of iterations is" $fixediter "and the time between is" $1 "seconds."

	cat ./tmscript/tm.txt > ./tmscript/old.txt
	cat ./tmscript/mb.txt > ./tmscript/mbold.txt

	tmutil status | awk '/_raw_Percent/ {print $3}' | grep -o '[0-9].[0-9]\+' | awk '{print $1*100}' > ./tmscript/tm.txt
	printf "The new percentage is " 
	cat ./tmscript/tm.txt  | tr '\n' '%'
        echo " "
        
    if [ "$counter" -gt "0" ] ; then
		printf "The difference is "
		paste ./tmscript/tm.txt ./tmscript/old.txt | awk '{print $1 - $2}' >> ./tmscript/avg.txt
		tail -1 ./tmscript/avg.txt  | tr '\n' '%'
                echo " "
		awk '{s+=$1} END {print "Average Difference: " s/NR}' ./tmscript/avg.txt | tr '\n' '%'
	        #cat ./tmscript/avg.txt | tr '\n' ' '
                echo " "
         else
		echo "0" >> ./tmscript.avg.txt
    fi
        if [ "$2" == "MB" ]; then

	transferMB=$(tmutil status | grep bytes | awk '{print $3}' | sed 's/.$//'> ./tmscript/bytestotal.txt && echo "$(cat ./tmscript/bytestotal.txt)/1048576" | bc)
	newtransferMB=$(tmutil status | grep bytes | awk '{print $3}' | sed 's/.$//'> ./tmscript/bytes.txt && echo "$(cat ./tmscript/bytes.txt)/1048576" | bc)
	tmutil status | grep bytes | awk '{print $3}' | sed 's/.$//'> ./tmscript/bytes.txt && echo "$(cat ./tmscript/bytes.txt)/1048576" | bc > ./tmscript/mb.txt
	    if [ "$counter" -gt "0" ] ; then
		paste ./tmscript/mb.txt ./tmscript/mbold.txt | awk '{print $1 - $2}' >> ./tmscript/avgmb.txt
		newtransfervar=$(tail -1 ./tmscript/avgmb.txt)
		echo "New MBs transferred: " $newtransfervar "MB"

		awk '{s+=$1} END {print "" s/NR}' ./tmscript/avgmb.txt > ./tmscript/avgmb_num.txt
                echo "Total MBs transferred: " $transferMB "MB"
                printf "Avg MB transferred b/w runs: "

		cat ./tmscript/avgmb_num.txt | tr '\n' ' '
                printf "MB"
                echo " "
	    fi
        else
       	transferKB=$(tmutil status | grep bytes | awk '{print $3}' | sed 's/.$//'> ./tmscript/bytestotal.txt && echo "$(cat ./tmscript/bytestotal.txt)/1024" | bc)

	newtransferKB=$(tmutil status | grep bytes | awk '{print $3}' | sed 's/.$//'> ./tmscript/bytes.txt && echo "$(cat ./tmscript/bytes.txt)/1024" | bc )
	tmutil status | grep bytes | awk '{print $3}' | sed 's/.$//'> ./tmscript/bytes.txt && echo "$(cat ./tmscript/bytes.txt)/1024" | bc > ./tmscript/mb.txt
	if [ "$counter" -gt "0" ] ; then
		paste ./tmscript/mb.txt ./tmscript/mbold.txt | awk '{print $1 - $2}' >> ./tmscript/avgmb.txt
		newtransfervar=$(tail -1 ./tmscript/avgmb.txt)
                echo "New KBs transferred: " $newtransfervar "KB"

                #awk '{s+=$1} END {print "Avg KB transferred b/w runs: " s/NR}' ./tmscript/avgmb.txt
		awk '{s+=$1} END {print "" s/NR}' ./tmscript/avgmb.txt > ./tmscript/avgmb_num.txt
		echo "Total KBs transferred: " $transferKB "KB"
                printf "Avg KB transferred b/w runs: "

		cat ./tmscript/avgmb_num.txt | tr '\n' ' '
                printf "KB"
                echo " "
	fi

        fi

    (( counter++ ))

#	if [ "$2" == "yes" ] ; then
#		sed -i '.bak' '/.*/d' tmscript/avg.txt
#		sed -i '.bak' '/.*/d' tmscript/avgmb.txt
#		echo "The first line has been deleted"
#		echo "In the averages files"
#	fi
	echo "-----------------"
	echo ""
	sleep $1

done
