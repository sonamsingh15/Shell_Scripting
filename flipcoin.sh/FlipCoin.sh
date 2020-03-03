#!/bin/bash -x
echo "WELCOM TO GAMBLING SIMULATOR "

#Constant
BET=1
STAKE=100
DAY_LOWER_LIMIT=$(( $STAKE /2 ))
DAY_UPPER_LIMIT=$(( $STAKE + $STAKE / 2))

#VARIABLE
day=20
cash=0
totalCash=0

declare -A dictionaryWinloss

function dailypay(){

	for ((day=1 ;day<=20; day++))
	do
		stake=$STAKE
		while (( $DAY_LOWER_LIMIT < $stake && $DAY_UPPER_LIMIT > $stake ))
		do
			random=$((RANDOM%2))
			if [[ $random -eq 0 ]]
			then
				((stake--))
			else
				((stake++))
			fi
		done
		cash=$(($stake - $STAKE))
		totalCash=$(($totalCash + $cash))
		dictionaryWinLoss[$day]="$cash	$totalCash"
		echo  "Day$day"     "${dictionaryWinLoss[$day]}"
	done
	echo "total win... $win"
	echo "total loss.. $loss"
}

function LuckiestDay(){

	echo "LuckiestDay..."
	for((day=1; day<=20; day++))
	do
	echo "Day$i" ${dictionaryWinLoss[$day]}
	done | sort -k3 -rn | head -1
}

function unLuckiestDay(){

	echo "UnluckiestDay.."
	for((day=1; day<=20; day++))
	do
        echo "Day$j" ${dictionaryWinLoss[$day]}
	done | sort -k3 -n | head -1
}

function Playnextmonth(){

	if [[ $totalcash -gt 0 ]]
	then
		echo " "
		echo "playcontinue......"
		main
	else
		echo "playNexttime.."
	fi
}
function main(){

        dailypay
        LuckiestDay
        unLuckiestDay
	Playnextmonth
}
main
