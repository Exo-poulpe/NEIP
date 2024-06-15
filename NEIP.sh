#!/bin/bash

# Check param input
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <IP base> <CIDR> [scan type (1-5)]"
    exit 1
fi

IP_BASE=$1
CIDR=$2
SCAN_TYPE=${3:-1}  # Set default scan type
OUTPUT_BASENAME="scan_$(echo $IP_BASE | tr './' '-')__${CIDR}_TYPE_${SCAN_TYPE}"  # Make scan output filename

# Scan NMAP
function scan_ip {
    echo "NMAP started for : ${1}"
    case $SCAN_TYPE in
        1)
            echo "Executing Hyper Sneaky Scan"
            sudo nmap -sS -sV -v --open -p 445,443,80,22,21,5985,5901 -Pn -n --disable-arp-ping -T1 --randomize-hosts --spoof-mac 0 -oN "${OUTPUT_BASENAME}.nmap" --append-output -oG "${OUTPUT_BASENAME}.gnmap" --append-output -oX "${OUTPUT_BASENAME}.xml" --append-output $1
            ;;
        2)
            echo "Executing Mostly Sneaky Scan"
            sudo nmap -sS -sV -v --open -p 445,443,80,22,21,5985,5901 -Pn -n --disable-arp-ping -T2 --randomize-hosts --spoof-mac 0 -oN "${OUTPUT_BASENAME}.nmap" --append-output -oG "${OUTPUT_BASENAME}.gnmap" --append-output -oX "${OUTPUT_BASENAME}.xml" --append-output $1
            ;;
        3)
            echo "Executing Standard Scan"
            sudo nmap -sS -sV -v --open -p- -Pn -n --disable-arp-ping -T3 --randomize-hosts --spoof-mac 0 -oN "${OUTPUT_BASENAME}.nmap" --append-output -oG "${OUTPUT_BASENAME}.gnmap" --append-output -oX "${OUTPUT_BASENAME}.xml" --append-output $1
            ;;
        4)
            echo "Executing Detectable Scan"
            sudo nmap -sS -sV -v --open -p- -n --disable-arp-ping -T4 --randomize-hosts --spoof-mac 0 -oN "${OUTPUT_BASENAME}.nmap" --append-output -oG "${OUTPUT_BASENAME}.gnmap" --append-output -oX "${OUTPUT_BASENAME}.xml" --append-output $1
            ;;
        5)
            echo "No more time Scan but MAC not Spoof"
            sudo nmap -sS -sV -v --open -n --disable-arp-ping -T5 --randomize-hosts -oN "${OUTPUT_BASENAME}.nmap" --append-output -oG "${OUTPUT_BASENAME}.gnmap" --append-output -oX "${OUTPUT_BASENAME}.xml" --append-output $1
            ;;
        *)
            echo "Invalid scan type specified, defaulting to Hyper Sneaky Scan"
            sudo nmap -sS -sV -v --open -p 445,443,80,22,21,5985,5901 -Pn -n --disable-arp-ping -T1 --randomize-hosts --spoof-mac 0 -oN "${OUTPUT_BASENAME}.nmap" --append-output -oG "${OUTPUT_BASENAME}.gnmap" --append-output -oX "${OUTPUT_BASENAME}.xml" --append-output $1
            ;;
    esac
}

# Use NMAP -sL to list all IPs and shuffle them to take them in random order
nmap -n -sL $IP_BASE/$CIDR | grep 'Nmap scan report for' | awk '{print $5}' | shuf | while read IP
do
    scan_ip $IP
done

echo "Scanning complete. Results saved to ${OUTPUT_BASENAME}.gnmap and ${OUTPUT_BASENAME}.xml"

