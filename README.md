# Repo intended to launch "netOSBase" machine, in order to create netOSLab liveCD images from it

Repo intended to automate only netOSLab operating system and it's updates, nor ssor, nor SimMemoria, nor SimPlanificador, nor any other software.

#Requirements:
- VirtualBox 7.0 or higher installed on the machine that will run the automation
- ansible 2.14 or higher installed on the machine that will run the automation

#steps to create infrastructures:
- git clone this_repo
- Download netinst stable debian version (debian-12.6.0-amd64-netinst.iso) from https://www.debian.org/distrib/
- to create netOSBase virtualmachine, run :
        - bash provision/create_netOSBase.sh "your_phisical_nic_to_reach_internet" "path_to_debian-12.6.0-amd64-netinst.iso"
- Once created Boot VM and select Advanced options -> Automated install
- In the "Download debconf preconfiguration file" window enter the following url:
       - https://raw.githubusercontent.com/lpr-unsl/netOSLab/refs/heads/main/provision/preseed.cfg
- Once debian installation finished, log in to netOSBase and get ipv4 address by running:
        - ip addr

#steps to configure software on "netOSBase" machine
- edit in this repo file config/inventory/inventory.ini and replace "ansible_host" with your ip (previously obtained)
- to install all needed packages run:
	-  ansible-playbook -i config/inventory/inventory.yaml config/playbook/playbook-packages.yaml 
- to set up extra config run:
        -  ansible-playbook -i config/inventory/inventory.yaml config/playbook/playbook-config.yaml

#wait until "netOSBase" virtual machine is restarted and log in again
 - ready to do changes and create a netOSLab image using systemback

#steps to create netOSLab images
- Verify netOSLab tag is updated to last version to create new image
- git tag 1.X.X -m "netOSLab 1.X.X"
- Once changes are applied to repo (git add * , git commit -m "message", git push --tag)
- Launch systemback: -> Applications -> System -> Systemback
- Select "Live system create"
- Verify that "Include the user data files" is checked
- Click on "Create new"
- A new iso file is created in /home/systemback_live_date.iso.
- mv /home/systemback_live_date.iso /home/netOSLab-1.X.X.iso

#Create a netOSLab machine to test/work
-Go to yout local machine and scp iso to it:
     - scp root@[netOSBase_IP]:/home/netOSLab-1.X.X.iso some/path
- to create netOSLab virtualmachine, run :
        - bash provision/create_netOSLab.sh "your_phisical_nic_to_reach_internet" "some/path/netOSLab-1.X.X.iso"
