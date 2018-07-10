#!/bin/bash
set -e
echo -e "\n" "Getting IP's of all the instance. Please wait..."
echo ""
ansible=`vagrant ssh ansible -c "hostname -I | cut -d' ' -f2" 2>/dev/null`
node1=`vagrant ssh node1 -c "hostname -I | cut -d' ' -f2" 2>/dev/null`
node2=`vagrant ssh node2 -c "hostname -I | cut -d' ' -f2" 2>/dev/null`
node3=`vagrant ssh node3 -c "hostname -I | cut -d' ' -f2" 2>/dev/null`
nginx=`vagrant ssh nginx -c "hostname -I | cut -d' ' -f2" 2>/dev/null`

#echo ""
echo "Ansible IP  : " $ansible
echo "Node1 IP    : " $node1
echo "Node2 IP    : " $node2
echo "Nginx IP    : " $nginx
echo ""
echo -e "Everything looks good to me." "\n"
echo -e "Please wait logging into ansible instance"
sleep 5
echo ""
ssh -i ./ssh-keys/server -o "StrictHostKeyChecking no" root@$ansible
