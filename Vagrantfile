# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.synced_folder ".", "/vagrant"

  config.vm.define "pe" do |c|
    c.vm.box = "sbeliakou/centos-7.3-x86_64-minimal"
    c.vm.network "private_network", ip: "3.3.3.3"
    c.vm.hostname = "pe"
    c.vm.provider "virtualbox" do |v|
      v.memory = "5120"
      v.name = "pe"
    end
    #c.vm.provision "shell", path: "./vm1_prov.sh"
    c.vm.provision "shell", path: "./vm1_pe.sh"
  end

  config.vm.define "zabbix_server" do |c|
    c.vm.box = "sbeliakou/centos-7.3-x86_64-minimal"
    c.vm.network "private_network", ip: "3.3.3.4"
    c.vm.hostname = "zabbix_server"
    c.vm.provider "virtualbox" do |v|
      v.memory = "2048"
      v.name = "zabbix_server"
    end
    c.vm.provision "shell", path: "./cl_prov.sh"
  end

  config.vm.define "zabbix_agent" do |c|
    c.vm.box = "sbeliakou/centos-7.3-x86_64-minimal"
    c.vm.network "private_network", ip: "3.3.3.5"
    c.vm.hostname = "zabbix_agent"
    c.vm.provider "virtualbox" do |v|
      v.memory = "512"
      v.name = "zabbix_agent"
    end
    c.vm.provision "shell", path: "./cl_prov.sh"
  end
end
