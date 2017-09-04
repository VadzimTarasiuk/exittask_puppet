#some definition of this crap code...
class my_zabbix_s {

  $db_name = 'zabbix'
  $db_user = 'zabbix'
  $db_passwd = 'Zabbix_2017'

  exec { 'rpm zabbix-release':
    cwd     => '/tmp',
    path    => '/usr/bin:/usr/sbin:/bin',
    creates => '/usr/share/doc/zabbix-release-3.4',
    command => 'rpm -ivh  http://repo.zabbix.com/zabbix/3.4/rhel/7/x86_64/zabbix-release-3.4-1.el7.centos.noarch.rpm',
    notify  => Package['zabbix-server-mysql'],
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
    content => template('my_zabbix_s/zabbix_server.conf.erb'),
    require => Package['zabbix-web-mysql'],
  }
  service { 'zabbix-server':
    ensure  => 'running',
    enable  => true,
    require => File['/etc/zabbix/zabbix_server.conf'],
  }
  notify { $facts['python_ver']: }
}
