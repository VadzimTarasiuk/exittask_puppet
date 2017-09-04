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

___etc...___
