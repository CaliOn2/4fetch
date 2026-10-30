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

while getopts 'vlhb:' option; do
  case $option in
    v)
      verbose=true
      ;;
    l)
      loop=true
      ;;
    h)
      echo "Usage:"
      echo " -v (verbose) to get thread and board data"
      echo " -l to make the program loop indefinitely"
      echo " -b to limit comments to a single board"
      echo "BOARDS:"
      echo "${boards[@]}"
      exit 1
      ;;
    b) 
      boards=($OPTARG)
      ;;
    *)
      echo "unrecognised argument"
      exit 1
      ;;
  esac
done


while $loop
do
  boardcomment

  if $verbose
  then
    echo "BOARD:$board"
    echo -e "THREAD:$thread\n"
  fi

  echo -e $cleancomment

  sleep 8

  echo -e "\n"

  printf %${COLUMNS}s |tr " " "-"

  echo -e ""
done

boardcomment

if $verbose
then
  echo "BOARD:$board"
  echo -e "THREAD:$thread\n"
fi

echo -e $cleancomment
