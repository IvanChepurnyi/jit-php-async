for TYPE in opcache-amphp jit-amphp opcache-react jit-react
do
  echo ""
  echo "======================"
  echo "Results for $TYPE: "
  echo "======================"
  echo ""

  for RPS in 1k 5k 10k 15k 17k 18k 20k 21k 22k
  do
    FILE=results/$TYPE/$RPS.txt
    if [ -f $FILE ]
    then
      echo ""
      echo "$RPS Backpressure ($TYPE)"
      echo "============================================="
      echo ""
      grep -A11 -e "Thread Stats\s*Avg\s*Stdev\s*Max\s*.*\s*Stdev" $FILE
    fi
  done
done