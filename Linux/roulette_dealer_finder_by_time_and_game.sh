#!/bin/bash

#1st arg time including AM/PM
#2nd arg date day/time (four digits)
#3rd arg case 1 blackjack dealer
#	case 2 rouletter dealer
#	case 3  texas hold em dealer
#	any number <1 and >3  is invalid

case $3 in
	1 | 1) grep "$1" $2_Dealer_schedule | awk -F' ' '{print $1, $2, $3, $4}';;
	2 | 2) grep "$1" $2_Dealer_schedule | awk -F' ' '{print $1, $2, $5, $6}';;
	3 | 3) grep "$1" $2_Dealer_schedule | awk -F' ' '{print $1, $2, $7, $8}';;
	*) echo "Invalid game choice.";;
esac
