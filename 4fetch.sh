#!/bin/sh

# relies on bash



boards=($(curl -s https://a.4cdn.org/boards.json | awk -f boards.awk))

boardcomment () {

  

  while [ ${#threads[@]} -lt "3" ] 
  do
    board=${boards[$RANDOM % ${#boards[@]}]}

    local threads=($(curl -s https://a.4cdn.org/$board/threads.json | awk -f threads.awk))
  done

  while [ ${#comments[@]} -lt "1" ]
  do
    thread=${threads[$RANDOM % ${#threads[@]}]}

    oldIFS=$IFS
    IFS="'"

    local comments=($(curl -s https://a.4cdn.org/$board/thread/$thread.json | awk -f comments.awk))

    IFS=$oldIFS
  done

  local comment=${comments[$RANDOM % ${#comments[@]}]}

  cleancomment=$(echo $comment | sed -f filter.sed)
  
}

loop=false

verbose=false

while getopts 'vlh:' option; do
  case $option in
    v)
      verbose=true
      ;;
    l)
      loop=true
      ;;
    h)
      echo "Usage: -v (verbose) to get thread and board data, use -l to make the program loop indefinitely"
      exit 1
      ;;
    *)
      echo "unrecognised argument"
      exit 1
      ;;
  esac
done

boardcomment

while $loop
do
  if $verbose
  then
    echo "BOARD:$board"
    echo -e "THREAD:$thread\n"
  fi

  echo -e $cleancomment

  sleep 8  

  boardcomment

  echo -e "\n\n"
done

if $verbose
then
  echo "BOARD:$board"
  echo -e "THREAD:$thread\n"
fi

echo -e $cleancomment
