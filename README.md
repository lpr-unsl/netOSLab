# Repo intended to launch "base" machine, in order to create netOSLab liveCD images from it

Repo intended to automate only netOSLab operating system and it's updates, nor ssor, nor SimMemoria, nor SimPlanificador, nor any other software.

#Requirements:
- VirtualBox 7.0 or higher installed on the machine that will run the automation
- ansible 2.14 or higher installed on the machine that will run the automation

#steps to create infrastructures:
- git clone this_repo
- Download netinst stable debian version (debian-12.6.0-amd64-netinst.iso) from https://www.debian.org/distrib/
- to create base virtualmachine, run :
        - bash provision/create_vm.sh "your_phisical_nic_to_reach_internet" "path_to_debian-12.6.0-amd64-netinst.iso"
- Once created Boot VM and select Advanced options -> Automated install
- In the "Download debconf preconfiguration file" window enter the following url:
       - https://raw.githubusercontent.com/lpr-unsl/netOSLab/refs/heads/main/provision/preseed.cfg
- Once debian installation finished, log in and get ipv4 address

#steps to configure software on "base" machine
- edit config/inventory/inventory.ini and replace "ansible_host" with yours (previously obtained)
- to install all needed packages run:
	-  ansible-playbook -i config/inventory/inventory.yaml config/playbook/playbook-packages.yaml 
- to set up extra config run:
        -  ansible-playbook -i config/inventory/inventory.yaml config/playbook/playbook-config.yaml

#wait until "base" virtual machine is restarted and log in again
- ready to create a netOSLab image using systemback

#steps to create netOSLab images
- Verify netOSLab tag is updated to create new image
- Launch systemback: -> Applications -> System -> Systemback
- Select "Live system create"
- Verify that "Include the user data files" is checked
- Click on "Create new"
