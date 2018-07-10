# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu14"

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = 1024
    vb.cpus = 1
  end

  config.vm.define "ansible" do |ansible|
      ansible.vm.hostname = "ansible"
      ansible.vm.network "private_network", ip: "192.168.50.30"
      ansible.vm.provision "shell", inline: 'echo "192.168.50.30 ansible ansible.vagrant" > /etc/hosts'
      ansible.vm.provision "shell", inline: 'sudo apt-get update -y \
                                             && sudo apt-get install software-properties-common \
                                             && sudo apt-add-repository ppa:ansible/ansible -y \
                                             && sudo apt-get update && sudo apt-get install ansible -y'
      ansible.vm.provision "shell", path: 'master.sh'
  end

  config.vm.define "node1" do |node1|
      node1.vm.hostname = "node1"
      node1.vm.network "private_network", ip: "192.168.50.31"
      node1.vm.provision "shell", inline: 'echo "192.168.50.31 node-1 node-1.vagrant" > /etc/hosts'
      node1.vm.provision "shell", path: 'master.sh'
      node1.vm.provision "shell", path: 'redis-master.sh'
  end

  config.vm.define "node2" do |node2|
      node2.vm.hostname = "node2"
      node2.vm.network "private_network", ip: "192.168.50.32"
      node2.vm.provision "shell", inline: 'echo "192.168.50.32 node-2 node-2.vagrant" > /etc/hosts'
      node2.vm.provision "shell", path: 'master.sh'
      #node2.vm.provision "shell", path: 'redis-client.sh'
  end

  config.vm.define "node3" do |node3|
      node3.vm.hostname = "node3"
      node3.vm.network "private_network", ip: "192.168.50.33"
      node3.vm.provision "shell", inline: 'echo "192.168.50.33 node-3 node-3.vagrant" > /etc/hosts'
      node3.vm.provision "shell", path: 'master.sh'
      node3.vm.provision "shell", path: 'redis-client.sh'
  end

  config.vm.define "nginx" do |t|
      t.vm.hostname = "nginx"
      t.vm.network "private_network", ip: "192.168.50.34"
      t.vm.provision "shell", inline: 'echo "192.168.50.34 nginx nginx.vagrant" > /etc/hosts'
      t.vm.provision "shell", path: 'master.sh'
      t.vm.provision "shell", path: 'nginx.sh'
  end
end
