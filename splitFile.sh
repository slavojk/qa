
LOGFILE=$1

csplit $LOGFILE /thermometer/ /humidity/

for file in $(ls xx*); do
  if grep humidity $file; then 
    mv $file vlhkomer
  elif grep thermometer $file; then 
    mv $file teplomer
  fi
done

csplit -f shum vlhkomer /.hum./
csplit -f therm teplomer /.temp./

for tfile in $(ls therm*); do
 thermometer=$(awk '/temp/ {print $2}' $tfile)
 touch $thermometer
 grep -v temp $tfile | awk '{print $2}' >> $thermometer
done

for hfile in $(ls shum*); do
 humidity=$(awk '/hum/ {print $2}' $hfile)
 touch $humidity
 grep -v hum $hfile | awk '{print $2}' >> $humidity
done

