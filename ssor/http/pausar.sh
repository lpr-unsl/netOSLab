
docker stop $(docker ps -aq)


docker commit latoma http-latoma
docker commit merlo http-merlo
docker commit potrero http-potrero
docker commit laflorida http-laflorida
docker commit desaguadero http-desaguadero
docker commit nogoli http-nogoli
docker commit carrizal http-carrizal
docker commit laslenias http-laslenias


docker rm $(docker ps -aq)

#para saber los nombres de los contenedores que estan corriendo
# docker ps  --format "table {{.Names}}"
