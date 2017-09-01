class zabbix_master {
  class { 'apache':
    mpm_module => 'prefork',
  }
  include apache::mod::php
  file { '/etc/php.ini':
    ensure  => file,
    content => template('apache/php.ini.epp'),
  }

  class { 'mysql::server':
    root_password           => 'Zabbix_2017',
    remove_default_accounts => true,
  }
  class { 'zabbix':
    zabbix_url        => $facts['fqdn'],
    database_type     => 'mysql',
    database_name     => 'zabbix',
    database_user     => 'zabbix',
    database_password => 'Zabbix_2017',
    cachesize         => '32M',
    startpingers      => '5',
  }

  exec { 'zcat zabbix-server-mysql-3.4.1/create.sql.gz | mysql -uzabbix -pZabbix_2017':
    cwd    => "/usr/share/doc",
    path   => ["/usr/bin","/usr/sbin"],
  }

  file { '/etc/httpd/conf.d/zabbix.conf':
    ensure  => file,
    content => template('zabbix/zabbix.conf.epp'),
    notify  => Service['httpd'],
  }
}