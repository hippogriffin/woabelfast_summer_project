# -*- mode: ruby -*-
# vi: set ft=ruby :
hosts = [
    {name: 'proxy', ip: '10.120.0.2', memory: '512', cpu: '2', hostname: 'proxy.vagrant.local'},
    {name: 'wordpress', ip: '10.120.0.3', memory: '512', cpu: '2', hostname: 'wordpress.vagrant.local'},
    {name: 'db', ip: '10.120.0.4', memory: '512', cpu: '2', hostname: 'db.vagrant.local'}
]

groups = {
    "webservers" => ["proxy"],
    "wordpress_servers" => ["wordpress"],
    "db_servers" => ["db"],

    "frontend:children" => ["webservers","wordpress"],
    "backend:children" => ['db']
}


Vagrant.configure("2") do |config|

  hosts.each do |host|
    config.vm.define host[:name] do |c|
      c.vm.box = "centos/7"
      c.vm.hostname = host[:hostname]
      c.vm.network  "private_network",ip: host[:ip] ,netmask: "255.255.255.0"
      c.vm.provision "ansible" do |ansible|
        ansible.playbook = "ansible/site.yml"
        ansible.groups = groups
      end
      c.vm.provider "virtualbox" do |vb|
        vb.memory = host[:memory]
        vb.cpus = host[:cpu]
      end
    end
  end
end
  