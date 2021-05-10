# The Chessmaster (NES)

## Cursor

### Raw location to look for data
Data Size: 4 bytes

Data Type / Display: Signed

Addr range: 0500-050C

### Specific data
Data Size: 1 byte

Data Type: Unsigned

#### Vertical cursor movement
Addr: 0500, 0504 All identical

Addr: 0508 the same as 0500, 0504 but add 8 to value

| Ranks | Value |
| ----- | ----- |
| 1     | 196   |
| 2     | 172   |
| 3     | 150   |
| 4     | 124   |
| 5     | 102   |
| 6     | 78    |
| 7     | 54    |
| 8     | 28    |

#### Horizontal cursor movement
Addr: 0503, 0507, 050B

0503 == 050B

0507 is 0503 value + 8

| Files | Value |
| ----- | ----- |
| a     | 37    |
| b     | 61    |
| c     | 85    |
| d     | 109   |
| e     | 133   |
| f     | 157   |
| g     | 181   |
| h     | 207   |

### Candidates for move list

006100 (from move)

006220 (to move)

006320 (meta info such as piece type, maybe what pawn promoted to)

### A piece move is being animated

When a piece animation of moving is playing, the human
player cannot pick up a piece by pressing A, the game ignores
the A press.

0x0e2b is 0x00 when the player can press A

It has nonzero values when a piece is moving.

### Hyperlinks

[Getting started](https://www.romhacking.net/start/)
