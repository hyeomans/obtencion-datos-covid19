#!/bin/bash

file_curl="datos_abiertos_covid19.zip"
fecha_ayer=$(date -d "yesterday 14:00" '+%y%m%d')

file_dia_ayer="${fecha_ayer}COVID19MEXICO.csv"

if [ -f $file_dia_ayer ]; then
  echo "El archivo $file_dia_ayer ya existe, no lo volveremos a bajar."
else
  echo "Archivo $file_dia_ayer no existe, lo bajaremos con curl"
  curl -O -L -C - http://datosabiertos.salud.gob.mx/gobmx/salud/datos_abiertos/datos_abiertos_covid19.zip
  unzip $file_curl && rm $file_curl
fi

declare -A arr

arr["01"]=AGUASCALIENTES
arr["02"]=BAJA_CALIFORNIA
arr["03"]=BAJA_CALIFORNIA_SUR
arr["04"]=CAMPECHE
arr["05"]=COAHUILA_DE_ZARAGOZA
arr["06"]=COLIMA
arr["07"]=CHIAPAS
arr["08"]=CHIHUAHUA
arr["09"]=CIUDAD_DE_MÉXICO
arr["10"]=DURANGO
arr["11"]=GUANAJUATO
arr["12"]=GUERRERO
arr["13"]=HIDALGO
arr["14"]=JALISCO
arr["15"]=MÉXICO
arr["16"]=MICHOACÁN_DE_OCAMPO
arr["17"]=MORELOS
arr["18"]=NAYARIT
arr["19"]=NUEVO_LEÓN
arr["20"]=OAXACA
arr["21"]=PUEBLA
arr["22"]=QUERÉTARO
arr["23"]=QUINTANA_ROO
arr["24"]=SAN_LUIS_POTOSÍ
arr["25"]=SINALOA
arr["26"]=SONORA
arr["27"]=TABASCO
arr["28"]=TAMAULIPAS
arr["29"]=TLAXCALA
arr["30"]=VERACRUZ_DE_IGNACIO_DE_LA_LLAVE
arr["31"]=YUCATÁN
arr["32"]=ZACATECAS
arr["36"]=ESTADOS_UNIDOS_MEXICANOS
arr["97"]=NO_APLICA
arr["98"]=SE_IGNORA
arr["99"]=NO_ESPECIFICADO

for key in ${!arr[@]}; do
    echo "Procesando la Entidad de (${key}) ${arr[${key}]}..."
    csvcut -c EMBARAZO,EDAD,TIPO_PACIENTE,ENTIDAD_RES,CLASIFICACION_FINAL 210421COVID19MEXICO.csv |\
    csvgrep -c ENTIDAD_RES -m ${key} |\
    csvgrep -c TIPO_PACIENTE -m 2 |\
    csvgrep -c EMBARAZO -m 1 |\
    csvgrep -c CLASIFICACION_FINAL -r "^1|2|3$" |\
    csvstat -c EDAD,CLASIFICACION_FINAL > "${arr[${key}]}.txt"
done