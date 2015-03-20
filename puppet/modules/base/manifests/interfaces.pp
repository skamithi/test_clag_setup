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
    ports => ['peerlink', 'uplink'],
    vids => ['1-10'],
    pvid => 1,
    alias_name => 'vlan aware bridge',
    notify => Exec['ifreload -a']
  }

  # refreshonly makes sure that ifreload is only executed
  # if a network change occurs
  exec { 'ifreload -a':
    path  => '/sbin',
    refreshonly => true
  }

}
