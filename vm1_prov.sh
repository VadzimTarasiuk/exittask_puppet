#!/bin/bash

echo "3.3.3.2 vm2.minsk.epam.com" >> /etc/hosts

rpm -Uvh https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm

#for OpenSource Puppet
yum install puppetserver -y

sed -i 's/JAVA_ARGS="-Xms2g -Xmx2g -Djruby.logger.class=com.puppetlabs.jruby_utils.jruby.Slf4jLogger"/JAVA_ARGS="-Xms1g -Xmx1g -Djruby.logger.class=com.puppetlabs.jruby_utils.jruby.Slf4jLogger"/' /etc/sysconfig/puppetserver
systemctl restart puppetserver
systemctl enable puppetserver

cp -f /vagrant/nginxinstall.pp /etc/puppetlabs/code/environments/production/manifests
#sleep 20s
#/opt/puppetlabs/bin/puppet cert list
#/opt/puppetlabs/bin/puppet cert sign vm2.minsk.epam.com