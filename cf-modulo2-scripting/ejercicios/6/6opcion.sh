#!/bin/bash

repo="startbootstrap"

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

if [ -d "$repo" ]; then
    echo "El directorio del repositorio ya existe."
    rm -rf $repo
else
    git clone https://gitlab.com/training-devops-cf/startbootstrap.git
    cp -r $repo/* /var/www/html
fi

systemctl restart apache2

echo "Configuración completada. El repositorio está disponible en http://localhost"