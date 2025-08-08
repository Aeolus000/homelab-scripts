#!/bin/bash

show_help() {
        cat <<EOF
Usage: $(basename "$0") [OPTIONS] <PROXMOX_NODE>

This script provisions a VM on the designated Proxmox Node. This script finds a free IP within 10.0.0.100-200 that isn't used, and then find's the next VMID from proxmox, and provisions it from there.

Options:

        --help          Show this help message and exit.

Arguments:
  PROXMOX_NODE  Hostname of proxmox node

Example:
  $(basename "$0") proxmox2
EOF
}


# check if help argument was used
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    show_help
    exit 0
fi


# check if arguments aren't dumb or wrong
if [[ $# -lt 1 ]]; then
    echo "Error: Not enough arguments."
    echo "Try '--help' for usage."
    exit 1
fi


# search for an unused IP within the DHCP range (could be bad if something goes down)
UP=$(nmap -sn 10.0.0.0/24 -oG - | awk '/Status: Up/{print $2}')
for i in $(seq 100 200); do
  ip="10.0.0.$i"
  if ! grep -qx "$ip" <<<"$UP"; then
    FREE_IP="$ip"
    break
  fi
done

echo "Free IP: ${FREE_IP:-none found}"



PROXMOX_NODE=$1

scp ./proxmox-provision.sh root@${PROXMOX_NODE}:/root/

ssh ${PROXMOX_NODE} "chmod +x /root/proxmox-provision.sh && /root/proxmox-provision.sh $FREE_IP"
