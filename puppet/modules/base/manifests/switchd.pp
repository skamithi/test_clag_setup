class base::switchd {

  service { 'switchd':
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true
  }

  file { '/etc/cumulus/ports.conf':
    ensure => present,
    before => Cumulus_ports['ports']
  }
  cumulus_ports { 'ports':
    speed_40g => $speed_40g,
    speed_4_by_10g => $speed_4_by_10g,
    notify => Service['switchd'],
    before => Cumulus_license['license']
  }

  cumulus_license { 'license':
    src => "http://192.168.0.1/${::hostname}.lic",
    notify => Service['switchd']
  }


}

