tref=$(awk '{print $2}' xx00)
href=$(awk '{print $3}' xx00)
ofile=output

echo "{" > $ofile


# temperature analyser

for tfile in $(ls temp*); do
  tlimit=0
  while read tline; do 
    delta=$(echo "$tline - $tref" | bc)
    pdelta=$(echo $delta | sed 's/-//')
    if (( $(echo "$pdelta > 0.5" | bc -l) )); then 
      #echo "over the limit"
      tlimit=$(($tlimit+1))
    fi
  done < $tfile
  #echo "$tfile have limit: $tlimit"
  if [ $tlimit -lt 3 ]; then
    echo "\"$tfile\": \"ultra precise\"" >> $ofile
  elif [ $tlimit -gt 3 ] && [ $tlimit -lt 5 ]; then
    echo "\"$tfile\": \"very precise\"" >> $ofile
  elif [ $tlimit -gt 5 ]; then
    echo "\"$tfile\": \"precise\"" >> $ofile
  fi
done


# humidity analyser

for hfile in $(ls hum*); do
  hlimit=0
  while read hline; do
    hdelta=$(echo "$hline - $href" | bc)
    hpdelta=$(echo $hdelta | sed 's/-//')
    if (( $(echo "$hpdelta > 1" | bc -l) )); then
      #echo "over the limit"
      hlimit=$(($hlimit+1))
    fi
  done < $hfile
  #echo "$hfile have limit: $hlimit"
  if [ $hlimit -lt 1 ]; then
    echo -e "\"$hfile\": \"keep\"" >> $ofile
  else 
    echo "\"$hfile\": \"discard\"" >> $ofile
  fi
done

echo "}" >> $ofile
