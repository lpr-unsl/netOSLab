#!/bin/bash
echo "----------------------------------------------------------------"
echo "----------------------------------------------------------------"
echo ""
echo "INSTALADOR LPR INTEGRADO V1.0"
echo ""
echo "----------------------------------------------------------------"
echo "----------------------------------------------------------------"
echo "Comenzamos con la instalación de los requisitos minimos para LPR"
echo "----------------------------------------------------------------"
echo "----------------------------------------------------------------"

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
            echo "rootcreado" >> /home/instalacion.txt
            return 0
        else
            echo "Comienza la instalación"
            echo "Habilitamos el usuario root con password lpr"
            echo "root:lpr"| sudo chpasswd
            echo "--------------------------------------------------------------------"
            echo "por favor deslogueate y logueate con el usuario: root password: lpr "
            echo "--------------------------------------------------------------------"
            echo "rootcreado" >> /home/instalacion.txt
            return 0
        fi
    else
        return 2
    fi
}
usuario_actual=`users`
touch /home/instalacion.txt
buscar_creacion=`grep -wiR rootcreado /home/instalacion.txt`
validacion_variable $buscar_creacion $usuario_actual
validacion=$?

if [ $validacion -eq 0 ]
then
  exit 0
elif [ $usuario_actual = "root" ] && [ $validacion -eq 2 ]
then
    echo "Continuamos con la instalación ya que configuramos el usuario root"
    echo "actualizacion sistema" 
    
    apt update && upgrade -y
    echo "Fin de actualización del sistema"
    echo "clonamos el repositorio donde se encuentran todas las configuraciones"
    git clone https://github.com/lpr-unsl/netOSLab.git
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "comienza la instalación de la interfaz grafica xfce4"
    echo "Elegir la opción lightdm, más tab + enter para que se aplique los cambios"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "Instalacion xfce4" 
    apt install xfce4-panel xfwm4 xfce4-session xfce4-terminal xfdesktop4 lightdm-gtk-greeter

    echo "Se termino la instalacion xfce4"
    echo "Comenzamos con la actualización e instalación minima para LPR"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "actualización dependencias" 
    
    apt install apt-transport-https ca-certificates curl software-properties-common -y 
    
    echo "creación archivo docker.list" 
    
    touch /etc/apt/sources.list.d/docker.list
    echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" >> /etc/apt/sources.list.d/docker.list
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
    sleep 3

    apt update && apt upgrade -y
    echo "instalación docker"
    
    apt install docker-ce -y 
    sleep 3
    #poniendo en servicio docker
    systemctl start docker
    systemctl enable docker
    #Permitiendo el trafico de docker
    iptables -P INPUT ACCEPT
    iptables -P FORWARD ACCEPT
    iptables -P OUTPUT ACCEPT
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "configuracion firewall depués de permitir el trafico"  
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    iptables -L -nv 
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    sleep 3
    echo "instalar xterm"
    apt install xterm -y
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    
    echo "instalar brigde utils" 
    apt-get install bridge-utils -y 
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "instalar iputil arping"  
    apt install iputils-arping -y 
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "instalar arping" 
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    apt install arping -y 
    echo "instalar wireshark" 
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    apt install wireshark -y 
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "instalar samba"  
    apt install samba -y 
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "instalar smbclient" 
    apt install smbclient -y 
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "instalar cifs-utils"
    apt install cifs-utils -y 
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "instalar vsftpd" 
    apt install vsftpd -y 
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "instalar telnet"
    apt install telnetd -y 
    echo "borrado de inet.confg y clonado archivo" 
    rm /etc/inetd.conf
    cp /root/configuracion_sistema/configuracion/Herramientas/TELNET/inetd.conf /etc/
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "instalar nfs-kernel-server" 
    apt install nfs-kernel-server -y 
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "instalar nfs-common" 
    apt install nfs-common -y 
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "instalar dillo"
    apt install dillo -y
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "instalacion systemback" 
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 382003C2C8B7B4AB813E915B14E4942973C62A1B
    add-apt-repository "deb http://ppa.launchpad.net/nemh/systemback/ubuntu xenial main" 
    apt update && apt upgrade -y 
    apt install systemback -y 
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
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
    echo "Comienza el clonado de los sistemas"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "clonación pipework" 
    git clone https://github.com/jpetazzo/pipework.git /usr/local/bin 
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "copiamos lpr" 
    echo "clonar lpr"
    git clone https://github.com/lpr-unsl/lpr.git /root/Documents
    apt install net-tools -y 
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "configuramos ssh para que se pueda loguear como root"
    echo "configuramos ssh para que se pueda loguear como root" 
    rm /etc/ssh/sshd_config
    cp /root/configuracion_sistema/configuracion/Herramientas/SSH/sshd_config /etc/ssh/
    echo "comprobamos que se haya copiado sshd_config y restauramos el servicio"
    echo "---------------------------------------------------------------------"
    ls -l /etc/ssh/
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    sleep 3
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
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "Procedemos a mover las copias descargadas de docker recientemente a la carpeta Documents"
    mkdir /root/Documents/images
    mv ./cliente-cli\:$version_docker.tar.gz ./cliente\:$version_docker.tar.gz ./router\:$version_docker.tar.gz ./servidor\:$version_docker.tar.gz /root/Documents/images/
    echo "Se proceso a la finalización de los instalación y LPR sin interfaz gráfica"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "Se procede a la instalación de LPR eliaNS"
    apt update && apt upgrade -y
    echo "instalación JAVA"  
    apt-get install default-jre -y  
    apt-get install default-jdk -y 
    echo "comienza la copia de EliaNS"
    
    git clone https://github.com/lpr-unsl/EliaNS.git /root/EliaNS

    chmod -R +x /root/EliaNS/*.sh
    echo $version_docker >/root/EliaNS/version.txt
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "Comienza la copia de SimMemoria"
    mv /root/configuracion_sistema/MemApplication.jar /root/MemApplication  
    chmod +x /root/MemApplication/MemApplication
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "copiar menu.sh a desktop de root"
    mv  /root/configuracion_sistema/menu.sh  /root/Desktop/
    chmod +x /root/Desktop/menu.sh
    rm -r /root/configuracion_sistema
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "Comienza copia SimPlanificador"
    sleep 3
    git clone https://github.com/lpr-unsl/SimPlanificador.git /root/SimPlanificador_aux 
    mkdir /root/SimPlanificador
    mv /root/SimPlanificador_aux/PS.jar /root/SimPlanificador 
    mv /root/SimPlanificador_aux/README.md /root/SimPlanificador 
    chmod +x /root/SimPlanificador/PS.jar
    rm -r /root/SimPlanificador_aux
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "---------------------------------------------------------------------"
    echo "Hemos terminado la instalación y copias de los sistemas"
    echo "Se procede a reiniciar el sistema."
    echo "----------------------------------------------------------------------------------------------------------------------------"
    echo "----------------------------------------------------------------------------------------------------------------------------"
    echo "NOTA: No te olvides que si quieres iniciar las aplicaciones vas a encontrar menu.sh en el escritorio y al iniciar debes usar el usuario:root pass: lpr"
    echo "----------------------------------------------------------------------------------------------------------------------------"
    echo "----------------------------------------------------------------------------------------------------------------------------"
    sleep 7
    reboot
else
    echo "Hola, no estas como usuario root, por lo cual no vamos a poder continuar con la instalación"
    echo "Por favor podrías ubicarte como root y volver iniciarme"
    echo "AYUDA:recuerda que el 'user: root ; password: lpr' "
    exit 0
fi


