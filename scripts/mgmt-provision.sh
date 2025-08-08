#!/bin/bash

VM_NAME=$1
VM_IP=$2
PROXMOX_NODE=$3



scp ./proxmox-provision.sh root@${PROXMOX_NODE}:/root/

ssh ${PROXMOX_NODE} "chmod +x /root/proxmox-provision.sh && /root/proxmox-provision.sh $VM_NAME $VM_IP"

