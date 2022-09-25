#!/bin/bash

##Carpeta sistemasoperativostur
function validacion_instalacion(){
    ya_instalado=''
    if $1 != 'instalado_docker'
    then
     echo "antes de iniciar alguna aplicación vimos que no tenes instalado "
}
echo "#############################################################################################################"
echo "-----------------------------"
echo "-----------------------------"
echo ""
echo "Bienvenidos a LPR Integrado V1.0"
echo ""
echo "-----------------------------"
echo "-----------------------------"
echo "Acá se podra acceder a la distintas aplicadas creadas dentro de la Universidad Nacional de San Luis (UNSL)"
echo "#############################################################################################################"
echo "Se procede a mostrar el menu"
echo "Opcion 1: Ingresar a LPR Sin Interfaz grafica"
echo "Opcion 2: Ingresar a EliaNS (LPR con intefaz grafica)"
echo "Opcion 3: Ingresar a SimMemoria"
echo "Opcion 4: Ingresar a SimPlanificador"
echo "Opcion 0: Salir del Menu"
echo ""
echo ""
echo "Por favor ingrese la opción que quiere"
read opcion
until [$opcion -le 4 ] && [ $opcion -ge 0 ]
do
    echo "Opcion incorrecta, por favor Ingrese una opción valida"
    read opcion
done
variable_instalacion=`echo $docker_instalado`



case $opcion in 
    1)
    ;;
    2) cd /root/EliaNS/;export CLASSPATH=Simlador.jar:$CLASSPATH;javac visual.java;java visual
    ;;
    3) java -jar /root/MemApplication/MemApplication.jar
    ;;
    4) java -jar /root/SimPlanificador/PS.jar
    ;;
    0) echo "se procede salir de LPR Integrado V1.0"
       exit
    ;;
esac


