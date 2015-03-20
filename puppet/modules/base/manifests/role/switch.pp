class base::role::switch {
  include stdlib
  include base::switchd
  include base::interfaces

  package { 'netshow':
    ensure => present
  }

  Class['base::switchd'] ->
  file { '/etc/network/interfaces':
    owner => root,
    group => root,
    mode => '0644',
    content => template('base/interfaces.erb'),
    notify => Exec['ifreload -a']
  }->
  cumulus_interface_policy { 'int policy':
    allowed => ['peerlink', 'uplink', 'peerlink.4094', 'bridge'],
    notify => Exec['ifreload -a']
  }->
  Class['base::interfaces']

}

