#!/bin/bash
# MetalScreen - because I said so
# Andrew Glenn
# andrew@andrewglenn.net

# Define the config
config_file="/tmp/metalscreen.config"

if [ ! -f $config_file ]; then
	echo "config file not found, exiting!"
	exit 0
fi
# Source the config
source $config_file
does_exist() {
	# Checking to see if the screen exists. if not, create it!
	# I'm also adding in a couple of variables to make sure things work later.
	screen_status=$(screen -list | grep $screen_name )
	if [ -z "$screen_status" ]; then
		echo "Screen needs to be created! Doing so now!"
		screen -Sdm $screen_name
	fi
}

magic_happens_here(){
	number_of_windows=$(($number_of_windows - 1))		
	for window in $(seq 0 $number_of_windows); do 
	screen -XS $screen_name -p $window title ${ms[wt$window]}
		# The newline here is VERY IMPORTANT, leave it!
#	screen -XS $screen_name -p $window stuff "${ms[wc$window]}
#"
	done
}

does_exist
magic_happens_here
