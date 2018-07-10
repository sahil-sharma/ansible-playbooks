#!/bin/bash
set -e
echo ""

apt-get update -y

#Vagrant user
apt-get install unzip tree -y
cp /vagrant/ssh-keys/* /home/vagrant/.ssh/
cat /home/vagrant/.ssh/server.pub >> /home/vagrant/.ssh/authorized_keys
chmod 0700 /home/vagrant/.ssh/ && chmod 0600 /home/vagrant/.ssh/*
chown -R vagrant:vagrant /home/vagrant/.ssh/

#Root user
cp /vagrant/ssh-keys/* /root/.ssh/
cat /root/.ssh/server.pub >> /root/.ssh/authorized_keys
chmod 0700 /root/.ssh/ && chmod 0600 /root/.ssh/*
chown -R root:root /root/.ssh/
