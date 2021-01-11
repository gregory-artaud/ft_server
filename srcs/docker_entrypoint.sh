# NGINX
rm /var/www/html/index.nginx-debian.html
# MYSQL
service mysql start
mysql -u root -e "CREATE USER '${USER}'@'localhost' IDENTIFIED BY '${PASSWORD}';
GRANT ALL PRIVILEGES ON * . * TO '${USER}'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
CREATE DATABASE wordpress;"

# PHP MYADMIN
cd /var/www/html
mkdir phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar -zxvf phpMyAdmin-4.9.0.1-all-languages.tar.gz > /dev/null
cp -r phpMyAdmin-4.9.0.1-all-languages/* phpmyadmin
rm -rf phpMyAdmin-4.9.0.1-all-languages phpMyAdmin-4.9.0.1-all-languages.tar.gz
cp /app/srcs/config.inc.php ./phpmyadmin

# WORDPRESS
wget https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz > /dev/null
rm -rf latest.tar.gz
cp /app/srcs/wp-config.php /var/www/html/wordpress
cd /var/www/html/wordpress
sed -i 's/username_here/'${USER}'/g' wp-config.php
sed -i 's/password_here/'${PASSWORD}'/g' wp-config.php

# SSL
openssl req -x509 -nodes -days 2048 -subj "/C=FR/ST=France/L=Lyon/O=42Lyon/OU=logan/CN=localhost" -newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt;

service mysql restart
service php7.3-fpm start
service nginx start
sleep infinity &
wait