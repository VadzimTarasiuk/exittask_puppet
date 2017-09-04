#!/bin/bash
sed -i 's/pe/pe.minsk.epam.com/' /etc/hosts
echo "3.3.3.4 zabbixserver.minsk.epam.com" >> /etc/hosts
echo "3.3.3.5 zabbixagent.minsk.epam.com" >> /etc/hosts

cp /vagrant/puppet-enterprise-2017.2.3-el-7-x86_64.tar.gz ./
tar -zxf puppet-enterprise-2017.2.3-el-7-x86_64.tar.gz
cp /vagrant/pe.conf ./
./puppet-enterprise-2017.2.3-el-7-x86_64/puppet-enterprise-installer -c ./pe.conf -y

#Adding DB-module + ZABBIX
#/opt/puppetlabs/bin/puppet module install puppetlabs-mysql --version 3.11.0
#/opt/puppetlabs/bin/puppet module install puppet-zabbix -f --version 4.1.3
/opt/puppetlabs/bin/puppet module install puppetlabs-mysql -f --version 3.11.0
/opt/puppetlabs/bin/puppet module install puppetlabs-apache -f
/opt/puppetlabs/bin/puppet module install puppetlabs-concat -f --version 4.0.1
/opt/puppetlabs/bin/puppet module install puppetlabs-stdlib -f

#Common Manifests
cp /vagrant/phpapache.pp /etc/puppetlabs/code/environments/production/manifests
cp /vagrant/database.pp /etc/puppetlabs/code/environments/production/manifests
#Common templates
cp /vagrant/php.ini.epp /etc/puppetlabs/code/environments/production/modules/apache/templates
#Custom Zabbix Modules
cp -r /vagrant/my_zabbix_s /etc/puppetlabs/code/environments/production/modules
cp -r /vagrant/my_zabbix_a /etc/puppetlabs/code/environments/production/modules

cat >> /etc/puppetlabs/code/environments/production/manifests/site.pp <<- EOM

node /^*server/ {
  include phpapache
  include database
  include my_zabbix_s
}
EOM

cat >> /etc/puppetlabs/code/environments/production/manifests/site.pp <<- EOM

node /^*agent/ {
  include my_zabbix_a
}
EOM
