#!/bin/bash

# Check if exactly two arguments are provided
if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <network_interface_name> <path_to_debian_image_name>"
    exit 1
fi

# Assign arguments to variables
INTERFACE="$1"
IMAGE_NAME="$2"
VBPATH=$HOME"/VirtualBox VMs"

VBoxManage createvm --name netOSBase --ostype "Debian_64" --register --basefolder "$VBPATH"
VBoxManage modifyvm netOSBase --memory 1024 --vram 128
VBoxManage modifyvm netOSBase --ioapic on
VBoxManage modifyvm netOSBase --nic1 bridged --bridgeadapter1 $INTERFACE
VBoxManage modifyvm netOSBase --graphicscontroller vmsvga
VBoxManage modifyvm netOSBase --boot1 dvd --boot2 disk --boot3 none --boot4 none

VBoxManage storagectl netOSBase --name "IDE Controller" --add ide --controller PIIX4
VBoxManage storagectl netOSBase --name "SATA Controller" --add sata --controller IntelAhci

VBoxManage createhd --filename "$VBPATH"/netOSBase/netOSBase_disk.vdi --size 20000 --format VDI
VBoxManage storageattach netOSBase --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$VBPATH"/netOSBase/netOSBase_disk.vdi
VBoxManage storageattach netOSBase --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium "$IMAGE_NAME"

