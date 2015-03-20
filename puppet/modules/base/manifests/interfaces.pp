class base::interfaces {

  cumulus_interface { 'peerlink.4094':
    ipv4  => $peerlink_ip,
    clagd_enable => true,
    clagd_sys_mac => $sys_mac,
    clagd_peer_ip => $peer_ip,
    notify => Exec['ifreload -a']
  }

  cumulus_bond { 'peerlink':
    slaves => $peerlink_ports,
    alias_name => 'peer link bond',
    notify => Exec['ifreload -a']
  }

  cumulus_bond { 'uplink':
    slaves => $uplink_ports,
    clag_id => 1,
    alias_name => 'uplink ports',
    mstpctl_portnetwork => true,
    notify => Exec['ifreload -a'],
  }

  cumulus_bridge { 'bridge':
    vlan_aware => true,
    ports => $bridge_ports,
    vids => ['1-10'],
    pvid => 1,
    alias_name => 'vlan aware bridge',
    notify => Exec['ifreload -a']
  }

  if $server1_port {
    cumulus_bond { 'server1':
      slaves => $server1_port,
      clag_id => 2,
      mstpctl_bpduguard => true,
      notify => Exec['ifreload -a']
    }
  }

  if $server2_port {
    cumulus_bond { 'server2':
      slaves => $server2_port,
      clag_id => 3,
      mstpctl_bpduguard => true,
      notify => Exec['ifreload -a']
    }
  }



  # setting start as ifreload -a seems to make sure
  # ifreload -a is always executed which is desired
  # networking start only runs ifup -a which doesn't
  # delete unwanted interfaces
  exec { 'ifreload -a':
    path  => '/sbin',
    refreshonly => true
  }

}
