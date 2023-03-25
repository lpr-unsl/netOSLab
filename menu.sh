#!/bin/bash
function inicializar {
   clear
   echo ""
   echo " 
         Antes de de proceder a la instalación debemos tener un disco de al menos 4GB o 
         una particion aparte, porque hacemos un borrado y formateo del mismo
        "
   echo ""
   echo -n "Quiere continuar? (S/N)"
   read continua
   if [ $continua != "S" ]
   then
      return 3
   fi
   echo ""
   echo "paso a listarte los dispositivo que se encuentran montados: "
   echo "-----------------------------------------------------"
   df -h 
   echo "-----------------------------------------------------"
   sleep 5
   echo ""
   echo "
         En caso de no estar recuerda de utiliza el comando fdisk -l 
         para ver todas las particiones
        "
   echo ""
   echo -n "Quieres Salir ? (S/N)"
   read continua
   if [ $continua != "S" ]
   then
      return 3
   fi 
   echo -n "especifique la version de contenedores de docker que se descargo para su instalacion: "
   read version_docker
   echo "Especifique el nombre del dispositivo a utilizar: "
   read dispositivo
   montaje=`df -h | egrep $dispositivo`
   if [ -n "$montaje" ]
   then
      unmount $dispositivo
   fi
   mkfs.ext4 $dispositivo
   service docker stop
   mount $dispositivo /var/lib/docker
   service docker start

   docker load < /root/Documents/images/servidor:$version_docker.tar.gz
   docker tag /sistemasoperativostur/servidor:$version_docker servidor:$version_docker
   echo "listo servidor"
   docker load < /root/Documents/images/cliente:$version_docker.tar.gz
   docker tag /sistemasoperativostur/cliente:$version_docker cliente:$version_docker
   echo "listo cliente"
   docker load < /root/Documents/images/cliente-cli:$version_docker.tar.gz
   docker tag /sistemasoperativostur/cliente-cli:$version_docker cliente-cli:$version_docker
   echo "listo cliente-cli"
   docker load < /root/Documents/images/router:$version_docker.tar.gz
   docker tag /sistemasoperativostur/router:$version_docker router:$version_docker
   echo "listo router"
   echo "$dispositivo" >> /home/instalacion.txt
   echo ""
   echo "Se completo la instalacion y los contenedores se encuentran corriendo"

}
function validacion_instalador {
    clear
    echo "-----------------------------------------------------"
    echo "-----------------------------------------------------"
    echo ""
    echo "  INSTALADOR APUL V1.0
        Aplicaciones Unificadas Laboratorio 
        Version 1.0
     "
    echo ""
    echo "-----------------------------------------------------"
    echo "-----------------------------------------------------"
    echo "Validamos si los contenedores de docker estan levantados ee instalados"
    echo ""
    echo ""
    echo ""
    sleep 5
    buscar_creacion=`grep -wiR instalacion /home/instalacion.txt`
    if [ -z $buscar_creacion ]
    then
        inicializar
        var=$?
        if [ $var -ne 3 ]
        then
         echo "instalacion" >> /home/instalacion.txt
        fi 
    else
         echo ""
         echo "
               Ya se encuentra instalado los instaladores de docker, puedes proceder a utilizar los programas
             "
         echo ""
         sleep 3
    fi
}
function manejo_practico_sinGUI_lpr {
    clear
    practico=$1
    echo "-----------------------------------------------------"
    echo "Bienvenido al practico $1"
    echo "-----------------------------------------------------"
    echo "Se procede abrir el practico"
    dispositivo=`tail -n1 /home/instalacion.txt`
    sleep 3
    /root/Documents/ssor/$1/iniciar.sh $dispositivo
    clear
    echo "Elige la opcion que corresponda"
    echo "Opcion 1: Terminar el practico $1"
    echo "Opcion 2: Pausar el practico $1"
    echo "Opcion 3: Exportar el practico $1"
    echo "Opcion 4: Importar el practico $1"
    read opciones
    until [ $opcion -le 4 ] && [ $opcion -ge 1 ]
    do
        clear 
        echo "Opcion incorrecta, por favor Ingrese una opción valida"
        read opcion
    done
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
    clear
    echo "-----------------------------------------------------------"
    echo "Bienvenido al programa de LPR (Laboratorio Portatil Redes)"
    echo "-----------------------------------------------------------"
    echo "Opcion 1: Ingresar al practico DHCP "
    echo "Opcion 2: Ingresar al practico DNS "
    echo "Opcion 3: Ingresar al practico FIREWALL"
    echo "Opcion 4: Ingresar al practico HTTP"
    echo "Opcion 5: Ingresar al practico SMB"
    echo "Opcion 6: Ingresar al practico SMTP"
    echo "Opcion 7: Ingresar al practico SQUID"
    echo "Opcion 8: Ingresar al practico VPN"
    echo "Opcion 0: Salir de LPR -Sin interfaz Grafica-"
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
        0) echo "se procede salir de LPR"
           menu_general
        ;;
    esac

}
function menu_general {
    clear
    echo "########################################################################"
    echo "------------------------------------------------------------------------"
    echo "------------------------------------------------------------------------"
    echo ""
    echo "Bienvenidos a APUL V1.0"
    echo ""
    echo "------------------------------------------------------------------------"
    echo "------------------------------------------------------------------------"
    echo "Aca se podra acceder a la distintas aplicaciones creadas" 
    echo "dentro de la Universidad Nacional de San Luis -UNSL-"
    echo "########################################################################"
    echo "Se procede a mostrar el menu"
    echo "Opcion 1: Ingresar a LPR (Laboratorio Portatil de Redes)"
    echo "Opcion 2: Ingresar a EliaNS (Diseniador Grafico de Topologias de red)"
    echo "Opcion 3: Ingresar a SimMemoria (Simulador de Memoria)"
    echo "Opcion 4: Ingresar a SimPlanificador (Simulacion Planificacion Procesos)"
    echo "Opcion 0: Salir de APUL V1.0"
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
        3) cd /root/MMemAplicationPro/dist; java -jar MemApplication.jar
           menu_general
        ;;
        4) java -jar /root/SimPlanificador/PS.jar
           menu_general
        ;;
        0) echo "se procede salir de APUL V1.0"
        exit
        ;;
    esac
}
validacion_instalador
menu_general
