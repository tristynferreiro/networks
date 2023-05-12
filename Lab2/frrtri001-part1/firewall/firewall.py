from pox.core import core
import pox.openflow.libopenflow_01 as of
from pox.lib.revent import *
from pox.lib.util import dpidToStr
from pox.lib.addresses import EthAddr
from collections import namedtuple
import os
# TODO Add your imports here 
import csv #to be able to read the policies file
import time
from pox.lib.util import dpid_to_str

#TODO Add your global variables here 
log = core.getLogger()
policyFile = "%s/Desktop/frrtri001-part1/firewall/firewall-policies.csv" % (os.environ[ 'HOME' ])

blocked = set()
""" Define which connections should be blocked"""
# read the list
with open(policyFile,'r') as file:
  contents = csv.reader(file)
  for row in contents:
    if(row[0]!="id"): # skip header row
      blocked.add(row[1]) # get mac addresses

class LearningSwitch (object): # Copyright 2011-2012 James McCauley
  def __init__ (self, connection):
    self.connection = connection
    # Our table
    self.macToPort = {}
    # We want to hear PacketIn messages, so we listen
    # to the connection
    connection.addListeners(self)

  def _handle_PacketIn (self, event):
    packet = event.parsed

    if str(packet.src) in blocked or str(packet.dst) in blocked:
      return
    
    def flood (message = None):
      """ Floods the packet """
      msg = of.ofp_packet_out()
      dpid_to_str(event.dpid)
      msg.actions.append(of.ofp_action_output(port = of.OFPP_FLOOD))
      msg.data = event.ofp
      msg.in_port = event.port
      self.connection.send(msg)

    def drop (duration = None):
      """
      Drops this packet and optionally installs a flow to continue
      dropping similar ones for a while
      """
      if duration is not None:
        if not isinstance(duration, tuple):
          duration = (duration,duration)
        msg = of.ofp_flow_mod()
        msg.match = of.ofp_match.from_packet(packet)
        msg.idle_timeout = duration[0]
        msg.hard_timeout = duration[1]
        msg.buffer_id = event.ofp.buffer_id
        self.connection.send(msg)
      elif event.ofp.buffer_id is not None:
        msg = of.ofp_packet_out()
        msg.buffer_id = event.ofp.buffer_id
        msg.in_port = event.port
        self.connection.send(msg)

    self.macToPort[packet.src] = event.port # 1

    if packet.dst.is_multicast:
      flood() # 3a
    else:
      if packet.dst not in self.macToPort: # 4
        flood("Port for %s unknown -- flooding" % (packet.dst,)) # 4a
      else:
        port = self.macToPort[packet.dst]
        if port == event.port: # 5
          # 5a
          log.warning("Same port for packet from %s -> %s on %s.%s.  Drop."
              % (packet.src, packet.dst, dpid_to_str(event.dpid), port))
          drop(10)
          return
        # 6
        log.debug("installing flow for %s.%i -> %s.%i" %
                  (packet.src, event.port, packet.dst, port))
        msg = of.ofp_flow_mod()
        msg.match = of.ofp_match.from_packet(packet, event.port)
        msg.idle_timeout = 10
        msg.hard_timeout = 30
        msg.actions.append(of.ofp_action_output(port = port))
        msg.data = event.ofp # 6a
        self.connection.send(msg)
    
class Firewall (object):
  def __init__ (self):
    core.openflow.addListeners(self)
    
  def _handle_ConnectionUp (self, event):
    LearningSwitch(event.connection)


def launch ():
	# Starting the Firewall module
  core.registerNew(Firewall)
