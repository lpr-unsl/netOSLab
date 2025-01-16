Repo intended to automate netOSLab operating system and it's updates

Steps:
#copy public key from Control node to Managed node
ssh-copy-id  same_user@192.168.68.54 

cd automation
create inventory.ini file
ansible-inventory -i inventory.ini --list
# Managed node needs python installed
ansible myhosts -m ping -i inventory.ini

run 
ansible-playbook -i inventory/inventory.yaml playbook/playbook2.yaml -u root
