node 'wbench.lab.local' {
}

node 'leaf1.lab.local' {
  $speed_40g = ['swp2-31']
  $speed_4_by_10g = ['swp1', 'swp32']
  $peerlink_ip = '10.1.1.0/31'
  $sys_mac = '44:38:39:ff:20:94'
  $peer_ip = '10.1.1.1'
  $uplink_ports = ['swp1s0-1', 'swp1s2-3']
  $peerlink_ports = ['swp17-18']
  include base::role::switch
}

node 'leaf2.lab.local' {
  $speed_40g = ['swp2-31']
  $speed_4_by_10g = ['swp1', 'swp32']
  $peerlink_ip = '10.1.1.1/31'
  $sys_mac = '44:38:39:ff:20:94'
  $peer_ip = '10.1.1.0'
  $uplink_ports = ['swp1s0-1', 'swp1s2-3']
  $peerlink_ports = ['swp17-18']
  include base::role::switch
}

node 'spine1.lab.local' {
  $speed_40g = []
  $speed_4_by_10g  = []
  $peerlink_ip = '10.1.1.2/31'
  $sys_mac = '44:38:39:ff:40:94'
  $peer_ip = '10.1.1.3'
  $uplink_ports = ['swp49-52']
  $peerlink_ports = ['swp17-18']
  include base::role::switch
}

node 'spine2.lab.local' {
  $speed_40g = []
  $speed_4_by_10g = []
  $peerlink_ip = '10.1.1.3/31'
  $sys_mac = '44:38:39:ff:40:94'
  $peer_ip = '10.1.1.2'
  $uplink_ports = ['swp49-52']
  $peerlink_ports = ['swp17-18']
  include base::role::switch
}

