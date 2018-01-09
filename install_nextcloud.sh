#!/bin/bash

#####################################################
#    https://ugeek.github.io/script-nextcloud/      #
#####################################################

if [ "$(whoami)" != "root" ]; then
    echo "Run script as ROOT please. (sudo !!)"
    exit
fi

## Updating Raspberry
apt update -y
apt upgrade -y
apt dist-upgrade -y


## Install apache
apt install -y apache2

## Installation of PHP 7
apt install -t stretch -y php7.0 php7.0-mysql libapache2-mod-php7.0

mkdir /var/www/html
chown www-data:www-data /var/www/html
find /var/www/html -type d -print -exec chmod 775 {} \;
find /var/www/html -type f -print -exec chmod 664 {} \;
usermod -aG www-data pi
cat > /var/www/html/index.php << "EOF"
<?php phpinfo(); ?>
EOF

## Install MariaDB
apt install mariadb-server
mysql -u user -p

/etc/init.d/apache2 restart



## Instalación Nextcloud 12.04
# Instalando sqlite                                                             
sudo apt install php7.0-sqlite3 -y

# instalando php7                                                               
sudo apt install libapache2-mod-php7.0 -y
sudo apt install php7.0-gd php7.0-json php7.0-mysql php7.0-curl
php7.0-mbstring -y
sudo apt install php7.0-intl php7.0-mcrypt php-imagick php7.0-xml php7.0-zip -y

# Descargando Nextcloud 12.0.4. Cambiar la versión si queremos tener la última  
cd /var/www/html
sudo wget https://download.nextcloud.com/server/releases/nextcloud-12.0.4.zip
sudo unzip nextcloud-12.0.4.zip
sudo rm nextcloud-12.0.4.zip
sudo chown -R www-data:www-data /var/www/html/nextcloud
