
docker stop $(docker ps -aq)


docker commit latoma smtp-latoma
docker commit potrero smtp-potrero
docker commit laflorida smtp-laflorida
docker commit desaguadero smtp-desaguadero
docker commit carrizal smtp-carrizal
docker commit laslenias smtp-laslenias


docker rm $(docker ps -aq)

#para saber los nombres de los contenedores que estan corriendo
# docker ps  --format "table {{.Names}}"
