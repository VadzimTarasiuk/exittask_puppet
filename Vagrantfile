# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.synced_folder ".", "/vagrant"

  config.vm.define "vm1" do |c|
    c.vm.box = "sbeliakou/centos-7.3-x86_64-minimal"
    c.vm.network "private_network", ip: "3.3.3.3"
    c.vm.hostname = "vm1"
    c.vm.provider "virtualbox" do |v|
      v.memory = "5120"
      v.name = "vm1"
    end
    #c.vm.provision "shell", path: "./vm1_prov.sh"
    c.vm.provision "shell", path: "./vm1_pe.sh"
  end

  config.vm.define "vm2" do |c|
    c.vm.box = "sbeliakou/centos-7.3-x86_64-minimal"
    c.vm.network "private_network", ip: "3.3.3.2"
    c.vm.hostname = "vm2"
    c.vm.provider "virtualbox" do |v|
      v.memory = "1024"
      v.name = "vm2"
    end
    c.vm.provision "shell", path: "./cl_prov.sh"
  end

  config.vm.define "vm3" do |c|
    c.vm.box = "sbeliakou/centos-7.3-x86_64-minimal"
    c.vm.network "private_network", ip: "3.3.3.4"
    c.vm.hostname = "vm3"
    c.vm.provider "virtualbox" do |v|
      v.memory = "1024"
      v.name = "vm3"
    end
    c.vm.provision "shell", path: "./cl_prov.sh"
  end
end
