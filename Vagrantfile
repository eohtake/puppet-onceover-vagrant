# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_NO_PARALLEL'] = 'yes'

Vagrant.configure(2) do |config|
  
  config.vm.provision :shell, path: "install-rvm.sh", args: ["stable", "keys.openpgp.org"], privileged: false
  config.vm.provision :shell, path: "install-ruby.sh", args: ["2.5.9", "bundler"], privileged: false
  # The second argument is the git folder. Change it if your repo URL changes.
  config.vm.provision :shell, path: "bootstrap.sh", args: ["https://github.com/puppetlabs/control-repo.git", "control-repo"], privileged: false

  config.vm.define "puppet-dev-machine" do |host|
    host.vm.box      = "ubuntu/focal64"
    host.vm.hostname = "puppet-dev-machine.local"
    
    host.vm.network "private_network", ip: "172.16.16.100"

    host.vm.provider :virtualbox do |v|
      v.name    = "puppet-dev-machine"
      v.memory  = 2048
      v.cpus    =  2
    end
  end
end