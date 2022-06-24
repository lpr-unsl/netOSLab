#!/bin/bash
if [ -z "$1" ]
then
	echo " ingresar el directorio de exportacion ........ es necesario:"
	docker images  --format "table {{.Repository}} \t   {{  .Size}} "| egrep dns
	exit 
fi
docker save -o $1/dns-latoma.tar dns-latoma 
gzip $1/dns-latoma.tar 
echo "listo latoma"
docker save -o $1/dns-laflorida.tar dns-laflorida
gzip $1/dns-laflorida.tar
echo "listo laflorida"
docker save -o $1/dns-nogoli.tar dns-nogoli
gzip $1/dns-nogoli.tar
echo "listo nogoli"
docker save -o $1/dns-desaguadero.tar dns-desaguadero
gzip $1/dns-desaguadero.tar
echo "listo desaguadero"
docker save -o $1/dns-potrero.tar dns-potrero
gzip $1/dns-potrero.tar
echo "listo potrero"
docker save -o $1/dns-merlo.tar dns-merlo
gzip $1/dns-merlo.tar
echo "listo merlo"


#para saber los nombres de los contenedores que estan corriendo
# docker ps  --format "table {{.Names}}"
