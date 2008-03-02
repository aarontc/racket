# IEEE 802.1Q VLAN tag (http://en.wikipedia.org/wiki/IEEE_802.1Q)
class VLAN < RacketPart
  ETHERTYPE_IPV4 = 0x0800
  ETHERTYPE_ARP = 0x0806
  ETHERTYPE_RARP = 0x8035
  ETHERTYPE_APPLETALK = 0x809b
  ETHERTYPE_AARP = 0x80f3
  ETHERTYPE_8021Q = 0x8100
  ETHERTYPE_IPX = 0x8137
  ETHERTYPE_NOVELL = 0x8138
  ETHERTYPE_IPV6 = 0x86DD
  ETHERTYPE_MPLS_UNICAST = 0x8847
  ETHERTYPE_MPLS_MULTICAST = 0x8848
  ETHERTYPE_PPPOE_DISCOVERY = 0x8863
  ETHERTYPE_PPPOE_SESSION = 0x8864
  ETHERTYPE_8021X = 0x888E
  ETHERTYPE_ATAOE = 0x88A2
  ETHERTYPE_8021AE = 0x88E5

  unsigned :priority, 3
  unsigned :cfi, 1
  # VLAN ID
  unsigned :id, 12
  # L3 protocol type.  Defaults to IPV4
  unsigned :type, 16, { :default => ETHERTYPE_IPV4 }
  rest :payload
end
# vim: set ts=2 et sw=2:
