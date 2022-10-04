#!/bin/bash
echo "-----------------------------"
echo "-----------------------------"
echo ""
echo "INSTALADOR LPR INTEGRADO V1.0"
echo ""
echo "-----------------------------"
echo "-----------------------------"
echo "Comenzamos con la instalación de los requisitos minimos para LPR"
echo "----------------------------------------------------------------"
echo "----------------------------------------------------------------∫"
function saltolinea {
    for ((i=1; i<3; i++))
    do
     echo "" >>/root/errores.log>>/root/instalacion.log
    done
}
function progreso_instalacion {
    echo "---------------------" >>/root/errores.log>>/root/instalacion.log
    echo "" >>/root/errores.log>>/root/instalacion.log
}
function validacion_variable  {
    if [ -z $buscar_creacion ]
    then
        if [ $usuario_actual != "root" ]
        then
            
            echo "Comienza la instalación"
            echo "Habilitamos el usuario root con password lpr"
            echo "root:lpr"|  sudo chpasswd
            echo "--------------------------------------------------------------------"
            echo "por favor deslogueate y logueate con el usuario: root password: lpr "
            echo "--------------------------------------------------------------------"
            sudo echo "rootcreado" > /home/instalacion.txt
            return 0
        else
            echo "Comienza la instalación"
            echo "Habilitamos el usuario root con password lpr"
            echo "root:lpr"| sudo chpasswd
            echo "--------------------------------------------------------------------"
            echo "por favor deslogueate y logueate con el usuario: root password: lpr "
            echo "--------------------------------------------------------------------"
            echo "rootcreado" > /home/instalacion.txt
            return 0
        fi
    else
        return 2
    fi
}
function val_create_user_root {
    usuario_actual=`users`
    if [ $usuario_actual = "root" ]
    then
        touch /home/instalacion.txt
        buscar_creacion=`grep -wiR rootcreado /home/instalacion.txt`
        validacion_variable $buscar_creacion $usuario_actual
        return $?
    else
        sudo touch /home/instalacion.txt
        buscar_creacion=`grep -wi rootcreado /home/instalacion.txt`
        validacion_variable $buscar_creacion $usuario_actual
        return $?
}
validacion=val_create_user_root
if [ $validacion -eq 0 ]
then
  exit 0
