#! /bin/bash
USAGE="usage: $0 <fill in correct usage>" 

mkdir ~/.trashCan

while getopts :lr:dtmk args #options
do
  case $args in
     l) ls;;
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
         "list") ls -l;;
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


