#!/bin/bash

if [ "$1" == "" ] ; then exit ; fi

deconvert() { string="$( echo "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" | cut -b $1 )" ; echo $string ; }

ent=$1

echo
echo "Received argument: $ent"
echo

p1="$( echo "$ent" | tr "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" " " )"

echo "Step 01: $p1"

echo

p2="$( for a in $p1; do isn="$( echo $a | grep "[ 1-9 ]" )" ; if [ "$isn" != "" ] ; then let count++ ; echo "$(( $a/$count ))" ; else echo "$a " ; fi ; done | tr "\n" " " )"

echo "Step 02: $p2"

echo

p3="$( numl="$( echo "$p2" | wc -c )" ; a=1 ; for a in $( while [ $a -lt $numl ] ; do echo "$a" && a=$(( $a+1 )); done ); do fdecry="$( echo "$p2" | cut -d" " -f$a )" ; isnum="$( echo $fdecry | grep "[ 1-9 ]" )" ; if [ "$isnum" != "" ] ; then deconvert $fdecry ; else echo $fdecry ; fi ; done | tr -d "\n" )"

echo "Step 03: $p3"

echo

p4="$( echo "$p3" | tr "zyxwvutsrqponmlkjihgfedcbaZYXWVUTSRQPONMLKJIHGFEDCBA" "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" )"

echo "Step 04: $p4"

echo

p5="$( echo $p4 | tr ":" " " | tr "@" "\n" )"

echo "Step 05: $p5"

echo

exit
