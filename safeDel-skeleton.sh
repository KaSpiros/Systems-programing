#! /bin/bash
USAGE="usage: $0 <Please select one of the following options>" 
DIR=~/.trashCan;
mkdir ~/.trashCan;
clear;

lit () {
for filename in $DIR/*; do
  LISTFILES=$(wc -c < $filename)
  FILE=$(basename $filename)
  TYPE=$(file -b $filename)
printf  "File: %s\t Size: %s\tType: %s\t \n" "$FILE" "$LISTFILES" "$TYPE";
done
}

recover () {
  echo "Please specify the file you would like to recover"
  read name
  if [ -f ~/.trashCan/$name ]; then
     mv ~/.trashCan/$name .
     echo "File $name has been recovered"
     else
     echo "File $name was not found"
     fi
}
recover2 () {
if [ -f ~/.trashCan/$OPTARG ]; then
     mv ~/.trashCan/$OPTARG .
     echo "File $OPTARG has been recovered"
     else
     echo "File $OPTARG was not found"
     fi
}

remove () {
rm -i $DIR/*
}

total () {
  echo "TrashCan size"
  echo "-------------"
 du -hc $DIR
}



while getopts :lr:dtmk args #options
do
  case $args in
     l) lit;;
     r) recover2;;
     d) remove;; 
     t) total;; 
     w) echo "m option";; 
     k) echo "k option";;     
     :) echo "data missing, option -$OPTARG";;
    \?) echo "$USAGE";;
  esac
done

echo "Following Script was created by:"
echo "Spyridon Kalogeropoulos";
echo "S1632672";
sleep 4;
clear;

((pos = OPTIND - 1))
shift $pos

PS3='option> '

if (( $# == 0 ))
then if (( $OPTIND == 1 )) 
 then select menu_list in list recover delete total watch kill exit
      do case $menu_list in
         "list") lit;;
         "recover") recover;;
         "delete") remove;;
         "total") total;;
         "monitor") echo "w";;
         "kill") echo "k";;
         "exit") exit 0;;
         *) echo "unknown option";;
         esac
      done
 fi
else echo "extra args??: $@"
fi


