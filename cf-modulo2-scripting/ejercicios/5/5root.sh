#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
    echo "Error: Este script debe ejecutarse con privilegios de root."
    exit 1
fi

if dpkg -l apache2 > /dev/null 2>&1; then
    echo "Apache ya está instalado en el sistema."
    exit 0
fi

apt-get update

apt-get install -y apache2

if [ $? -eq 0 ]; then
    echo "Apache se instaló correctamente."
    sudo systemctl start apache2
    sudo systemctl enable apache2
else
    echo "Error: No se pudo instalar Apache."
fi