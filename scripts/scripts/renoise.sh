#!/bin/sh
# https://forum.renoise.com/index.php/topic/41843-linux-howto-pulseaudio-jack-server/

jack_control start			    # start jackdbus

jack_control eps realtime true	# enable realtime privilidges for it

jack_control ds alsa			# select driver
jack_control dps device hw:0    # select alsa device

jack_control dps rate 48000		# set sample rate
jack_control dps nperiods 3		# set number of periods
jack_control dps period 512		# set period size

/home/curious/Downloads/Renoise_3_1_0_Demo_x86_64/renoise $1	# start renoise
#renoise $1				# you don't need the path if renoise is installed system wide

jack_control exit			# stop jackdbus after you exit renoise

killall jackd				# in case renoise starts legacy jackd
