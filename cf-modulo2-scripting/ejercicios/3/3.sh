#!/bin/bash

TASK_FILE="tasks.txt"


agregar_tarea() {
    echo -n
    echo -n "Ingrese la descripción de la tarea: "
    read descripcion
    echo -n "Ingrese la fecha de vencimiento (formato YYYY-MM-DD): "
    read fecha
    tarea_id=$(date +%s) 
    echo "$tarea_id|$descripcion|$fecha" >> "$TASK_FILE"
    echo "Tarea agregada con éxito. Identificador de tarea: $tarea_id"
}


listar_tareas() {
    echo -n "Tareas pendientes:"
    while IFS="|" read -r id desc fecha; do
        echo "ID: $id | Descripción: $desc | Fecha de vencimiento: $fecha"
    done < "$TASK_FILE"
}


marcar_completada() {
    echo -n "Ingrese el identificador de la tarea a marcar como completada: "
    read tarea_id
    sed -i "/^$tarea_id/d" "$TASK_FILE"
    echo "Tarea marcada como completada."
}


eliminar_tarea() {
    echo -n "Ingrese el identificador de la tarea a eliminar: "
    read tarea_id
    sed -i "/^$tarea_id/d" "$TASK_FILE"
    echo "Tarea eliminada con éxito."
}

# Menú principal
while true; do
    echo "=== Sistema de Gestión de Tareas ==="
    echo "1. Agregar Tarea"
    echo "2. Listar Tareas"
    echo "3. Marcar Tarea como Completada"
    echo "4. Eliminar Tarea"
    echo "5. Salir del Programa"
    echo -n "Seleccione una opción: "
    read opcion

    case "$opcion" in
        1) agregar_tarea ;;
        2) listar_tareas ;;
        3) marcar_completada ;;
        4) eliminar_tarea ;;
        5) echo "¡Hasta luego!"; exit ;;
        *) echo "Opción inválida. Intente nuevamente." ;;
    esac
done
