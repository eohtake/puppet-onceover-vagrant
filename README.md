# Puppet Roles and Profiles test VM with Onceover

This Vagrant repo provisions and configures a VM with the tools necessary to test a control repo using [Onceover](https://github.com/dylanratcliffe/onceover), a cool testing tool for the [Roles and Profiles](https://puppet.com/docs/puppet/7/the_roles_and_profiles_method.html) Puppet method.

Onceover lets you compile a local catalog against local machine facts, resolve Hiera data and group classes and nodes in a comprehensive way.
With Onceover, you can also run tests against custom node facts that you can extract from your own precious and unique infrastructure.

### Prerequisites
You need to have installed:
- Vagrant
- Virtualbox (You can use a different hypervisor if you want to play with the configs)

### How to get started
Clone this repo, change to its directory and run:
```
vagrant up
```
When the provisioning is finished, run the following to ssh into it:
```
vagrant ssh
```

### What happened?
A virtual machine running Ubuntu was provisioned from a Vagrant image, RVM was installed, along with a version of Ruby, Bundler and Onceover gems.
Then a template [Puppet control repo](https://github.com/puppetlabs/control-repo) was cloned, and a first Onceover test was run. Lastly, you ssh into the VM.

>**Note**:  
If you don't have the `ubuntu/focal64` image, Vagrant may take its time to download it for the first time.
>

### The provisioning scripts
- `install-rvm.sh` installs Ruby Version Manager and developers GPG keys, accepts RVM version and gpg keys servers as arguments.
- `install-ruby.sh` installs Ruby and Bundler, accepts Ruby version and gems as arguments.
- `bootstrap.sh` installs some basic tools I found useful to me, clones the control repo, installs and initialize onceover on it. Accepts a Git url with a control repo and its folder name.

### The virtual machine
This block in the Vagrant file defines some VM stuff that you might want to change accordingly to your needs:
```ruby
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

```

### The Vagrant VM operation
From this repository folder (where the Vagrant file is) run the following to:

Stop the vm:  
```
vagrant halt
```

Start the vm from halt:
```
vagrant up
```

If you made changes to the provisioning scripts (not very reliable):
```
vagrant reload --provision
```

Destroy the machine:
```
vagrant resume
```
>**Note**:  
Git push or backup your code before doing that. :-)
>

### More info

- [Puppet Roles and Profile method](https://puppet.com/docs/puppet/7/the_roles_and_profiles_method.html)
- [Puppet control repo](https://github.com/puppetlabs/control-repo)
- [Onceover](https://github.com/dylanratcliffe/onceover)
- [Vagrant](https://www.vagrantup.com/downloads)
- [Virtualbox](https://www.virtualbox.org/)
- [RVM - Ruby Version Manager](https://rvm.io/)

### Visual Studio Code - SSH extension
This cool extension allows you to work on your Vagrant VM file system where the onceover environment is isolated.

After provisioning your test VM from this repository folder, run on your host machine:
```
$ vagrant ssh-config > ssh_config
```

Download and install the [remote ssh](https://code.visualstudio.com/docs/remote/ssh) extension and create an SSH target pointing to the above configuration file. 
VSCODE can now connect and see your Vagrant VM filesystem.