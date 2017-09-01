#!/bin/bash

#Hosts
echo "3.3.3.3 vm1 vm1.minsk.epam.com" >> /etc/hosts

#PuppetAgent Opensource
curl -k https://vm1.minsk.epam.com:8140/packages/current/install.bash | sudo bash

#Add server configuration

#echo 'server=vm1.minsk.epam.com' >> /etc/puppetlabs/puppet/puppet.conf
#puppet agent --enable
#puppet agent -t --server vm1.minsk.epam.com

#sleep 10s
#/opt/puppetlabs/bin/puppet agent -t

#FACTS GATHERING
#facter -p | less