# Exit Task: Puppet

**Required and used Forge-modules:**
```bash
puppet module install puppetlabs-mysql -f --version 3.11.0
puppet module install puppetlabs-apache -f
puppet module install puppetlabs-concat -f --version 4.0.1
```
*_TODO_*:

+ ~Remake _.epp_ templates in _.erb_ templates with variables (based on _$facts_?)~

+ ~Add custom facts (at least one)~

+ ~Verify the code with _lint_ and add _metadata.json_~

+ Automate choice of node for deployment (depends on _fqdn_?)

**Notes:**

+ Automated installation and deployment of 1 node with Zabbix-server and 1 node Zabbix-agent.

+ Default FQDN for puppet-enterprise: _pe.minsk.epam.com_ (changes in Vagrantfile, provision scripts)

+ Default FQDN of deploying nodes: _zabbixserver.minsk.epam.com_,
                                   _zabbixagent.minsk.epam.com_ (changes in Vagrantfile, provision scripts)

**Installation:**

1. Clone this git repository.

2. Place there the Puppet Enterprise package (puppet-enterprise-2017.2.3-el-7-x86_64.tar.gz).
It is needed to change _vm1_pe.sh_ provision script to use other versions.

3. Bring all vm's up with ```vagrant up``` command.

4. Sign certificates at Puppet Enterprise web-UI or with ```puppet cert sign <node-fqdn>``` command.

5. Wait for puppet agents to apply new configuration or trigger it manually from web-UI or with ```puppet agent -t``` command.


___etc...___
