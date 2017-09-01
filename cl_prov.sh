#!/bin/bash

#Hosts
echo "3.3.3.3 pe pe.minsk.epam.com" >> /etc/hosts

#PuppetAgent Opensource
curl -k https://pe.minsk.epam.com:8140/packages/current/install.bash | sudo bash

#Add server configuration

#echo 'server=vm1.minsk.epam.com' >> /etc/puppetlabs/puppet/puppet.conf
#puppet agent --enable
#puppet agent -t --server vm1.minsk.epam.com

#FACTS GATHERING
#facter -p | less