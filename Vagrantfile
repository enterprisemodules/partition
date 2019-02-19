# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "centos/7"
  # config.vm.box_url = "https://dl.dropboxusercontent.com/s/sij0m2qmn02a298/centos-5.8-x86_64.box"

  config.vm.synced_folder '.', '/vagrant', type: :virtualbox

  config.vm.provider :virtualbox do |vb|

    # vb.customize ["modifyvm", :id, "--memory", "3048"]
    vb.customize ["modifyvm", :id, "--cpus", "2"]
    vb.customize ["modifyvm", :id, "--ioapic", "on"]

    unless File.exist?("ssdisk5.vdi") # I guess if one file exists, we did the stuff
      controller_name = "SATA Controller"
      vb.customize ["storagectl", :id, "--add", "sata","--portcount", "5", "--name", controller_name]
      (1..5).each do | no|
        vb.customize ["createhd", "--filename", "ssdisk#{no}","--size",100,"--variant", "Fixed"]
        vb.customize ["storageattach", :id, "--storagectl", controller_name, "--port",no, "--device", "0", "--type", "hdd", "--medium", "ssdisk#{no}.vdi", "--mtype", "shareable"]
      end
    end
  end
  config.vm.provision :shell, :inline => "rpm -q puppet-release > /dev/null || yum install -y --nogpgcheck http://yum.puppetlabs.com/puppet/puppet-release-el-7.noarch.rpm"
  config.vm.provision :shell, :inline => "rpm -q puppet-agent > /dev/null || yum install -y --nogpgcheck puppet-agent"
  config.vm.provision :shell, :inline => "puppet module install enterprisemodules-easy_type"
  config.vm.provision :shell, :inline => "ln -sf /vagrant /etc/puppetlabs/code/environments/production/modules/partition"
end
