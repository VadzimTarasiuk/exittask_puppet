#!/bin/bash
sed -i 's/pe/pe.minsk.epam.com/' /etc/hosts
echo "3.3.3.4 zabbix_server.minsk.epam.com" >> /etc/hosts
echo "3.3.3.5 zabbix_agent.minsk.epam.com" >> /etc/hosts

cp /vagrant/puppet-enterprise-2017.2.3-el-7-x86_64.tar.gz ./
tar -zxf puppet-enterprise-2017.2.3-el-7-x86_64.tar.gz
cp /vagrant/pe.conf ./
./puppet-enterprise-2017.2.3-el-7-x86_64/puppet-enterprise-installer -c ./pe.conf -y

#Adding DB-module + ZABBIX
#/opt/puppetlabs/bin/puppet module install puppetlabs-mysql --version 3.11.0
/opt/puppetlabs/bin/puppet module install puppet-zabbix -f --version 4.1.3
/opt/puppetlabs/bin/puppet module install puppetlabs-mysql -f --version 3.11.0
/opt/puppetlabs/bin/puppet module install puppetlabs-apache -f
/opt/puppetlabs/bin/puppet module install puppetlabs-concat -f --version 4.0.1

#cp /varant/mysql_class.pp /etc/puppetlabs/code/environments/production/modules
cp /vagrant/database.pp /etc/puppetlabs/code/environments/production/manifests
cp /vagrant/zabbix_master.pp /etc/puppetlabs/code/environments/production/manifests
cp /vagrant/zabbix_agent.pp /etc/puppetlabs/code/environments/production/manifests
#templates for configuration
cp /vagrant/php.ini.epp /etc/puppetlabs/code/environments/production/modules/apache/templates
cp /vagrant/zabbix.conf.epp /etc/puppetlabs/code/environments/production/modules/zabbix/templates
cp /vagrant/zabbix_agentd.conf.epp /etc/puppetlabs/code/environments/production/modules/zabbix/templates

cat >> /etc/puppetlabs/code/environments/production/manifests/site.pp <<- EOM
node /^*server/ {
  include zabbix_master
}
EOM
cat >> /etc/puppetlabs/code/environments/production/manifests/site.pp <<- EOM
node /^*agent/ {
  include zabbix_agent
}
EOM