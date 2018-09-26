# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "centos7-7.5.1804-1"

  config.vm.box_url = "http://manage.fieldnotes.jp/images/centos7-7.5.1804-1.box"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  #config.vm.network "forwarded_port", guest: 4000, host: 4000
  #config.vm.network "forwarded_port", guest: 3001, host: 3001
  #onfig.vm.network "forwarded_port", guest: 3000, host: 3000
  # Create a private network, which allows host-only access to the machine
  # using a specific IP.

  config.vm.define :centos , primary: true do |centos|
    centos.vm.network "private_network", ip: "192.168.34.2"
    centos.vm.provision :shell, :path => "provisioning-vagrant.sh"
  end   

  config.vm.define :remote , autostart: false do |remote|
    remote.vm.box = "dummy"
    remote.vm.provider :aws do |aws, override|
      aws.access_key_id = ENV['AWS_ACCESS_KEY_ID']
      aws.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
      aws.region = 'ap-northeast-1'
      aws.instance_type = 't2.small'
      aws.ami = 'ami-8e8847f1'
      security_group = ENV['security_group']
      aws.security_groups = [security_group]
      aws.keypair_name = ENV['keypair_name']
      aws.ssh_host_attribute = :public_ip_address
      aws.associate_public_ip = true
      aws.subnet_id = ENV['subnet_id']
      override.vm.box_url="https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box"
      override.ssh.username = 'centos'
      override.ssh.private_key_path = ENV['private_key_path']
      override.vm.synced_folder ".", "/vagrant" , type: "rsync"
      override.vm.provision :shell, :path => "provisioning-vagrant.sh"  
      aws.tags = { 'Name' => 'CI' }
    end
  end

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--cpus", "2", "--ioapic", "on"]
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end
end
