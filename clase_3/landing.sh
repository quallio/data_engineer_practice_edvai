#!/bin/bash

# Variables
TEMP_DIR="/home/hadoop/landing"
HDFS_DIR="/ingest"
FILE_NAME="starwars.csv"
URL="https://raw.githubusercontent.com/fpineyro/homework-0/master/starwars.csv"

# Crear el directorio temporal si no existe
mkdir -p $TEMP_DIR

# Descargar el archivo al directorio temporal
echo "Descargando $FILE_NAME..."
wget -q -O $TEMP_DIR/$FILE_NAME $URL

# Verificar si la descarga fue exitosa
if [[ -f $TEMP_DIR/$FILE_NAME ]]; then
    echo "Archivo descargado exitosamente."

    # Mover el archivo al HDFS
    echo "Moviendo $FILE_NAME al HDFS..."
    hdfs dfs -mkdir -p $HDFS_DIR
    hdfs dfs -put $TEMP_DIR/$FILE_NAME $HDFS_DIR/

    # Verificar si el archivo fue movido exitosamente al HDFS
    if hdfs dfs -test -e $HDFS_DIR/$FILE_NAME; then
        echo "Archivo movido exitosamente a $HDFS_DIR."

        # Eliminar el archivo del directorio temporal
        echo "Eliminando archivo temporal..."
        rm $TEMP_DIR/$FILE_NAME
        echo "Archivo temporal eliminado."
    else
        echo "Error: No se pudo mover el archivo a HDFS."
    fi
else
    echo "Error: No se pudo descargar el archivo."
fi
