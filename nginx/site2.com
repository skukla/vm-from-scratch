server {
     listen 80;
     server_name site2.com;
     client_max_body_size 100M;
     set $MAGE_ROOT /var/www/magento;
     include /etc/nginx/sites-available/conf/nginx-magento.conf;
}
