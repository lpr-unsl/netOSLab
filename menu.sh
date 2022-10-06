#!/bin/bash
function validacion_instalador {
    echo "-------------------------------------------------------------------------------------------------------------"
    echo "-------------------------------------------------------------------------------------------------------------"
    echo ""
    echo "Bienvenidos a LPR Integrado V1.0"
    echo ""
    echo "-------------------------------------------------------------------------------------------------------------"
    echo "-------------------------------------------------------------------------------------------------------------"
    echo "Validamos si los contenedores de docker estan levantados"
    echo ""
    echo ""
    echo ""
    buscar_creacion=`grep -wiR instalacion /home/instalacion.txt`
    if [ -z $buscar_creacion ]
    then
        echo "instalacion" >> /home/instalacion.txt
        ./root/Documents/inicializar.sh
    else
        echo "Ya se encuentra inicialializado los contenedores de docker, puedes ejecutar los programas"
    fi
}
function manejo_practico_sinGUI_lpr {
    practico=$1
    echo "-------------------------------------------------------------------------------------------------------------"
    echo "Bienvenido al practico $1"
    echo "-------------------------------------------------------------------------------------------------------------"
    echo "Se procede abrir el practico"
    sleep 3
    ./root/Documents/ssor/$1/iniciar.sh
    echo "Elige la opcion que corresponda"
    echo "Opcion 1: Terminar el practico $1"
    echo "Opcion 2: Pausar el practico $1"
    echo "Opcion 3: Exportar el practico $1"
    echo "Opcion 4: Importar el practico $1"
    read opciones
    case $opciones in
        1) ./root/Documents/ssor/$1/terminar.sh
           exit
        ;;
        2) ./root/Documents/ssor/$1/pausar.sh
           exit
        ;;
        3) ./root/Documents/ssor/$1/exportar.sh
           exit
        ;;
        4) ./root/Documents/ssor/$1/importar.sh
           exit
        ;;
    esac

}
function sin_interfaz_lpr {
    echo "-------------------------------------------------------------------------------------------------------------"
    echo "Bienvenido al programa de LPR -Sin interfaz Grafica"
    echo "-------------------------------------------------------------------------------------------------------------"
    echo "Opcion 1: Ingresar al practico DHCP "
    echo "Opcion 2: Ingresar al practico DNS "
    echo "Opcion 3: Ingresar al practico FIREWALL"
    echo "Opcion 4: Ingresar al practico HTTP"
    echo "Opcion 5: Ingresar al practico SMB"
    echo "Opcion 6: Ingresar al practico SMTP"
    echo "Opcion 7: Ingresar al practico SQUID"
    echo "Opcion 8: Ingresar al practico VPN"
    echo "Opcion 0: Salir de LPR -Sin interfaz Grafica"
    case $opcion in
        1) sin_interfaz_lpr "dhcp"
        ;;
        2) sin_interfaz_lpr "dns"
        ;;
        3) sin_interfaz_lpr "firewall"
        ;;
        4) sin_interfaz_lpr "http"
        ;;
        5) sin_interfaz_lpr "smb"
        ;;
        6) sin_interfaz_lpr "smtp"
        ;;
        7) sin_interfaz_lpr "squid"
        ;;
        8) sin_interfaz_lpr "vpn"
        ;;
        0) echo "se procede salir de LPR Sin interfaz"
           exit
        ;;
    esac

}
validacion_instalador
echo "#############################################################################################################"
echo "-------------------------------------------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------------------------------------------"
echo ""
echo "Bienvenidos a LPR Integrado V1.0"
echo ""
echo "-------------------------------------------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------------------------------------------"
echo "Acá se podra acceder a la distintas aplicaciones creadas dentro de la Universidad Nacional de San Luis (UNSL)"
echo "#############################################################################################################"
echo "Se procede a mostrar el menu"
echo "Opcion 1: Ingresar a LPR Sin Interfaz grafica"
echo "Opcion 2: Ingresar a EliaNS (LPR con intefaz grafica)"
echo "Opcion 3: Ingresar a SimMemoria"
echo "Opcion 4: Ingresar a SimPlanificador"
echo "Opcion 0: Salir de LPR Integrado V1.0"
echo ""
echo ""
echo "Por favor ingrese la opción que quiere"
read opcion
until [$opcion -le 4 ] && [ $opcion -ge 0 ]
do
    echo "Opcion incorrecta, por favor Ingrese una opción valida"
    read opcion
done
case $opcion in 
    1) sin_interfaz_lpr
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


