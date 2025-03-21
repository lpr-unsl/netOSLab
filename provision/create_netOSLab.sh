#!/bin/bash

# Check if exactly two arguments are provided
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <path_to_netOSLab_image>"
    exit 1
fi

# Assign arguments to variables
IMAGE_NAME="$1"
VBPATH=$HOME"/VirtualBox VMs"

VBoxManage createvm --name netOSLab --ostype "Debian_64" --register --basefolder "$VBPATH"
VBoxManage modifyvm netOSLab --memory 2048 --vram 128
VBoxManage modifyvm netOSLab --ioapic on
VBoxManage modifyvm netOSLab --nic1 nat
VBoxManage modifyvm netOSLab --graphicscontroller vmsvga
VBoxManage modifyvm netOSLab --boot1 dvd --boot2 disk --boot3 none --boot4 none

VBoxManage storagectl netOSLab --name "IDE Controller" --add ide --controller PIIX4
VBoxManage storagectl netOSLab --name "SATA Controller" --add sata --controller IntelAhci

VBoxManage createhd --filename "$VBPATH"/netOSLab/netOSLab_disk.vdi --size 4000 --format VDI
VBoxManage storageattach netOSLab --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$VBPATH"/netOSLab/netOSLab_disk.vdi
VBoxManage storageattach netOSLab --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium "$IMAGE_NAME"

