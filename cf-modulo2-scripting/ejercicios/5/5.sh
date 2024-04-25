#!/bin/bash

if dpkg -l apache2 > /dev/null 2>&1; then
    echo "Apache ya está instalado en el sistema."
    exit 0
fi

sudo apt-get update

sudo apt-get install -y apache2

if [ $? -eq 0 ]; then
    echo "Apache se instaló correctamente."
    sudo systemctl start apache2
    sudo systemctl enable apache2
else
    echo "Error: No se pudo instalar Apache."
fi