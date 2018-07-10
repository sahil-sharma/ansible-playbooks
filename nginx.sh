#!/bin/bash
set -e
echo ""

#Install Nginx
apt-get update
apt-get install nginx -y

#Download and Install Consul template
wget https://releases.hashicorp.com/consul-template/0.19.4/consul-template_0.19.4_linux_amd64.zip -P /tmp --quiet
unzip /tmp/consul-template_0.19.4_linux_amd64.zip -d /tmp
mv /tmp/consul-template /usr/local/bin
rm /tmp/consul-template_0.19.4_linux_amd64.zip

#Consul Template directory
mkdir /root/consul-template
cd /root/consul-template
cat > nginx.ctmpl << EOL
upstream app {
  least_conn;
  {{range service "flask-app.app"}}server {{.Address}}:{{.Port}} max_fails=3 fail_timeout=60 weight=1;
  {{else}}server 127.0.0.1:65535; # force a 502{{end}}
}

server {
  listen 80 default_server;

  location / {
    proxy_pass http://app;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
  }
}
EOL

#Starting consul template
echo "reload-consul-template=consul-template -consul-addr=http://192.168.50.31:8500 -template="/root/consul-template/nginx.ctmpl:/etc/nginx/conf.d/default.conf:service nginx reload"" >> /root/.bashrc
source /root/.bashrc
