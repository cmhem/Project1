#!/bin/bash

#1st arg date month/date (four digits only)
#2nd arg time with AM/PM in quotations 

grep "$2" $1_Dealer_schedule | awk -F' ' '{print $1, $2, $5, $6}'
