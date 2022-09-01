
#!/bin/bash

# file to measure block propagation times from a bitcoind.log file


### $1 is argument  passed to this script and refers to the logfile


# extract UpdateTip data

#update=($(awk '/UpdateTip: new best=/ {print $6, $1, $2}' /home/mike/.bitcoin/bitcoind_propagation_1.0.8.log))




update=($(awk '/UpdateTip: new best=/ {$6=substr($6,6,length($6));print $6, $1, $2}' /home/mike/.bitcoin/$1))

for x in "${update[@]}"
do
   :
#  echo "string value  is " $x
done


#echo "first element= " ${update[0]}
#echo "second element= " ${update[1]}
#echo "third element= " ${update[2]}


#echo "4th element= " ${update[3]}
#echo "5th element= " ${update[4]}
#echo "6th element= " ${update[5]}


#test="00005800cc3bd4eea97a94b8ff9bb39cc3bc1bc54293203b6c56004521717a95"

#echo "search array for value"

#q=0

#until [ $q -eq ${#update[@]} ]
#do
        

#	if

 #	[[ " ${update[q]} " =~ " ${test} " ]]; then echo "index of search match  is " $q; 

    
#	fi
#	((q++))

#done

# sendblck=headers and timestamps

#block_header=($(awk '//' /home/mike/.bitcoin/bitcoind_propagation_1.0.8.log))


# work  out  each unique hash value from the log and put into array 
pattern=($(awk '/SendBlockHeaders: sending header/ { a[$7]++ } END { for (b in a) { if(length(b)>10) hash=b; print hash}}' /home/mike/.bitcoin/$1))


#echo "hash value 1 is" ${pattern[0]}

#echo "hash value 2 is" ${pattern[1]}


#echo "hash value 3 is" ${pattern[2]}


#echo "values  of array for unique hashes"

for i in "${pattern[@]}"
do
   :
 # echo "hash value  is " $i

#sendblockheader=$(awk '/SendBlockHeaders: sending header '"$i"'/ {print $7, $1, $2; }' /home/mike/.bitcoin/bitcoind_propagation_1.0.8.log)

done

hash_length=${#pattern[@]}

echo "unique number of hashes is " $hash_length



# extract headers info into array

headers=($(awk '/SendBlockHeaders: sending header / {print $7, $1, $2;}' /home/mike/.bitcoin/$1))


echo "sendblockheaders"


#echo "print out array of sendblockheader amtches"
for z in "${headers[@]}"
do
   :
 # echo "hash value  is " $z


done



index=0
loop=$hash_length

q=0

until [ $index -eq $loop ]
do

#	headers=($(awk '/SendBlockHeaders: sending header '"${pattern[$index]}"'/ {print $7, $1, $2;}' /home/mike/.bitcoin/bitcoind_propagation_1.0.8.log))
	

# timestamp returned is $2. work out propgation delay from TipUpdate timestamp

#echo "sendblockheader timestamp is " ${headers[2]}



echo "search for TipUpdate timestamp"


	#until [ $q -eq ${#update[@]} ]
	
for i in "${!update[@]}"; 
	do
   		[[ "${update[$i]}" = "${pattern[$index]}" ]] && break
	done


for y in "${!headers[@]}";
        do
                [[ "${headers[$y]}" = "${pattern[$index]}" ]] && break
        done



#echo "arrray index for match is " $i

# once hash is found refernece the timstamp in array
b=$((i + 2))
c=$((y + 2))

echo "hash value is " ${pattern[index]}

echo "timestamp for TipUpdate is " ${update[$b]}      

echo "timestamp for sendblockheaders is " ${headers[$c]}


# calculate time difference in secs 
string2=${headers[$c]}
string1=${update[$b]}
StartDate=$(date -u -d "$string1" +"%s")
FinalDate=$(date -u -d "$string2" +"%s")


echo "timestamp difference in secs " $(date -u -d "0 $FinalDate sec - $StartDate sec" +"%S")


#if [[ " ${update[@]} " =~ " ${pattern[$index]} " ]]; 
#		then echo "index of search match  is " ;


 #       	fi
	

	

((index++))

done


#awk '/SendBlockHeaders: sending header '"${pattern[0]}"'/ {print $1, $2, $7; exit}' /home/mike/.bitcoin/bitcoind_propagation_1.0.8.log
#awk '/SendBlockHeaders: sending header '"${pattern[1]}"'/ {print $1, $2, $7; exit}' /home/mike/.bitcoin/bitcoind_propagation_1.0.8.log
#awk '/SendBlockHeaders: sending header '"${pattern[2]}"'/ {print $1, $2, $7; exit}' /home/mike/.bitcoin/bitcoind_propagation_1.0.8.log
#awk '/SendBlockHeaders: sending header '"${pattern[3]}"'/ {print $1, $2, $7; exit}' /home/mike/.bitcoin/bitcoind_propagation_1.0.8.log
#awk '/SendBlockHeaders: sending header '"${pattern[4]}"'/ {print $1, $2, $7; exit}' /home/mike/.bitcoin/bitcoind_propagation_1.0.8.log







