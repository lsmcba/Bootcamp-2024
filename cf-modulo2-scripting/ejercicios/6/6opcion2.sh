#!/bin/bash

# Definir colores
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # Sin color

if [ "$(id -u)" -ne 0 ]; then
    echo -e "${RED}Error: Este script debe ejecutarse con privilegios de root.${NC}"
    exit 1
fi

packages=("apache2" "git")

# Instalar paquetes
for package in "${packages[@]}"; do
    if ! dpkg -l "$package" > /dev/null 2>&1; then
        echo -e "Instalando ${GREEN}$package${NC}..."
        apt-get update
        apt-get install -y "$package"
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}$package instalado correctamente.${NC}"
        else
            echo -e "${RED}Error al instalar $package.${NC}"
            exit 1
        fi
    else
        echo -e "${GREEN}$package ya está instalado.${NC}"
    fi
done

a2dissite 000-default

repo_directory="/var/www/html/startbootstrap"

if [ -d "$repo_directory" ]; then
    echo -e "El directorio del repositorio ya existe. Realizando pull para obtener cambios..."
    cd "$repo_directory" || exit
    git pull origin main
else
    git clone -b main https://gitlab.com/training-devops-cf/startbootstrap.git "$repo_directory"
fi

cat <<EOF > /etc/apache2/sites-available/startbootstrap.conf
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot $repo_directory

    <Directory $repo_directory>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

a2ensite startbootstrap

systemctl restart apache2

echo -e "${GREEN}Configuración completada. El repositorio está disponible en http://localhost${NC}"