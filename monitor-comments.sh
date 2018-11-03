#! /bin/bash
echo "Following Script was created by:"
echo "Spyridon Kalogeropoulos";
echo "S1632672";
while true; do # Starts a loop
echo "Below are the changes in the past 15 Seconds" # Echo's a text
echo "$(< ~/.trashCan/.monitorText)"; # Echo's the contents of the monitorText
sleep 15; # pauses for 15 seconds
done # end of loop
