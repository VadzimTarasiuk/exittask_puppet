class my_zabbix_a { 
  exec { 'rpm zabbix-release':
    cwd     => '/tmp',
    path    => '/usr/bin:/usr/sbin:/bin',
    creates => '/usr/share/doc/zabbix-release-3.4',
    command => 'rpm -ivh  http://repo.zabbix.com/zabbix/3.4/rhel/7/x86_64/zabbix-release-3.4-1.el7.centos.noarch.rpm',
    notify  => Package['zabbix-agent'],
  }
  package { 'zabbix-agent':
    ensure => 'installed',
  }
  file { '/etc/zabbix/zabbix_agentd.conf':
    ensure  => file,
    content => template('my_zabbix_a/zabbix_agentd.conf.epp'),
    require => Package['zabbix-agent'],
  }
  service { 'zabbix-agent':
    ensure  => 'running',
    enable  => true,
    require => File['/etc/zabbix/zabbix_agentd.conf'],
  }
}
