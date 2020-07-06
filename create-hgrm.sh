TYPE=${1:-amphp}

function print_stats() {
    FILE=results/$1-$2/$3.txt

    if [ -f $FILE ]
      then
        extract_hgrm $FILE > results/$1-$2-$3.hgrm
    fi
}

function extract_hgrm() {
    PRINT=0

    while IFS= read -r line
    do


      if [[ $line =~ ^\s*-------------------------- ]]
        then
          PRINT=0
      fi

      if [ $PRINT -gt 0 ]
        then
          echo "$line"
      fi

      if [[ $line =~ Detailed ]]
        then
          PRINT=1
      fi
    done < "$1"
}


for CONNECTIONS in 500 800 1000
do

  for RPS in 5k 10k 15k 17k 18k 19k 20k 21k 22k
  do
    print_stats $CONNECTIONS "opcache-$TYPE" $RPS
    print_stats $CONNECTIONS "jit-$TYPE" $RPS
  done
done