elif [ $usuario_actual = "root" ]
then
    echo "Continuamos con la instalación ya que configuramos el usuario root"
    echo "actualizacion sistema" >>/root/errores.log>>/root/instalacion.log
    progreso_instalacion
    apt update && upgrade -y 2>>/root/errores.log 1>>/root/instalacion.log
    echo "Fin de actualización del sistema"
    saltolinea
    echo "clonamos el repositorio donde se encuentran todas las configuraciones"
    git clone https://github.com/lpr-unsl/netOSLab.git /root/configuracion_sistema 2>>/root/errores.log 1>>/root/instalacion.log
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "comienza la instalación de la interfaz grafica xfce4"
    echo "Elegir la opción lightdm, más tab + enter para que se aplique los cambios"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "Instalacion xfce4" >>/root/errores.log>>/root/instalacion.log
    progreso_instalacion
    apt install xfce4-panel xfwm4 xfce4-session xfce4-terminal xfdesktop4 lightdm-gtk-greeter
    echo "Se termino la instalacion xfce4"
    saltolinea
    echo "Comenzamos con la actualización e instalación minima para LPR"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "actualización dependencias" >>/root/errores.log>>/root/instalacion.log
    progreso_instalacion
    apt install apt-transport-https ca-certificates curl software-properties-common -y 2>>/root/errores.log 1>>/root/instalacion.log
    saltolinea
    echo "creación archivo docker.list" >>/root/errores.log>>/root/instalacion.log
    progreso_instalacion
    touch /etc/apt/sources.list.d/docker.list
    echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" >> /etc/apt/sources.list.d/docker.list 2>>/root/errores.log 1>>/root/instalacion.log
    saltolinea
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
    sleep 3
    apt-get update -y 2>>/root/errores.log 1>>/root/instalacion.log
    echo "instalación docker" >>/root/errores.log>>/root/instalacion.log
    progreso_instalacion
    apt install docker-ce -y 2>>/root/errores.log 1>>/root/instalacion.log
    saltolinea
    #poniendo en servicio docker
    systemctl start docker
    systemctl enable docker
    #Permitiendo el trafico de docker
    iptables -P INPUT ACCEPT
    iptables -P FORWARD ACCEPT
    iptables -P OUTPUT ACCEPT
    echo "configuracion firewall depués de permitir el trafico"  >>/root/errores.log>>/root/instalacion.log
    progreso_instalacion
    iptables -L -nv 2>>/root/errores.log 1>>/root/instalacion.log
    saltolinea
    echo "instalar xterm" >>/root/errores.log>>/root/instalacion.log
    progreso_instalacion
    apt install xterm -y 2>>/root/errores.log 1>>/root/instalacion.log
    saltolinea
    echo "instalar brigde utils"  >>/root/errores.log>>/root/instalacion.log
    progreso_instalacion
    apt-get install bridge-utils -y 2>>/root/errores.log 1>>/root/instalacion.log
    saltolinea
    echo "instalar iputil arping"  >>/root/errores.log>>/root/instalacion.log
    progreso_instalacion
    apt install iputils-arping -y 2>>/root/errores.log 1>>/root/instalacion.log
    saltolinea
    echo "instalar arping" >>/root/errores.log>>/root/instalacion.log
    progreso_instalacion
    apt install arping -y 2>>/root/errores.log 1>>/root/instalacion.log
    saltolinea
    echo "instalar wireshark" >>/root/errores.log>>/root/instalacion.log
    progreso_instalacion
    apt install wireshark -y 2>>/root/errores.log 1>>/root/instalacion.log
    saltolinea
    echo "instalar samba"  >>/root/errores.log>>/root/instalacion.log
    progreso_instalacion
    apt install samba -y 2>>/root/errores.log 1>>/root/instalacion.log
    saltolinea
    echo "instalar smbclient" >>/root/errores.log>>/root/instalacion.log
    progreso_instalacion
    apt install smbclient -y 2>>/root/errores.log 1>>/root/instalacion.log
    saltolinea
    echo "instalar cifs-utils" >>/root/errores.log>>/root/instalacion.log
    progreso_instalacion
    apt install cifs-utils -y 2>>/root/errores.log 1>>/root/instalacion.log
    saltolinea
    echo "instalar vsftpd" >>/root/errores.log>>/root/instalacion.log
    progreso_instalacion
    apt install vsftpd -y 2>>/root/errores.log 1>>/root/instalacion.log
    saltolinea
    echo "instalar telnet" >>/root/errores.log>>/root/instalacion.log
    progreso_instalacion
    apt install telnetd -y 2>>/root/errores.log 1>>/root/instalacion.log
    saltolinea
    echo "borrado de inet.confg y clonado archivo" >>/root/errores.log>>/root/instalacion.log
    rm /etc/inetd.conf 2>>/root/errores.log 1>>/root/instalacion.log
    cp /root/configuracion_sistema/configuracion/Herramientas/TELNET/inetd.conf /etc/
    saltolinea
    echo "instalar nfs-kernel-server" >>/root/errores.log>>/root/instalacion.log
    progreso_instalacion
    apt install nfs-kernel-server -y  2>>/root/errores.log 1>>/root/instalacion.log
    saltolinea
    echo "instalar nfs-common" >>/root/errores.log>>/root/instalacion.log
    progreso_instalacion
    apt install nfs-common -y 2>>/root/errores.log 1>>/root/instalacion.log
    saltolinea
    echo "instalar dillo" >>/root/errores.log>>/root/instalacion.log
    progreso_instalacion
    apt install dillo -y
    saltolinea
    echo "instalacion systemback" >>/root/errores.log>>/root/instalacion.log
    progreso_instalacion
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 382003C2C8B7B4AB813E915B14E4942973C62A1B 2>>/root/errores.log 1>>/root/instalacion.log
    add-apt-repository "deb http://ppa.launchpad.net/nemh/systemback/ubuntu xenial main" 2>>/root/errores.log 1>>/root/instalacion.log
    apt update && apt upgrade -y 2>>/root/errores.log 1>>/root/instalacion.log
    apt install systemback -y 2>>/root/errores.log 1>>/root/instalacion.log
    saltolinea
    echo "Se termino la instalación de las herramientas necesarias para poder tener LPR"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    sleep 3
    echo "realizamos el cambio de zona hoaria"
    cp /usr/share/zoneinfo/America/Mendoza /etc/localtime
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "comienza el clonado de los sistemas"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "copiamos pipework"
    echo "clonación pipework" >>/root/errores.log>>/root/instalacion.log
    progreso_instalacion
    git clone https://github.com/jpetazzo/pipework.git /usr/local/bin 2>>/root/errores.log 1>>/root/instalacion.log
    saltolinea
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "copiamos lpr" 
    echo "clonar lpr" >>/root/errores.log>>/root/instalacion.log
    git clone https://github.com/lpr-unsl/lpr.git /root/Documents 2>>/root/errores.log 1>>/root/instalacion.log
    saltolinea
    apt install net-tools -y 
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "configuramos ssh para que se pueda loguear como root"
    echo "configuramos ssh para que se pueda loguear como root" >>/root/errores.log>>/root/instalacion.log
    progreso_instalacion
    rm /etc/ssh/sshd_config  2>>/root/errores.log 1>>/root/instalacion.log
    cp /root/configuracion_sistema/configuracion/Herramientas/SSH/sshd_config /etc/ssh/
    echo "comprobamos que se haya copiado sshd_config y restauramos el servicio"
    echo "---------------------------------------------------------------------"
    ls -l /etc/ssh/
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    sleep 3
    saltolinea
    service ssh restart
    read -p "indique la versión de los contenedores de docker: " version_docker
    echo "se va a realizar la instalación con la versión mencionada: $version_docker"
    for image in router servidor cliente-cli cliente 
    do
        docker pull sistemasoperativostur/$image:$version_docker
        docker save sistemasoperativostur/$image:$version_docker -o $image\:$version_docker.tar
        gzip $image\:$version_docker.tar
        docker rmi sistemasoperativostur/$image:$version_docker
    done
    sleep 2
    echo "Procedemos a mover las copias descargadas de docker recientemente a la carpeta Documents"
    mv ./cliente-cli\:$version_docker.tar.gz ./cliente\:$version_docker.tar.gz ./router\:$version_docker.tar.gz ./servidor\:$version_docker.tar.gz /root/Documents/images
    echo "Se proceso a la finalización de los instalación y LPR sin interfaz gráfica"
    echo "Se procede a la instalación de LPR eliaNS"
    apt update && apt upgrade -y
    echo "instalación JAVA"  >>/root/errores.log>>/root/instalacion.log
    progreso_instalacion
    apt-get install default-jre -y  2>>/root/errores.log 1>>/root/instalacion.log
    apt-get install default-jdk -y  2>>/root/errores.log 1>>/root/instalacion.log
    saltolinea
    echo "comienza la copia de EliaNS"
    echo "comienza la copia de EliaNS" >>/root/errores.log>>/root/instalacion.log
    progreso_instalacion
    git clone https://github.com/lpr-unsl/EliaNS.git /root/EliaNS
    saltolinea
    chmod -R +x /root/EliaNS/*.sh
    echo $version_docker >/root/EliaNS/version.txt
    echo "Comienza copia SimPlanificador"
    echo "Comienza copia SimPlanificador">>/root/errores.log>>/root/instalacion.log
    progreso_instalacion
    git clone https://github.com/lpr-unsl/SimPlanificador.git /root/SimPlanificador_aux 2>>/root/errores.log 1>>/root/instalacion.log
    mkdir /root/SimPlanificador
    mv /root/SimPlanificador_aux/PS.jar /root/SimPlanificador 2>>/root/errores.log 1>>/root/instalacion.log
    mv /root/SimPlanificador_aux/README.md /root/SimPlanificador 2>>/root/errores.log 1>>/root/instalacion.log
    chmod +x /root/SimPlanificador/PS.jar
    rm -r /root/SimPlanificador_aux
    saltolinea
    echo "Comienza la copia de SimMemoria"
    echo "Comienza copia SimMemoria">>/root/errores.log>>/root/instalacion.log
    progreso_instalacion
    mv /root/configuracion_sistema/MemApplication.jar /root/MemApplication  2>>/root/errores.log 1>>/root/instalacion.log
    chmod +x /root/MemApplication/MemApplication
    saltolinea
    echo "copiar menu.sh a desktop de root">>/root/errores.log>>/root/instalacion.log
    mv  /root/configuracion_sistema/menu.sh  /root/Desktop
    chmod +x /root/Desktop/menu.sh
    rm -r /root/configuracion_sistema
    echo "Hemos terminado la instalación y copias de los sistemas"
    echo "Para ver los logs de la instalación se encuentra en las siguientes carpetas"
    echo "la ruta es /root/errores.log y /root/instalacion.log"
    echo "Se procede a reiniciar el sistema."
    echo "----------------------------------------------------------------------------------------------------------------------------"
    echo "----------------------------------------------------------------------------------------------------------------------------"
    echo "NOTA: No te olvides que si quieres iniciar las aplicaciones vas a encontrar menu.sh en el escritorio y al iniciar debes usar el usuario:root pass: lpr"
    echo "----------------------------------------------------------------------------------------------------------------------------"
    echo "----------------------------------------------------------------------------------------------------------------------------"
    sleep 5
    reboot
else
    echo "Hola, no estas como usuario root, por lo cual no vamos a poder continuar con la instalación"
    echo "Por favor podrías ubicarte como root y volver iniciarme"
    echo "AYUDA:recuerda que el 'user: root ; password: lpr' "
    exit 0
fi


