#!/bin/bash

# Script para instalar Apache, Git y hacer disponible un repositorio en Apache


if [ "$(id -u)" -ne 0 ]; then
    echo "Error: Este script debe ejecutarse con privilegios de root."
    exit 1
fi

paquetes=("apache2" "git")

for paquete in "${paquetes[@]}"; do
    if ! dpkg -l "$paquete" > /dev/null 2>&1; then
        apt-get update
        apt-get install -y "$paquete"
    else
        echo "$paquete ya está instalado."
    fi
done

repo_directory="/var/www/html/startbootstrap"

if [ -d "$repo_directory" ]; then
    echo "El directorio del repositorio ya existe."
else
    git clone https://gitlab.com/training-devops-cf/startbootstrap.git "$repo_directory"
fi

systemctl restart apache2

echo "Configuración completada. El repositorio está disponible en http://localhost/startbootstrap"
