#!/bin/bash -x
echo "Welcome to Employee Wage comutation program"

#constant variable
WAGE_PER_HOUR=20
WORKING_DAY_PER_MONTH=20
TOTAL_WORKING_HOURS=100

#local variable
isFullDay=0
isHalfDay=1
isAbsent=2
dailyHours=0
totalHours=0
totalWage=0
count=0

declare -A storeEmpWage

function GetWorkHour(){

workingHours=$1

	case $1 in
		$isFullDay)
			empHrs=8;;

		$isHalfDay)
			empHrs=4;;
		$isAbsent)
			empHrs=0;;
	esac
	echo $empHrs
}

function main(){

while [[ $totalHours -lt $TOTAL_WORKING_HOURS && $count -lt $WORKING_DAY_PER_MONTH ]]
do
	workingHours=$((RANDOM%3))
	dailyHours="$( GetWorkHour $workingHours )"
	dailyWage=$(( $dailyHours * $WAGE_PER_HOUR))
	totalWage=$(( $totalWage + $dailyWage ))
	dailyWageArr[((count++))]=$dailyWage
	storeEmpWage[$count]="$dailyWage	$totalWage"
	echo "Employee Hrs" $totalHours
	totalHours=$(($totalHours + $dailyHours))
done

for (( i=1 ;i<$count+1 ;i++))
do
	echo "$i	${storeEmpWage[$i]}"
done
}

main
