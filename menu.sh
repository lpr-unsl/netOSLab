#!/bin/bash
function validacion_instalador {
    echo "-----------------------------------------------------"
    echo "-----------------------------------------------------"
    echo ""
    echo "Bienvenidos a LPR Integrado V1.0"
    echo ""
    echo "-----------------------------------------------------"
    echo "-----------------------------------------------------"
    echo "Validamos si los contenedores de docker estan levantados"
    echo ""
    echo ""
    echo ""
    buscar_creacion=`grep -wiR instalacion /home/instalacion.txt`
    if [ -z $buscar_creacion ]
    then
        echo "instalacion" >> /home/instalacion.txt
        /root/Documents/inicializar.sh
    else
        echo "Ya se encuentra inicialializado los contenedores de docker, puedes ejecutar los programas"
    fi
}
function manejo_practico_sinGUI_lpr {
    practico=$1
    echo "-----------------------------------------------------"
    echo "Bienvenido al practico $1"
    echo "-----------------------------------------------------"
    echo "Se procede abrir el practico"
    sleep 3
    /root/Documents/ssor/$1/iniciar.sh
    echo "Elige la opcion que corresponda"
    echo "Opcion 1: Terminar el practico $1"
    echo "Opcion 2: Pausar el practico $1"
    echo "Opcion 3: Exportar el practico $1"
    echo "Opcion 4: Importar el practico $1"
    read opciones
    case $opciones in
        1) /root/Documents/ssor/$1/terminar.sh
        ;;
        2) /root/Documents/ssor/$1/pausar.sh
        ;;
        3) /root/Documents/ssor/$1/exportar.sh
        ;;
        4) /root/Documents/ssor/$1/importar.sh
        ;;
    esac

}
function sin_interfaz_lpr {
    echo "-----------------------------------------------------"
    echo "Bienvenido al programa de LPR -Sin interfaz Grafica"
    echo "-----------------------------------------------------"
    echo "Opcion 1: Ingresar al practico DHCP "
    echo "Opcion 2: Ingresar al practico DNS "
    echo "Opcion 3: Ingresar al practico FIREWALL"
    echo "Opcion 4: Ingresar al practico HTTP"
    echo "Opcion 5: Ingresar al practico SMB"
    echo "Opcion 6: Ingresar al practico SMTP"
    echo "Opcion 7: Ingresar al practico SQUID"
    echo "Opcion 8: Ingresar al practico VPN"
    echo "Opcion 0: Salir de LPR -Sin interfaz Grafica"
    read opcion
    case $opcion in
        1) manejo_practico_sinGUI_lpr "dhcp"
           sin_interfaz_lpr
        ;;
        2) manejo_practico_sinGUI_lpr "dns"
           sin_interfaz_lpr
        ;;
        3) manejo_practico_sinGUI_lpr "firewall"
           sin_interfaz_lpr
        ;;
        4) manejo_practico_sinGUI_lpr "http"
           sin_interfaz_lpr
        ;;
        5) manejo_practico_sinGUI_lpr "smb"
           sin_interfaz_lpr
        ;;
        6) manejo_practico_sinGUI_lpr "smtp"
           sin_interfaz_lpr
        ;;
        7) manejo_practico_sinGUI_lpr "squid"
           sin_interfaz_lpr
        ;;
        8) manejo_practico_sinGUI_lpr "vpn"
           sin_interfaz_lpr
        ;;
        0) echo "se procede salir de LPR Sin interfaz"
           exit
        ;;
    esac

}
function menu_general{
    echo "#####################################################"
    echo "-----------------------------------------------------"
    echo "-----------------------------------------------------"
    echo ""
    echo "Bienvenidos a LPR Integrado V1.0"
    echo ""
    echo "-----------------------------------------------------"
    echo "-----------------------------------------------------"
    echo "Aca se podra acceder a la distintas aplicaciones creadas" 
    echo "dentro de la Universidad Nacional de San Luis (UNSL)"
    echo "######################################################"
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
    until [ $opcion -le 4 ] && [ $opcion -ge 0 ]
    do
        echo "Opcion incorrecta, por favor Ingrese una opción valida"
        read opcion
    done
    case $opcion in 
        1) sin_interfaz_lpr
           menu_general
        ;;
        2) cd /root/EliaNS/;export CLASSPATH=Simlador.jar:$CLASSPATH;javac visual.java;java visual
           menu_general
        ;;
        3) java -jar /root/MemApplication/MemApplication.jar
           menu_general
        ;;
        4) java -jar /root/SimPlanificador/PS.jar
           menu_general
        ;;
        0) echo "se procede salir de LPR Integrado V1.0"
        exit
        ;;
    esac
}
validacion_instalador
menu_general