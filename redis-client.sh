#!/bin/bash
set -e
echo ""

#Downloading redis-stable
wget http://download.redis.io/redis-stable.tar.gz -P /tmp --quiet

#Extracting redis
tar zxf /tmp/redis-stable.tar.gz -C /root

#Compiling redis
cd /root/redis-stable
make

#Copying redis-binaires to /usr/local/bin
cp /root/redis-stable/src/redis-server /usr/local/bin
cp /root/redis-stable/src/redis-cli /usr/local/bin

#Editing redis.conf
IP=$(hostname -I|cut -f2 -d ' ')
sed -i "s/bind 127.0.0.1/bind $IP/g" redis.conf
#sed -i '/slaveof/s/^#//g' /root/redis-stable/redis.conf
#sed -i 's/<masterip>/192.168.50.31/g' /root/redis-stable/redis.conf
#sed -i "s/<masterport>/6379/g" /root/redis-stable/redis.conf
echo "slaveof 192.168.50.31 6379" >> /root/redis-stable/redis.conf

#Starting redis
echo "alias start-redis='redis-server /root/redis-stable/redis.conf &'" >> /root/.bashrc
source /root/.bashrc

