VBoxManage createvm --name base --ostype "Debian_64" --register --basefolder . 
VBoxManage modifyvm base --memory 1024 --vram 128
VBoxManage modifyvm base --ioapic on
VBoxManage modifyvm base --nic1 bridged --bridgeadapter1 wlp0s20f3 
VBoxManage modifyvm base --vrde on --vrdeport 5000
VBoxManage modifyvm base --boot1 dvd --boot2 disk --boot3 none --boot4 none 

VBoxManage storagectl base --name "IDE Controller" --add ide --controller PIIX4       
VBoxManage storagectl base --name "SATA Controller" --add sata --controller IntelAhci       


VBoxManage createhd --filename ./base/base_disk.vdi --size 200000 --format VDI                     
VBoxManage storageattach base --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium  ./base/base_disk.vdi
VBoxManage storageattach base --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium ./debian-12.6.0-amd64-netinst.iso

VBoxManage startvm base --type headless
