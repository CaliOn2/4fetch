#!/bin/bash

boards=($(curl -s https://a.4cdn.org/boards.json | awk -f boards.awk))

board=${boards[$RANDOM % ${#boards[@]}]}

threads=($(curl -s https://a.4cdn.org/$board/threads.json | awk -f threads.awk))

thread=${threads[$RANDOM % ${#threads[@]}]}

oldIFS=$IFS
IFS="'"

comments=($(curl -s https://a.4cdn.org/$board/thread/$thread.json | awk -f comments.awk))

IFS=$oldIFS

comment=${comments[$RANDOM % ${#comments[@]}]}

cleancomment=$(echo $comment | sed -f filter.sed)

echo "BOARD:$board"
echo -e "THREAD:$thread\n"

echo -e $cleancomment

