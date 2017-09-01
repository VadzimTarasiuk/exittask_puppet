#!/bin/bash
sed -i 's/vm1/vm1.minsk.epam.com/' /etc/hosts
echo "3.3.3.2 vm2.minsk.epam.com" >> /etc/hosts
echo "3.3.3.4 vm3.minsk.epam.com" >> /etc/hosts

cp /vagrant/puppet-enterprise-2017.2.3-el-7-x86_64.tar.gz ./
tar -zxf puppet-enterprise-2017.2.3-el-7-x86_64.tar.gz
cp /vagrant/pe.conf ./
./puppet-enterprise-2017.2.3-el-7-x86_64/puppet-enterprise-installer -c ./pe.conf -y

#add class pe_repo::platform::ubuntu_1404_amd64
#echo "node 'vm1.minsk.epam.com' { \n include pe_repo::platform::ubuntu_1404_amd64 \n }" >> /etc/puppetlabs/code/environments/production/manifests/site.pp

#Installer Apache2\HTTPD
#mkdir -p /etc/puppetlabs/code/environments/production/modules/apache/templates
#cp -f /vagrant/apache.pp /etc/puppetlabs/code/environments/production/modules/apache

#cat >> /etc/puppetlabs/code/environments/production/manifests/site.pp <<- EOM
#node /.minsk.epam.com$/ {
#  include apache
#}
#EOM

#cp /vagrant/index.html.epp /etc/puppetlabs/code/environments/production/modules/apache/templates 

#Add Ubuntu platform class to Master
cat > /home/vagrant/repo.pp <<- EOM
node 'vm1.minsk.epam.com' {
  include pe_repo::platform::ubuntu_1404_amd64
}
EOM
sleep 10s

#Apply the settings to master-node

/opt/puppetlabs/bin/puppet apply repo.pp
#cp -f /vagrant/nginxinstall.pp /etc/puppetlabs/code/environments/production/manifests

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

cat >> /etc/puppetlabs/code/environments/production/manifests/site.pp <<- EOM
node 'vm2.minsk.epam.com' {
  include zabbix_master
}
EOM
cat >> /etc/puppetlabs/code/environments/production/manifests/site.pp <<- EOM
node 'vm3.minsk.epam.com' {
  include zabbix_agent
}
EOM