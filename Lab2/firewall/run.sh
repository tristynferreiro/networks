#!/bin/bash

# Note: Mininet must be run as root.  So invoke this shell script
# using sudo.

echo "Copying Firewall to Pox"
cp firewall.py ~/pox/pox/forwarding/
# Need to start the controller in new terminal window to avoid blocking tests
echo "Starting Firewall"
gnome-terminal -- bash -c "~/pox/pox.py forwarding.firewall; exec bash"
sleep 5 # wait for controller to start
echo "Starting tests"

# Run Test 1
echo "Test 1: 4 blocks"
echo "Copying file into correct location and renaming to firewall-policies"
cp testfiles/firewall-policies-4.csv ./firewall-policies.csv
echo "Running test 4 blocks (original file)"
sudo python sdn.py

# Run Test 2
echo "Test 2: 1 block"
echo "Copying file into correct location and renaming to firewall-policies"
cp testfiles/firewall-policies-1.csv ./firewall-policies.csv
echo "Running test 1 block"
sudo python sdn.py

# Run Test 3
echo "Test 3: 2 blocks"
echo "Copying file into correct location and renaming to firewall-policies"
cp testfiles/firewall-policies-1.csv ./firewall-policies.csv
echo "Running test 2 blocks"
sudo python sdn.py

# Run Test 4
echo "Test 4: 3 blocks"
echo "Copying file into correct location and renaming to firewall-policies"
cp testfiles/firewall-policies-3.csv ./firewall-policies.csv
echo "Running test 3 blocks"
sudo python sdn.py

# Run Test 5
echo "Test 5: 5 blocks"
echo "Copying file into correct location and renaming to firewall-policies"
cp testfiles/firewall-policies-5.csv ./firewall-policies.csv
echo "Running test 5 blocks"
sudo python sdn.py

# Run Test 6
echo "Test 6: 6 blocks"
echo "Copying file into correct location and renaming to firewall-policies"
cp testfiles/firewall-policies-7.csv ./firewall-policies.csv
echo "Running test 6 blocks"
sudo python sdn.py

# Run Test 7
echo "Test 7: 7 blocks"
echo "Copying file into correct location and renaming to firewall-policies"
cp testfiles/firewall-policies-7.csv ./firewall-policies.csv
echo "Running test 7 blocks"
sudo python sdn.py

# Run Test 8
echo "Test 8: 8 blocks"
echo "Copying file into correct location and renaming to firewall-policies"
cp testfiles/firewall-policies-7.csv ./firewall-policies.csv
echo "Running test 8 blocks"
sudo python sdn.py


