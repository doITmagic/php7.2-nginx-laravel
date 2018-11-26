#!/bin/ash

set -e


#chown -R www-data:www-data /var/www/.env

#mkdir /etc/nginx/ssl
#mc cp certs /etc/nginx/ssl/

sed -i "s/nonwww_host/$NGINX_SERVER_NAME/g" /etc/nginx/conf.d/default.conf
sed -i "s/www_host/$WWW_NGINX_SERVER_NAME/g" /etc/nginx/conf.d/default.conf

#sudo -u www-data nohup sleep 45 && sudo -u www-data php /var/www/artisan queue:work redis --tries=3 2>/dev/null &

mkdir -p /var/tmp/nginx
chown -R www-data:www-data /var/tmp/nginx
chown -R www-data:www-data /var/www
chmod -R 755 /var/tmp/nginx


/sbin/runit-wrapper