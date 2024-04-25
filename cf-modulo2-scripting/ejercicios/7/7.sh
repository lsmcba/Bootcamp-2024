#!/bin/bash

check_root() {
    if [ "$(id -u)" -ne 0 ]; then
        echo "Este script debe ejecutarse como root o con sudo."
        exit 1
    fi
}

install_packages() {
    local packages=("apache2" "mysql-server" "php" "php-mysql" "php-gd" "php-xml" "php-mbstring" "php-intl")

    for package in "${packages[@]}"; do
        if ! dpkg -l "$package" > /dev/null 2>&1; then
            echo "El paquete $package no está instalado. Instalándolo ahora..."
            apt-get install -y "$package"
        else
            echo "El paquete $package ya está instalado."
        fi
    done
}

configure_database() {
    local DB_USER="mediawikiuser"
    local DB_PASSWORD="mediawikipassword"
    local DB_NAME="mediawikidb"

    systemctl start mysql

    mysql -u root <<MYSQL_SCRIPT
CREATE DATABASE $DB_NAME;
CREATE USER '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT
}

configure_apache() {
    systemctl stop apache2
    a2dissite 000-default
    wget https://releases.wikimedia.org/mediawiki/1.41/mediawiki-1.41.0.tar.gz 
    tar -zxvf mediawiki-1.41.0.tar.gz  -C /var/www/html/
    mv /var/www/html/mediawiki-1.41.0 /var/www/html/mediawiki
    chown -R www-data:www-data /var/www/html/mediawiki

    cat <<EOF > /etc/apache2/sites-available/mediawiki.conf
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html/mediawiki

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined

    <Directory /var/www/html/mediawiki>
        Options FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF

    a2ensite mediawiki.conf
    systemctl restart apache2
}

# Main script
check_root
install_packages
configure_database
configure_apache

sleep 5
echo "MediaWiki se ha instalado correctamente. Accede a http://localhost para completar la configuración."

sleep 5
systemctl reload apache2
