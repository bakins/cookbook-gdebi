require 'berkshelf/vagrant'

Vagrant::Config.run do |config|
  config.vm.host_name = "gdebi-berkshelf"

  config.vm.box = "opscode-precise"
  config.vm.box_url = "https://opscode-vm.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_chef-10.18.2.box"

  config.vm.network :hostonly, "33.33.33.10"
  
  config.ssh.max_tries = 40
  config.ssh.timeout   = 120

  config.vm.provision :chef_solo do |chef|
    chef.json = {
    }

    chef.run_list = [
      "recipe[gdebi::test]"
    ]
  end
end
