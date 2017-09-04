#Class for install web server needed for zabbix
class phpapache {
  class { 'apache':
    mpm_module => 'prefork',
  }

  include apache::mod::php

  file { '/etc/php.ini':
    ensure  => file,
    content => template('apache/php.ini.epp'),
  }

  file { '/etc/httpd/conf.d/zabbix.conf':
    ensure  => file,
    content => '
Alias /zabbix /usr/share/zabbix

<Directory "/usr/share/zabbix">
    Options FollowSymLinks
    AllowOverride None
    Require all granted
</Directory>

<Directory "/usr/share/zabbix/conf">
    Require all denied
</Directory>

<Directory "/usr/share/zabbix/include">
    Require all denied
</Directory>',
    notify  => Service['httpd'],
  }
}