# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"
  config.vm.forward_port 80, 8999
  config.vm.share_folder("v-root", "/vagrant", ".", :extra => 'dmode=777,fmode=777')
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ".provision"
    chef.add_recipe "contenthub"
    chef.json = { 'mysql' => { 'server_root_password' => 'f3ad40ef59eb0067c2b16daa7613bd5e',  
                               'server_debian_password' => '5e8259796a5588be766511b9c8ceae6b',
                               'server_repl_password' => '1ef7f36b52634509f16fe922fd5f31e7'},
                  'contenthub' => { 'host' => 'contenthub',
                                    'user' => 'www-data', 
                                    'group' => 'www-data',
                                    'dir' => '/vagrant/website',
                                    'db' => { 'user' => 'contenthub', 
                                              'password' => '5b15c5350ec09bb03513a97ec6703068',
                                              'database' => 'contenthub' }}}
  end
end
