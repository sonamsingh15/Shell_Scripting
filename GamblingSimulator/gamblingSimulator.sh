#!/bin/bash -x
echo "WELCOME TO GAMBLING SIMULATOR "

#Constant
BET=1
STAKE=100
PERCENTAGE_OF_STAKE=$(( 50*$STAKE /100))
DAY_LOWER_LIMIT=$(( $STAKE - $PERCENTAGE_OF_STAKE ))
DAY_UPPER_LIMIT=$(( $STAKE + $PERCENTAGE_OF_STAKE ))
DAY=20

#VARIABLE
cash=0
totalCash=0


declare -A storeWinloss

function dailyPlay(){

        for ((day=1 ;day<=$DAY; day++))
        do
                stake=$STAKE

                while (( $DAY_LOWER_LIMIT < $stake && $DAY_UPPER_LIMIT > $stake ))
                do
                        if [[ $((RANDOM%2)) -eq 0 ]]
                        then
                                stake=$(($stake-$BET))
                        else
                                stake=$(( $stake+$BET))
                        fi
                done

                cash=$(($stake - $STAKE))
                totalCash=$(($totalCash + $cash))
                storeWinLoss[$day]="$cash  $totalCash"
                echo  "Day$day"     "${storeWinLoss[$day]}"
        done
}

function findLuckiestDay(){

        echo "Luckiest day in month..."
        for((day=1; day<=$DAY; day++))
        do
        echo "Day$day" ${storeWinLoss[$day]}
        done | sort -k3 -rn | head -1
}

function findUnLuckiestDay(){

        echo "Unluckiest day in month.."
        for((day=1; day<=$DAY; day++))
        do
        echo "Day$day" ${storeWinLoss[$day]}
        done | sort -k3 -n | head -1
}

function checkNextMonthForGambling(){

        if [[ $totalCash -gt 0 ]]
        then
                echo " "
                 main
        else
                echo "next time play......."
        fi
}
function main(){

        dailyPlay
        findLuckiestDay
        findUnLuckiestDay
        checkNextMonthForGambling
}
main



