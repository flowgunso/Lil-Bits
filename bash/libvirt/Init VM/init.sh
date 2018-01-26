#!/bin/bash

# Arguments parsing, help and usage.
if [ $# -eq 0 ]
then
    echo "No arguments supplied"
    echo "This script require a name for the vm to be created."
    exit
elif [ $# -gt 1 ]
then
    echo "Too many arguments provided."
    echo "This script require only a name for the vm to be created."
    exit
fi

# Variable initializations.
vm_root_path="~/vm/"
vm_name="$1"
vm_filename="$vm_name.qcow2"
vm_path="$vm_root_path/$vm_name"
vm_full_path="$vm_path/$vm_filename"

# VM root path validation.
echo "Checking if the VM root path exist."
if  [ ! -d $vm_root_path ]
then
  echo "Creating the VM root path."
  mkdir $vm_root_path
fi

# VM to be created path validation.
echo "Checking if the VM to be created path exist."
if  [ ! -d $vm_root_path ]
then
  echo "Creating the VM to be created path."
  mkdir $vm_path
fi

# Cleanup if this script was already called.
echo "If any, cleaning existing $vm_name VM related data."
pkill -f "qemu-kvm.*$vm_name"
virsh --connect qemu:///system undefine $vm_name
rm -f "$vm_full_path"

echo "- Create the YUNOHost VM"
qemu-img create -f qcow2 $vm_full_path 3T
virt-install --connect qemu:///system \
  --name $vm_name \
  --hvm --ram 1024 --vcpus 1 \
  --os-variant debian8 \
  --disk $vm_full_path \
  --network type=direct,source=eno2,model=virtio,mac=0e:ff:ff:ff:ff:ff \
  --graphics vnc,listen=0.0.0.0 --noautoconsole \
  --autostart \
  --pxe
