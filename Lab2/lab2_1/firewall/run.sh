#!/bin/bash

# Note: Mininet must be run as root.  So invoke this shell script
# using sudo.

echo "Copying Firewall to Pox"
cp firewall.py ~/pox/pox/forwarding/

for((i = 1; i<9; i++)); do
	# Run Test
	echo "Test $i: $i block(s)"
	echo "Copying file into correct location and renaming to firewall-policies"
	rm firewall-policies.csv
	cp "testfiles/firewall-policies-$i.csv" ./firewall-policies.csv
	
	sleep 1
	# Need to start the controller in new terminal window to avoid blocking tests
	echo "Starting Firewall"
	gnome-terminal -- bash -c "~/pox/pox.py forwarding.firewall; exec bash"
	sleep 5 # wait for controller to start
	
	echo "Starting Topo"
	sudo python sdn.py
	
	echo "Stop Firewall"
	controller_pid=$(pgrep -f firewall)
	sudo kill $controller_pid
done

