#!/bin/bash
# Tic-tac-toe: you (X) against the computer (O)

board=(" " " " " " " " " " " " " " " " " ")

wins=(
    "0 1 2" "3 4 5" "6 7 8"
    "0 3 6" "1 4 7" "2 5 8"
    "0 4 8" "2 4 6"
)

draw_board() {
    echo
    echo " ${board[0]} | ${board[1]} | ${board[2]}      1 | 2 | 3"
    echo "---+---+---     ---+---+---"
    echo " ${board[3]} | ${board[4]} | ${board[5]}      4 | 5 | 6"
    echo "---+---+---     ---+---+---"
    echo " ${board[6]} | ${board[7]} | ${board[8]}      7 | 8 | 9"
    echo 
}

winner() {
    local line a b c 
    for line in "${wins[@]}"; do 
        read -r a b c <<< "$line"
        if [ "${board[a]}" != " " ] && [ "${board[a]}" = "${board[b]}" ] && [ "${board[b]}" = "${board[c]}" ]; then 
            echo "${board[a]}"
            return 0
        fi 
    done 
    return 1
}

board_full() {
    local cell
    for cell in "${board[@]}"; do 
        [ "$cell" = " " ] && return 1 
    done 
    return 0 
}

player_move() {
    local choice
    while true; do 
        read -r -p "Your move (1-9): " choice
        if [[ "$choice" =~ ^[1-9]$ ]] && [ "${board[choice-1]}" = " " ]; then 
            board[choice-1]="X"
            return 
        fi 
        echo "Invalid or already taken. Try again."
    done 
}

find_move() {
    local test_mark="$1" place_mark="$2" i 
    for i in {0..8}; do 
        if [ "${board[i]}" = " " ]; then 
            board[i]="$test_mark"
            if winner > /dev/null; then 
                board[i]="$place_mark"
                return 0
            fi 
            board[i]=" "
        fi 
    done 
    return 1
}

computer_move() {
    find_move "O" "O" && return 
    find_move "X" "O" && return 

    if [ "${board[4]}" = " " ]; then 
        board[4]="O"
        return
    fi 

    local i
    while true; do
        i=$((RANDOM % 9))
        if [ "${board[i]}" = " " ]; then 
            board[i]="O"
            return 
        fi 
    done 
}

echo "Tic-Tac-Toe: you are X, the computer is O."
draw_board

while true; do 
    player_move
    draw_board
    if winner > /dev/null; then echo "You win!"; break; fi 
    if board_full; then echo "It's a draw."; break; fi 

    echo "Computer is thinking..."
    sleep 1
    computer_move
    draw_board
    if winner > /dev/null; then echo "Computer wins!"; break; fi 
    if board_full; then echo "It's a draw."; break; fi 
done 
bash tictactoe.sh
