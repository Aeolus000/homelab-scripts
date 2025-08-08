#!/bin/bash

#
#	This should ONLY be run from the Proxmox Cluster nodes!
#


TEMPLATE_ID=9000
BRIDGE="vmbr0"
CIUSER="ansible"
SSHKEY="/root/ansible.pub"
NAMESERVER="10.0.0.1"
DOMAIN="haydenlab.local"

VMID=$(pvesh get /cluster/nextid)

echo "${VMID}"

#VMNAME="vm-${VMID}"
#IP="${IP}"
#GW="10.0.0.1"

#echo "${TEMPLATE_ID}"
