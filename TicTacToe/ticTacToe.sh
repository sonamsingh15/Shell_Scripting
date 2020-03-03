#!/bin/bash -x

echo "WELCOME TICTACTOE GAME"

declare -a board

board=(1 2 3 4 5 6 7 8 9)
count=0
turn=" "

function displayBoard(){

	echo "  ${board[0]}   | ${board[1]}  | ${board[2]} "
	echo "  ____|____|____"
	echo "  ${board[3]}   | ${board[4]}  | ${board[5]}  "
	echo "  ____|____|____"
	echo "  ${board[6]}   | ${board[7]}  | ${board[8]}  "
	echo "      |    |    "
}

displayBoard

function assignedSymbol(){

	if [[ $((RANDOM%2)) -eq 0 ]]
	then
	   	echo "user play"
	    	echo "user symbol is =X"
	    	turn="user"
	else
	   	echo "computer play "
	    	echo "computer symbol is =O"
	    	turn="computer"
		fi
}

assignedSymbol

function checkRowForWin(){

	for (( i=0; i<9; i=(($i+3 )) ))
	do
		if [[ ${board[$i]} == ${board[(($i+1))]} ]] && [[ ${board[(($i+1))]} == ${board[(($i+2))]} ]]
		then
			echo "win"
		exit
		fi
	done
}

function checkColumnForWin(){

	for (( i=0 ; i<=2 ; i++ ))
	do
		if [[ ${board[$i]} == ${board[(($i+3))]} ]] &&  [[ ${board[(($i+3))]} == ${board[(($i+6))]} ]]
		then
			echo "win"
		exit
		fi
	done
}

function checkDiagonalForWin(){

	i=0
	if [[ ${board[$i]} == ${board[(($i+4))]} ]] && [[ ${board[(($i+4))]} == ${board[(($i+8))]} ]]
	then
		echo "win"
		exit

	elif [[ ${board[$i+2]} ==  ${board[(($i+4))]} ]] && [[ ${board[(($i+4))]} == ${board[(($i+6))]} ]]
	then
		echo "win"
 		exit
	fi
}

function checkForWin(){

	checkColumnForWin
	checkRowForWin
	checkDiagonalForWin
}

function checkOpponentRow(){

	row=0
	for (( i=0; i<9; i=$(( $i + 3 )) ))
	do
		if [[ ${board[$i]} == ${board[(($i+1))]} ]]
		then
			row=1
			board[(($i+2))]=O
			turn="user"
			displayBoard
		elif [[ ${board[$i]} == ${board[(($i+2))]} ]]
		then
			row=1
			board[(($i+1))]=O
			turn="user"
			displayBoard
		elif [[ ${board[(($i+1))]} == ${board[(($i+2))]} ]]
		then
			row=1
			board[$i]=O
			turn="user"
			displayBoard
		fi
	done

}

function checkOpponentColumn(){

	column=0
	for (( i=0 ; i<=2 ; i++ ))
	do
		if [[ ${board[$i]} == ${board[(($i+3))]} ]]
		then
			board[(($i+6))]=O
			turn="user"
			column=1
			displayBoard
		elif [[ ${board[$i]} == ${board[(($i+6))]} ]]
		then
			board[(($i+3))]=O
			turn="user"
			column=1
			displayBoard
		elif [[ ${board[(($i+3))]} == ${board[(($i+6))]} ]]
		then
			turn="user"
			board[$i]=O
			column=1
			displayBoard
		fi
	done
}

function checkOpponentDiagonal(){

	diagonal=0
	i=0
	if [[ ${board[$i]} == ${board[(($i+4))]} ]]
	then
		board[(($i+8))]=O
		turn="user"
		diagonal=1
		displayBoard
	fi
	if [[ ${board[$i+8]} ==  ${board[(($i+4))]} ]]
	then
		board[(($i))]=O
		turn="user"
		diagonal=1
		displayBoard

	fi
	if [[ ${board[$i]} ==  ${board[(($i+8))]} ]]
	then
		board[(($i+4))]=O
		turn="user"
		diagonal=1
		displayBoard
	fi
	if [[ ${board[$i+2]} == ${board[(($i+4))]} ]]
	then
		board[(($i+6))]=O
		turn="user"
		diagonal=1
		displayBoard
	fi
	if [[ ${board[$i+4]} ==  ${board[(($i+6))]} ]]
	then
		board[(($i+2))]=O
		turn="user"
		diagonal=1
		displayBoard
	fi
	if [[ ${board[$i+2]} ==  ${board[(($i+6))]} ]] 
	then
		board[(($i+4))]=O
		turn="user"
		diagonal=1
		displayBoard
	fi
}

function checkCorner(){

	temp=0
	for (( i=0; i<9; i++ ))
	do
		if [[ ${board[$i]}%2 -eq 1  && ${board[$i]} != 5 ]]
		then
			if [[ ${board[$i]} != "X" && ${board[$i]} != "O" ]]
			then
				temp=1
				echo ${board[$i]}
			break
			fi
		fi
	done

	if [[ $temp -eq 0 ]]
	then
		centerValue=$(checkCenter)
		echo $centerValue
	fi
}

function checkCenter(){


	if [[ ${board[4]} != "X" || ${board[4]} != "O" ]]
	then
		echo ${board[4]}
	else
		sideValue=$(checkSide)
		echo $sideValue
	fi
}

function checkSide(){

	for (( i=0; i<9; i++ ))
	do
		if [[ ${board[$i]}%2 -eq 0 ]]
		then
			if [[ ${board[$i]} != "X" && ${board[$i]} != "O" ]]
			then
				echo ${board[$i]}
			break
			fi
		fi
	done
}

function  playerTurn(){

	echo "user turn"
	read -p "ENTER THE CELL NUMBER:" cellNumber
	if [[ ${board[(( $cellNumber-1 ))]} -eq $(( $cellNumber )) ]]
	then

		board[$(($cellNumber-1))]="X"
		count=$(($count+1 ))
		displayBoard
		turn="computer"
	fi
}

function  computerTurn(){

	checkOpponentRow
	if [ $row -eq 0 ]
	then
		checkOpponentColumn
	fi
	if [[ $row -eq 0 || $column -eq 0 ]]
	then
		checkOpponentDiagonal
	fi
	if [[ $row -eq 0 || $column -eq 0 || $diagonal -eq 0 ]]
	then
		cellNumber=$(checkCorner)
		if [[ ${board[(( $cellNumber-1 ))]} -eq $cellNumber ]]
		then
			board[$(($cellNumber-1))]="O"
			count=$(($count+1 ))
			echo "computer turn"
			displayBoard
			turn="user"
		fi
	fi
}

function playGame(){

	while [[ $count -ne 9 ]]
	do
		if [[ $turn == "user" ]]
		then
			playerTurn

		elif [[ $turn == "computer" ]]
		then
			computerTurn
		fi
			checkForWin
	done

	if [[ $count -gt 9 ]]
	then
		echo "game tie"
	fi
}
playGame
