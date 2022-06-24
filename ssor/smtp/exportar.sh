#!/bin/bash
if [ -z "$1" ]
then
	echo " ingresar el directorio de exportacion ........ es necesario:"
	docker images  --format "table {{.Repository}} \t   {{  .Size}} "| egrep smtp
	exit 
fi
docker save -o $1/smtp-latoma.tar smtp-latoma 
gzip $1/smtp-latoma.tar 
echo "listo latoma"
docker save -o $1/smtp-potrero.tar smtp-potrero
gzip $1/smtp-potrero.tar
echo "listo potrero"
docker save -o $1/smtp-laflorida.tar smtp-laflorida
gzip $1/smtp-laflorida.tar
echo "listo laflorida"
docker save -o $1/smtp-desaguadero.tar smtp-desaguadero
gzip $1/smtp-desaguadero.tar
echo "listo desaguadero"
docker save -o $1/smtp-carrizal.tar smtp-carrizal
gzip $1/smtp-carrizal.tar
echo "listo carrizal"
docker save -o $1/smtp-laslenias.tar smtp-laslenias
gzip $1/smtp-laslenias.tar
echo "listo laslenias"



#para saber los nombres de los contenedores que estan corriendo
# docker ps  --format "table {{.Names}}"
