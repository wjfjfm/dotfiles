# Shell Timer
function roundseconds (){
  # rounds a number to 3 decimal places
  # echo "m=${1};scale=3;m/1" | bc
  printf "%.6g" $(bc <<< "m=${1};m*1000")
}

function bash_getstarttime (){
  # places the epoch time in ns into shared memory
  gdate +%s.%N >"/Volumes/RAMDisk/${USER}.bashtime.${1}"
}

function bash_getstoptime (){
  # reads stored epoch time and subtracts from current
  local endtime=$(gdate +%s.%N)
  local starttime=$(cat /Volumes/RAMDisk/${USER}.bashtime.${1})
  roundseconds $(echo $(eval echo "$endtime - $starttime") | bc)
}

ROOTPID=$$
bash_getstarttime $ROOTPID

function runonexit (){
  rm /dev/shm/${USER}.bashtime.${ROOTPID}
}
trap runonexit EXIT

PS0='$(bash_getstarttime $ROOTPID)'
PS_time='$(bash_getstoptime $ROOTPID)ms '

PS1="\u@\h \W> "
PS1="$PS_time""$PS1"

