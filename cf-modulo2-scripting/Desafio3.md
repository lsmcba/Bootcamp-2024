# Desafío: Despliegue de una Tienda de Libros con PM2

## Objetivo
Escribe un script en Bash que automatice el despliegue de una tienda de libros desarrollada en React en un servidor Ubuntu. El objetivo es asegurar que la aplicación esté siempre disponible utilizando **PM2** como gestor de procesos y permitir actualizaciones del código mediante **git clone** o **pull**.

## Requisitos
1. El servidor Ubuntu debe tener **Node.js 16** instalado.
2. La aplicación de la tienda de libros está en un repositorio Git.
https://gitlab.com/training-devops-cf/book-store-devops
3. El script debe realizar las siguientes tareas:
   - Instalar las dependencias necesarias (por ejemplo, **npm install**).
   - Clonar o actualizar el código desde el repositorio Git.
   - Configurar **PM2** para ejecutar la aplicación como un proceso en segundo plano.
   - Asegurar que la aplicación se inicie automáticamente al reiniciar el servidor.

## Puntos adicionales (opcional)
- Diseñar arquitectura
- Implementa una función para configurar un servidor web (por ejemplo, **Nginx**) como proxy inverso para la aplicación React.
- Asegúrate de que el script sea robusto y maneje errores correctamente.

¡Buena suerte! 🚀
