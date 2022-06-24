
docker stop $(docker ps -aq)


docker commit latoma dns-latoma
docker commit laflorida dns-laflorida
docker commit nogoli dns-nogoli
docker commit desaguadero dns-desaguadero
docker commit potrero dns-potrero
docker commit merlo dns-merlo



docker rm $(docker ps -aq)

#para saber los nombres de los contenedores que estan corriendo
# docker ps  --format "table {{.Names}}"
