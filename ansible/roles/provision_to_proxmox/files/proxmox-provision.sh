#!/bin/bash

#
#	This should ONLY be run from the Proxmox Cluster nodes!
#


TEMPLATE_ID=9000
BRIDGE="vmbr0"
CIUSER="ansible"
SSHKEY="/root/ansible.pub"
NAMESERVER="10.0.0.1"
DOMAIN="haydenlab.local"i
IP=$1


VMID=$(pvesh get /cluster/nextid)


VMNAME="vm-${VMID}"
GW="10.0.0.1"

echo "$VMID $VMNAME"
echo "IP: $IP"

qm clone 9000 $VMID --name $VMNAME
qm set $VMID \
  --ciuser $CIUSER \
  --sshkey $SSHKEY \
  --ipconfig0 ip=${IP}/24,gw=10.0.0.1 \
  --nameserver 10.0.0.1 \
  --searchdomain haydenlab.local
qm start $VMID
