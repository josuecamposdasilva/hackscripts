#!/bin/bash

if [ "$1" == "" ] ; then exit ; fi

convert() { string="$( echo "a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z" | cut -d"$1" -f1 | tr " " "\n" | wc -l )" ; echo $string ; }

ranl() { alfab="$( echo "a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z" | cut -d" " -f$(( ( $RANDOM%51 )+1 )) )" ; echo $alfab ; }

ent=$1

echo
echo "Received argument: $ent"
echo

p1="$( echo "$ent" | tr "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" "zyxwvutsrqponmlkjihgfedcbaZYXWVUTSRQPONMLKJIHGFEDCBA" )"

echo "Step 01: $p1"

echo

p2="$( echo $p1 | tr " " ":" )"

echo "Step 02: $p2"

echo

p3="$( echo $p2 | tr "\n" "@" )"

echo "Step 03: $p3"

echo

p4="$( numl="$( echo "$p3" | wc -c )" ; a=1 ; for a in $( while [ $a -lt $numl ] ; do echo "$a" && a=$(( $a+1 )); done ); do fcrypt="$( echo "$p3" | cut -b $a )" ; isl="$( echo $fcrypt | grep "[ a-zA-Z ]" )" ; if [ "$isl" != "" ] ; then convert $fcrypt ; else echo $fcrypt ; fi ; done | tr "\n" " " )"

echo "Step 04: $p4"

echo

p5="$( for a in $p4; do isn="$( echo $a | grep "[ 1-9 ]" )" ; if [ "$isn" != "" ] ; then let count++ ; echo -n "$(( $count*$a ))$( ranl )" ; else echo "$a$( ranl )" ; fi ; done | tr "\n" " " )"

echo "Step 05: $p5"

echo

p6="$( varcon="$(( $( echo $p5 | tr ":" "\n" | wc -l )+1 ))" ; a=1 ; cryl="$( for a in $( while [ $a -lt $varcon ] ; do echo "$a" && a=$(( $a+1 )) ; done ) ; do echo "$p5" | cut -d":" -f$a | tr " " "$( ranl )" ; done )" ; echo "$cryl" | tr "\n" ":" )"

echo "Step 06: $p6"

echo

exit
