# Chess bot scripts

## What is this?

This repo contains lua scripts written for use with the fceux emulator
and the NES game The Chessmaster (1990).

There are also some notes I made while searching RAM for various bits
of info.

## Associated lichess bot

This is the bot account I use for Chessmaster to play. 

[Monroebot](https://lichess.org/@/Monroebot)

It is usually not accepting challenges since running it takes over my
computer!

## Main purpose

The main lua script is for using Chessmaster to makes moves for
a bot on lichess. It works with some other software I wrote called
[flexo](https://github.com/LinuxFan2718/flexo) and the official 
[lichess-bot](https://github.com/ShailChoksi/lichess-bot) software.

All together they turn this NES game from 1990 into a UCI-compatible 
chess engine capable of playing on lichess.

## Why turn an NES chess game from 1990 into a UCI engine

I wanted to see if I could.

## How to use

You must use a very recent stable version of fceux to run lua scripts.

First, start fceux, load Chessmaster, choose a difficulty level,
and start a game.

Load the lua script lichess-play.

You need flexo on your computer, but don't need to do anything
in the flexo directory.

Start [lichess-bot](https://github.com/ShailChoksi/lichess-bot).
You should have configured it to use flexo already.

Log onto lichess. 

- To play against your bot, log on using your human
account, visit the profile page for your bot, then challenge it.
At present you must play with the white pieces.

- If you log on as your bot, you can challenge Stockfish, or other
bots. Make sure to choose the black pieces if you are logged in as
your bot.

After every game, take control of Chessmaster, start a new game,
and restart the lua script.

## Issues I plan to fix

- Chessmaster should be able to play the white pieces.
- Both players can only promote pawns to queens.
- A new game should start automatically.

## Oddities that will remain

- Chessmaster ignores the game clock, which is partly offset by running at 32x speed

## The author

[twitter](https://twitter.com/DennisLibre)