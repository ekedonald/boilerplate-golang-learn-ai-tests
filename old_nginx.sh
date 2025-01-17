#! /bin/bash
WEB_ROOT="/var/www/production"
CONFIG_FILE="/etc/nginx/conf.d/production.conf"
DOMAIN_OR_IP="91.229.239.238"

sudo mkdir -p $WEB_ROOT
sudo apt update
sudo apt install -y nginx

content='server {
    listen 80;
    server_name localhost;
    location / {
        proxy_pass http://127.0.0.1:8019;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}'

echo "$content" | sudo tee $CONFIG_FILE > /dev/null
sudo chmod 664 $CONFIG_FILE
sudo sed -i "s/localhost/$DOMAIN_OR_IP/g" $CONFIG_FILE

# Delete Default Nginx Webpage
sudo rm /etc/nginx/sites-available/default && sudo rm /etc/nginx/sites-enabled/default

# Validate the Configuration
sudo nginx -t
sudo systemctl restart nginx
echo "PRODUCTION SERVER URL: http://$DOMAIN_OR_IP"