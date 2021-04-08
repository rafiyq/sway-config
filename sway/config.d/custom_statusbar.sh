#!/bin/sh

net() {
	  if=wlp3s0
    ssid=$(iwconfig $if | sed -e 's/"/ /g' |\
    awk '/ESSID/{print$5}')
	  ip=$(ip route get 8.8.8.8 2>/dev/null |\
	  if [ -n $ssid ]; then
        signal=$(iwconfig $if | sed -e 's/\// /g;s/=/ /g' |\
        awk '/Quality/{printf("%.0f\n", $3*100/$4)}')
        printf "%s(%d%%)" "${ssid}" "${signal}"
    elif [ -n $ip ]; then
        grep -Eo 'src [0-9.]+'|grep -Eo '[0-9.]+')
	      printf "ip:%s" "${ip}"
	  else
	      printf "disconnected"
	  fi
}

temp() {
	  test -f /sys/class/thermal/thermal_zone0/temp || return 0
	  head -c 2 /sys/class/thermal/thermal_zone0/temp
}

bat() {
	  hash acpi || return 0
	  onl="$(acpi -V | ag on-line)"
	  charge="$(awk '{ sum += $1 } END { print sum }' /sys/class/power_supply/BAT*/capacity)"
	  if test -z "$onl"
	  then
		    printf "%s" "bat:${charge}%"
	  else
		    printf "%s" "char:${charge}%"
	  fi
}

mem() {
    awk '/Mem/{print$2}' /proc/meminfo |\
    awk 'BEGIN {RS = "";FS = "\n"} ; {printf("%.0f\n", 100-$3*100/$1)}'
}


formated_date() {
    date "+%a-%d-%b %R"
}

print_status() {
    printf "ram:%d%%  temp:%dC  %s  %s  %s\n" "$(mem)" "$(temp)" "$(net)" "$(bat)" "$(formated_date)"
}

while true; do print_status; sleep 5; done
