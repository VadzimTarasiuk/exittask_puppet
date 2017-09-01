# Exit Task: Puppet

**Required and used Forge-modules:**
```bash
puppet module install puppet-zabbix -f --version 4.1.3
puppet module install puppetlabs-mysql -f --version 3.11.0
puppet module install puppetlabs-apache -f
puppet module install puppetlabs-concat -f --version 4.0.1
```
*_TODO_*:

+ Remake _.epp_ templates in _.erb_ templates with variables (based on _$facts_?)

+ Static Data ===> HIERA

+ Rearrange existing code with _Roles\Profiles_ strategy

+ Automate choice of node for deployment (depends on _fqdn_?)

___etc...___
