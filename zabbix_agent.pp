class zabbix_agent { 
  class { 'zabbix::agent':
    server    => '3.3.3.2',
    hostname  => $facts['fqdn'],
    #+listen_ip+serveractive+
  }
  file { '/etc/zabbix/zabbix_agentd.conf':
    ensure  => file,
    content => template('zabbix/zabbix_agentd.conf.epp'),
  }
}