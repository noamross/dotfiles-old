#!/bin/bash

# Usage: speedtest <outputfile> <waittimeinsecs>

speedtest --csv-header > $1
echo "Running speed test, Press [CTRL+C] to stop.."
while :;
do
  speedtest --csv >> $1
  sleep $2
done

