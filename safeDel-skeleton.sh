#! /bin/bash
USAGE="usage: $0 <fill in correct usage>" 
DIR=~/.trashCan
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

while getopts :lr:dtmk args #options
do
  case $args in
     l) lit;;
     r) echo "r option; data: $OPTARG";;
     d) echo "d option";; 
     t) echo "t option";; 
     w) echo "m option";; 
     k) echo "k option";;     
     :) echo "data missing, option -$OPTARG";;
    \?) echo "$USAGE";;
  esac
done

((pos = OPTIND - 1))
shift $pos

PS3='option> '

if (( $# == 0 ))
then if (( $OPTIND == 1 )) 
 then select menu_list in list recover delete total watch kill exit
      do case $menu_list in
         "list") lit;;
         "recover") echo "r";;
         "delete") echo "d";;
         "total") echo "t";;
         "monitor") echo "w";;
         "kill") echo "k";;
         "exit") exit 0;;
         *) echo "unknown option";;
         esac
      done
 fi
else echo "extra args??: $@"
fi


