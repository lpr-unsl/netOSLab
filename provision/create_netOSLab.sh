#!/bin/bash

# Check if exactly two arguments are provided
if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <network_interface_name> <path_to_netOSLab_image>"
    exit 1
fi

# Assign arguments to variables
INTERFACE="$1"
IMAGE_NAME="$2"
VBPATH=$HOME"/VirtualBox VMs"

VBoxManage createvm --name netOSLab --ostype "Debian_64" --register --basefolder "$VBPATH"
VBoxManage modifyvm netOSLab --memory 1024 --vram 128
VBoxManage modifyvm netOSLab --ioapic on
VBoxManage modifyvm netOSLab --nic1 bridged --bridgeadapter1 $INTERFACE
VBoxManage modifyvm netOSLab --graphicscontroller vmsvga
VBoxManage modifyvm netOSLab --boot1 dvd --boot2 disk --boot3 none --boot4 none

VBoxManage storagectl netOSLab --name "IDE Controller" --add ide --controller PIIX4
VBoxManage storagectl netOSLab --name "SATA Controller" --add sata --controller IntelAhci

VBoxManage createhd --filename "$VBPATH"/netOSLab/netOSLab_disk.vdi --size 4000 --format VDI
VBoxManage storageattach netOSLab --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$VBPATH"/netOSLab/netOSLab_disk.vdi
VBoxManage storageattach netOSLab --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium "$IMAGE_NAME"

