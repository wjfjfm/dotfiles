color_prompt=yes

# check if RAMDisk exist in this system
[ ! -d "/Volumes/RAMDisk" ] && diskutil erasevolume HFS+ "RAMDisk" $(hdiutil attach -nomount ram://$((2 * 1024 * 10)))

# Shell Timer
function roundseconds (){
  local FS=$1
  local NS=$((FS/1000))
  local MS=$((NS/1000))
  local S=$((MS/1000))
  local D=$((S/60/60/24))
  local H=$((S/60/60%24))
  local M=$((S/60%60))
  local S=$((S%60))
  local MS=$((MS%1000))
  (( $D > 0 )) && printf '%dd' $D
  (( $H > 0 )) && printf '%dh' $H
  (( $M > 0 )) && printf '%dm' $M
  if (( $D == 0 && $H == 0 && $S > 0 )); then printf "%d" $S
    if (( $S < 10 ));then printf ".%2ds" $(($MS/10))
    elif (( $S < 100));then printf ".%1ds" $(($MS/100))
    else printf "s"
    fi
  fi
  (( $D == 0 && $H == 0 && $M == 0 && $S == 0 )) && printf "%3dms" $MS
}

function bash_getstarttime (){
  # places the epoch time in ns into shared memory
  gdate +%s%N >"/Volumes/RAMDisk/${USER}.bashtime.${1}"
}

function bash_getstoptime (){
  # reads stored epoch time and subtracts from current
  local endtime=$(gdate +%s%N)
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
PS_time='\e[0;33m$(bash_getstoptime $ROOTPID)\e[m '

PS1="\u@\h \W> "
PS1="$PS_time""$PS1"

