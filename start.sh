#!/bin/bash
# Container entry script

# Capture terminate signals and stop strongswan cleanly before exiting
on_term() {
	start=0
	ipsec stop
	exit
}
trap on_term SIGTERM SIGINT

# Start each config in the config directory, then watch and
# restart each config on disconnect or failure.
configs="$(ls /etc/swanctl/conf.d | sed s/"\.conf$"/""/g)"
start=1
pid=
while [ $start = 1 ]; do
	kill -0 $pid
	if [ $? -ne 0 ]; then
		ipsec stop >/dev/null 2>&1
		# Use stdbuf so output of background ipsec process is printed to stdout and flushed line by line
		stdbuf -oL ipsec start --nofork &
		pid=$!
	fi
	sleep 5
	status="$(ipsec status 2>/dev/null)"
	for conf in $configs; do
		echo "$status" | grep -q "${conf}\[" || 
			(ipsec down "$conf" >/dev/null 2>&1; ipsec up "$conf" >/dev/null 2>&1 &)
	done
done

exit
