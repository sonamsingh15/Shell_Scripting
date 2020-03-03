#!/bin/bash -x
echo "ENTER THREE INPUT"
read -p "enter the value..>" a
read -p "enter the value..>" b
read -p "enter the value..>" c

declare -A result

compute0=$(( $a + $b * $c))
compute1=$(( $a * $b + $c ))
compute2=$(( $c + $a / $b ))
compute3=$(( $a % $b + $c ))

result["compute0"]=$compute0
result["compute1"]=$compute1
result["compute2"]=$compute2
result["compute3"]=$compute3


for (( i=0 ; i<4; i++))
do
        resultArr[$i]="${result[compute$i]}"
done
echo ${result[@]}

echo "asscending array"
for asc in ${!resultArr[@]}
do
        echo ${resultArr[$asc]}
done | sort -n

echo "decending  array"
for dec in ${!resultArr[@]}
do
	echo ${resultArr[$dec]}

done | sort -nr
