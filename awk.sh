#!/bin/bash

#transaction validation times

echo "time to validate 1M txns"

awk '/poolsz 1 txn/{txn1=$2;next} /poolsz 1000000 txn/{print txn1 " " $2}' /home/mike/.bitcoin/regtest/bitcoind.log| awk '{ split($2,a,":") && split ($1,b, ":") ;print "start="$1, "finish="$2, "validationtime="((a[1]*3600)+(a[2]*60)+a[3]) - ((b[1]*3600)+(b[2]*60)+b[3]) }'




#number of validation timeouts

echo "validation timeouts"
awk '/code 64/ {count++} END {print "number of timeouts=" count}' /home/mike/.bitcoin/regtest/bitcoind.log


# return block info

echo "block info details"

awk '/CreateNewBlock/ {a=$2;b=$7;c=$9}  /UpdateTip/ {print $7, "time="a, "blocksize="b, "txns="c}' /home/mike/.bitcoin/regtest/bitcoind.log

wait

#return block create times

echo "block create times"

awk '/UpdateTip:/ {print $7,substr($2,1,length($2)-7), substr($12,1,length($12)-1)}' /home/mike/.bitcoin/regtest/bitcoind.log| awk '{ split($2,a,":") && split ($3,b, ":");print $1, "start="$3, "stop="$2, "generate(secs)="((a[1]*3600)+(a[2]*60)+a[3]) - ((b[1]*3600) +(b[2]*60)+b[3]) }'

