class zabbix_master {
  exec { 'rpm -ivh http://repo.zabbix.com/zabbix/3.4/rhel/7/x86_64/zabbix-release-3.4-1.el7.centos.noarch.rpm':  
    notify => Package['zabbix-server-mysql'],
  }
  package { 'zabbix-server-mysql':
    ensure => 'installed',
  }
  package { 'zabbix-web-mysql':
    ensure  => 'installed',
    require => Package['zabbix-server-mysql'],
  }
  file { '/etc/zabbix/zabbix_server.conf':
    ensure  => file,
    content => template('my_zabbix_s/zabbix_server.conf.epp'),
    require => Package['zabbix-web-mysql'],
  }
  service { 'zabbix-server':
    ensure  => 'running',
    enable  => true,
    require => File['/etc/zabbix/zabbix_server.conf'],
  }
}