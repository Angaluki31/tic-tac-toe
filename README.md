# Tic-Tac-Toe 

A terminal Tic-Tac-Toe game written in Bash. You play X against a computer opponent that wins when it can, blocks your winning moves, and otherwise takes the center or a random square.

## Play 

```bash
bash tictactoe.sh
```

Enter a number from 1 to 9 to place your mark:

```
 1 | 2 | 3
---+---+---
 4 | 5 | 6
---+---+---
 7 | 8 | 9
```

## How the computer plays

1. Take a winning move if one exists
2. Block your winning move
3. Take the center
4. Pick a random free square

## Requirements

Bash (Git Bash on Windows) 