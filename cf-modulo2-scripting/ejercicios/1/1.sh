#!/bin/bash

read -p "Ingresa un directorio: " dir

if [ -d $dir ]; then
    echo "Listado de archivos en $dir"
    ls $dir 
else
    echo "El directorio $dir no existe"
fi    