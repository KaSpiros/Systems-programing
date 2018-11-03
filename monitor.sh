#! /bin/bash
echo "Following Script was created by:"
echo "Spyridon Kalogeropoulos";
echo "S1632672";
while true; do 
echo "Below are the changes in the past 15 Seconds"
echo "$(< ~/.trashCan/.monitorText)";
sleep 15;
done
