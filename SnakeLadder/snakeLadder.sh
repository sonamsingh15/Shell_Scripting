#!/bin/bash -x
echo "WELCOME TO SNAKE AND LADDER GAME"

#constant
START_POSITION=0
WINNING_POSITION=100


#variable
position=0
noPlay=0
snake=1
ladder=2
count=0
player1=0
player2=0
flag=0

function playSnakeLadderGame(){

		position=$1
		dieroll=$((RANDOM%6+1))
		checkForMove=$((RANDOM%3))
		case $checkForMove in
			$noPlay)
				postion=$START_POSITION
				;;
			$ladder)
				position=$(($position + $dieroll))
				if [[ $position -gt $WINNING_POSITION ]]
                                then
                                      position=$(($position-$dieroll))
                                fi
				;;
			$snake)
				position=$(($position - $dieroll))
				if [[ $position -lt $START_POSITION ]]
                		then
					position=$START_POSITION
                		fi
				;;

		esac
		echo $position

}

function getWinningPlayer(){

	while [[ $player1 -lt $WINNING_POSITION && $player2 -lt $WINNING_POSITION ]]
	do
        	if [ $flag -eq 0 ]
        	then
        		player1=$(playSnakeLadderGame $player1)
        		flag=1
        		echo "Player1 position : "$player1
                	if [ $player1 -eq $WINNING_POSITION ]
                	then
                        	echo "Position : "$player1
                        	echo "Player1 win"
                        break;
                	fi
        		elif [ $flag -eq 1 ]
        		then
        			flag=0
        			player2=$(playSnakeLadderGame $player2)
        			echo "Player2 position : "$player2
                	if [ $player2 -eq $WINNING_POSITION ]
               		then
                        	echo "Position : "$player2
                        	echo "Player2 win !!"
                        break;
                	fi
        	fi
		count=$(( $count+1 ))

	done
	echo $count
}

getWinningPlayer


