#!/bin/bash
if [ -z "$1" ]
then
	echo " ingresar el directorio de exportacion ........ es necesario:"
	docker images  --format "table {{.Repository}} \t   {{  .Size}} "| egrep http
	exit 
fi
docker save -o $1/http-latoma.tar http-latoma 
gzip $1/http-latoma.tar 
echo "listo latoma"
docker save -o $1/http-merlo.tar http-merlo
gzip $1/http-merlo.tar
echo "listo merlo"
docker save -o $1/http-potrero.tar http-potrero
gzip $1/http-potrero.tar
echo "listo potrero"
docker save -o $1/http-laflorida.tar http-laflorida
gzip $1/http-laflorida.tar
echo "listo laflorida"
docker save -o $1/http-desaguadero.tar http-desaguadero
gzip $1/http-desaguadero.tar
echo "listo desaguadero"
docker save -o $1/http-nogoli.tar http-nogoli
gzip $1/http-nogoli.tar
echo "listo nogoli"
docker save -o $1/http-carrizal.tar http-carrizal
gzip $1/http-carrizal.tar
echo "listo carrizal"
docker save -o $1/http-laslenias.tar http-laslenias
gzip $1/http-laslenias.tar
echo "listo laslenias"



#para saber los nombres de los contenedores que estan corriendo
# docker ps  --format "table {{.Names}}"
