TYPE=${1:-amphp}

function print_stats() {
    FILE=results/$1-$2/$3.txt

    if [ -f $FILE ]
      then
        echo ""
        echo "$2"
        echo "============================================="
        echo ""
        grep -A11 -e "Thread Stats\s*Avg\s*Stdev\s*Max\s*.*\s*Stdev" $FILE
	      grep -B1  -e "Total count\s*=\s*" $FILE
	      grep "Socket errors:" $FILE
    fi
}


for CONNECTIONS in 500 800 1000
do
  echo "#### $CONNECTIONS open connections"


  for RPS in 5k 10k 15k 17k 18k 19k 20k 21k 22k
  do
    echo "##### $RPS Backpressure"
    echo "\`\`\`"
    print_stats $CONNECTIONS "opcache-$TYPE" $RPS
    print_stats $CONNECTIONS "jit-$TYPE" $RPS
    echo "\`\`\`"
  done
done
