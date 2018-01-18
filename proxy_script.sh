#!/bin/bash

usage()
{
	echo "Usage: $0 [-h] [-S] [-s start_address end_address] [-f destination_filename] [-p \"space seperated list of ports\"]"
	echo 
	echo "	-h, --help		display help"
	echo "	-s, --subnet 		start and end ip addresses"
	echo "	-p, --ports		space seperated list of ports"
	echo "	-f, --filename 		destination file to store proxies"
	echo "	-S, --silent		supress output"

	exit 1
}

TIMEOUT=0.015
EXPECTED_OUTPUT="Google is built by a large team of engineers, designers, researchers, robots, and others in many different sites across the globe. It is updated continuously, and built with more tools and technologies than we can shake a stick at. If you'd like to help us out, see google.com/careers."

start_address=172.16.0.1
end_address=172.16.127.255
filename=~/proxylist.txt
ports="8080 3128 808"
silent=0

while [[ "$1" != "" ]]; do
	case $1 in
		-f | --file   	)				shift
								filename=$1
								;;
		-s | --subnet	)				shift
								start_address=$1
								shift
								end_address=$1
								;;
		-p | --ports	)				shift
								ports=$1
								;;
		-h | --help	)         			usage
								exit
								;;
		-S | --silent	)				silent=1
								;;
		*		)				exit 1
	esac
	shift
done

if [ -f $filename ]
then
	> $filename
fi

REGEX='^[1-9][0-9]{,2}[.]([0-9]{1,3}[.]){2}[0-9]{1,3}$'
BEGIN=$start_address
END=$end_address

if ! [[ $BEGIN =~ $REGEX && $END =~ $REGEX ]]
then
    usage
elif [[ ${BEGIN%[0-9]*} == ${END%[0-9]*} ]]
then
    SUBNET=${BEGIN%[.][0-9]*}
    START=${BEGIN##*.}
    STOP=${END##*.}

    while (( START <= STOP ))
	do
	    if [[ $silent -eq 0 ]]; then
	    	echo "Testing -> $SUBNET.$START"
	    fi
	    for PORT in $ports
			do
				if [[ "$(http_proxy=$SUBNET.$START:$PORT curl -s --connect-timeout $TIMEOUT www.google.com/humans.txt)" == "$EXPECTED_OUTPUT" ]]
				then
					echo "$SUBNET.$START:$PORT" >> $filename
					if [[ $silent -eq 0 ]]; then
						echo "$SUBNET.$START:$PORT"
					fi
				fi  &
			done
	    ((START++))
	done

elif [[ ${BEGIN%[.][0-9]*[.][0-9]*} == ${END%[.][0-9]*[.][0-9]*} ]]
then
	TEMP=${BEGIN%[.][0-9]*}
	START1=${TEMP##*.}
	TEMP=${END%[.][0-9]*}
	STOP1=${TEMP##*.}
	SUBNET=${BEGIN%[.][0-9]*[.][0-9]*}
	START2=${BEGIN##*.}
	STOP2=${END##*.}


	TEMP1=$START1
	while (( TEMP1 <= STOP1 ))
	do
		if (( TEMP1 == START1 ))
		then
			TEMP2_ST=$START2
			TEMP2_EN=255
		elif (( TEMP1 == STOP1 ))
		then
			TEMP2_ST=0
			TEMP2_EN=$STOP2
		else
			TEMP2_ST=0
			TEMP2_EN=255
		fi

		TEMP2=$TEMP2_ST
		while (( TEMP2 <= TEMP2_EN ))
		do
			if [[ $silent -eq 0 ]]; then
	    			echo "Testing -> $SUBNET.$TEMP1.$TEMP2"
			fi
			for PORT in $ports
			do
				if [[ "$(http_proxy=$SUBNET.$TEMP1.$TEMP2:$PORT curl -s --connect-timeout $TIMEOUT www.google.com/humans.txt)" == "$EXPECTED_OUTPUT" ]]
				then
					echo "$SUBNET.$TEMP1.$TEMP2:$PORT" >> $filename
					if [[ $silent -eq 0 ]]; then
			    			echo "$SUBNET.$TEMP1.$TEMP2:$PORT"
					fi
				fi  &
			done
			((TEMP2++))
		done
		((TEMP1++))
	done


else
    echo "First two octets must match when entering range!!"
    exit 2
fi

echo "Working Proxies:-"
cat $filename