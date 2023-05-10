#!/usr/bin/python

# EEE4121F-B Lab 2: SDN

# Implementing a Layer-2 Firewall using POX and Mininet
# Create the topology as shown in the lab 


from mininet.net import Mininet
from mininet.topo import Topo
from mininet.cli import CLI
from mininet.log import setLogLevel, info
from mininet.node import RemoteController

class treeTopo(Topo):
	def build(self):
		# Create 8 hosts
		h1 = self.addHost('h1')
		h2 = self.addHost('h2')
		h3 = self.addHost('h3')
		h4 = self.addHost('h4')
		h5 = self.addHost('h5')
		h6 = self.addHost('h6')
		h7 = self.addHost('h7')
		h8 = self.addHost('h8')
		# Create 7 switches
		s1 = self.addSwitch('s1')
		s2 = self.addSwitch('s2')
		s3 = self.addSwitch('s3')
		s4 = self.addSwitch('s4')
		s5 = self.addSwitch('s5')
		s6 = self.addSwitch('s6')
		s7 = self.addSwitch('s7')
		# Add links
		self.addLink(s2,s1)
		self.addLink(s5,s1)

		self.addLink(s3,s2)
		self.addLink(s4,s2)
		self.addLink(s6,s5)
		self.addLink(s7,s5)
		
		self.addLink(h1,s3)
		self.addLink(h2,s3)
		self.addLink(h3,s4)
		self.addLink(h4,s4)
		self.addLink(h5,s6)
		self.addLink(h6,s6)
		self.addLink(h7,s7)
		self.addLink(h8,s7)
		return

    

if __name__ == '__main__':
	setLogLevel( 'info' )
	topo = treeTopo()
	net = Mininet( topo=topo, controller=RemoteController )
	# Start network
	net.start()
	# test that the hosts are connected
	net.pingAll()
	# stop network
	net.stop()
	
	

