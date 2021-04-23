## Descripción

Esta imagen de Docker nos permite:

* Bajar la [base de datos COVID-19](https://www.gob.mx/salud/documentos/datos-abiertos-152127) del día anterior por parte de dirección general de epidemiología de México.
* Conocer las estadísticas de **mujeres embarazadas positivas covid-19 que fueron hospitalizadas**
* Las estadísticas se generan por entidad federativa

Este es un ejemplo de las estadísticas presentadas:

**Ciudad de México al día 22 Abril 2021**

```
  2. "EDAD"

	Type of data:          Number
	Contains null values:  False
	Unique values:         35
	Smallest value:        15
	Largest value:         80
	Sum:                   7701
	Mean:                  30.927711
	Median:                31
	StDev:                 7.364556
	Most common values:    28 (19x)
	                       31 (18x)
	                       30 (18x)
	                       29 (15x)
	                       32 (15x)

  5. "CLASIFICACION_FINAL"

	Type of data:          Number
	Contains null values:  False
	Unique values:         2
	Smallest value:        1
	Largest value:         3
	Sum:                   715
	Mean:                  2.871486
	Median:                3
	StDev:                 0.491408
	Most common values:    3 (233x)
	                       1 (16x)

Row count: 249
```

## Clasificación final

La clasificación final es dada por la misma dirección de epidemiología. Se puede encontrar en el documento `Diccionario de datos`

| CLAVE | CLASIFICACIÓN                                                     | DESCRIPCIÓN                                                                                                                                                                                                      |
|-------|-------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 1     | CASO DE COVID-19 CONFIRMADO POR ASOCIACIÓN CLÍNICA EPIDEMIOLÓGICA | "Confirmado por asociación aplica cuando el caso informó ser contacto de un positivo a COVID-19 (y este se encuentra registrado en el SISVER) y: Al caso no se le tomo muestra o la muestra resultó no válida. " |
| 2     | CASO DE COVID-19 CONFIRMADO POR COMITÉ DE  DICTAMINACIÓN          | "Confirmado por dictaminación solo aplica para defunciones bajo las siguientes condiciones:  Al caso no se le tomo muestra o sí se tomó muestra, pero la muestra resultó no válida. "                            |
| 3     | CASO DE SARS-COV-2  CONFIRMADO                                    | "Confirmado aplica cuando: El caso tiene muestra de laboratorio o prueba antigénica y resultó positiva  a SARS-CoV-2, sin importar si el caso tienen asociación clínica epidemiológica."                         |


## Usar imagen de Docker

Para utilizar esta imagen, se necesita:

* Tener [Docker](https://docs.docker.com/get-docker/) instalado localmente
* Hacer [clone de este repositorio](git@github.com:hyeomans/obtencion-datos-covid19.git)
* Construir la imagen de docker
* Correr la imagen de docker

### Correr imagen de docker

Primero vamos a clonar el repositorio:

```
> git clone git@github.com:hyeomans/obtencion-datos-covid19.git && cd obtencion-datos-covid19
```

Después construimos la imagen de docker con el siguiente comando:

```
> docker build -t datos:1 .
```

Y por último corremos la imagen de docker (este paso tomará tiempo):

```
> docker run -it -v ${pwd}/datos:/home/datos datos:1
```

Se creará un nuevo directorio con:

* El archivo CSV que contiene los datos covid19 del día de ayer.
* Archivos de texto con información por entidad.
