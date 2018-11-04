#! /bin/bash
USAGE="usage: $0 <fill in usage>" 
DIR=~/.trashCan; 
mkdir ~/.trashCan;
touch ~/.trashCan/.monitorText; 
clear;
echo "Following Script was created by:"
echo "Spyridon Kalogeropoulos";
echo "S1632672";
sleep 1.5;
clear;

safeDel ()
{ 
if [ -f $PWD/$@ ]; then
for filename in "$@"; do
mv "$filename" $DIR;
echo "$filename has successfully been moved to TrashCan!"
echo "$filename has successfully been moved to TrashCan!" >> ~/.trashCan/.monitorText;
done
else 
echo "File was not found"
fi
}

lit () { 
if [ "$(ls $DIR)" ]; then
    for filename in $DIR/* ; do
  LISTFILES=$(du -sb < $filename);
  FILE=$(basename $filename);
  TYPE=$(file -b $filename);
printf  "File: %s\t Size: %s\t Type: %s\t \n" "$FILE" "$LISTFILES" "$TYPE";
done
else
    echo "Trashcan Directory is Empty"
fi

}

recover () {
  echo "Please specify the file you would like to recover"
  read name
  if [ -f ~/.trashCan/$name ]; then
     mv ~/.trashCan/$name .
     echo "File $name has been recovered"
     echo "File $(basename $name ) has been recovered from the TrashCan" >> ~/.trashCan/.monitorText
     else
     echo "File $name was not found"
     fi
}
recover2 () {
if [ -f ~/.trashCan/$OPTARG ]; then
     mv ~/.trashCan/$OPTARG .
     echo "File $OPTARG has been recovered"
     echo "File $(basename $OPTARG ) has been recovered from the TrashCan" >> ~/.trashCan/.monitorText
     else
     echo "File $OPTARG was not found"
     fi
}

remove () {
  for filename in $DIR/*; do
    echo "do you wish to delete this file : $(basename $filename )";
    read yn;
    case $yn in
        [Yy]* ) rm $filename; 
                echo "The following file has been deleted $(basename $filename )" >> ~/.trashCan/.monitorText;
                echo "The following file has been deleted $(basename $filename )";;
        [Nn]* ) echo "";;
        * ) echo "Please answer yes or no.";;
    esac
done

}

total () {
  echo "TrashCan size"
  echo "-------------"
 du -sb $DIR

}

monitor () {
xfce4-terminal -e ./monitor.sh &
echo "Process monitor.sh has been initiated"
  echo "Process monitor.sh has been initiated" >> ~/.trashCan/.monitorText;
}

monitor_kill () {
  pkill monitor.sh;
  echo "Process monitor.sh has been terminated"
  echo "Process monitor.sh has been terminated" >> ~/.trashCan/.monitorText;
  #pkill -n bash;
}
MainTrap () {
  SIZE=$(du -s $DIR | awk '{print $1}');
  
  cd $DIR
  funct=$(ls -l | grep ^- | wc -l)
  echo ""
  echo "|------------------------------------------------|"
  printf "| Number of regular files:$funct                      | \n" ;
  echo "|------------------------------------------------|"
  if [ "$SIZE" -gt 1 ]; then 
  echo "| WARNING ---- Directory size is larger than 1kb |"
  echo "|------------------------------------------------|"
  fi
  exit 0;
}

trap MainTrap EXIT SIGINT SIGTERM

while getopts :lr:dtmk args #options
do
  case $args in
     l) lit;;
     r) recover2;;
     d) remove;; 
     t) total;; 
     m) monitor;; 
     k) monitor_kill;;     
     :) echo "data missing, option -$OPTARG";;
    \?) echo "$USAGE";;
  esac
done

((pos = OPTIND - 1))
shift $pos

PS3='option> '

if (( $# == 0 ))
then if (( $OPTIND == 1 )) 
 then select menu_list in list recover delete total monitor kill exit
      do case $menu_list in
         "list") lit;;
         "recover") recover;;
         "delete") remove;;
         "total") total;;
         "monitor") monitor;;
         "kill") monitor_kill;;
         "exit") exit 0;;
         *) echo "unknown option";;
         esac
      done
 fi
else safeDel "$@";
fi