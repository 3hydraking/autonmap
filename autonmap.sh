#!/bin/bash
Red='\033[0;31m'
Green='\033[0;32m'
Darkgray='\033[1;30m'
NC='\033[0m'

printf "${Red}Welcome to HYDRA - Nmap Automated Recon Script${NC}\n\n"
read -p "Please Enter Device IP: " IP
read -p "Enter Output Filename: " fileName
read -p "Aggressive Scan? Y/n: " Aggressive
read -p "Vulnerability Scan? Y/n: " vulnOption
read -p "Use -Pn flag? Y/n: " pn

# Parsing User Options.
# -Pn Option:
if [ "${pn^^}" == "Y" ] || [ -z "$pn" ]
then
  pn="-Pn"
else
  pn=""
fi

# Main Vuln Scan.
if [ "${vulnOption^^}" == "Y" ] || [ -z "$vulnOption" ]
then
  sudo nmap $pn -sSV --stats-every 10s --script vuln --append-output -oN $fileName".vuln" $IP 
fi

# Main If-statement
if [ "${Aggressive^^}" == "Y" ] || [ -z "$Aggressive"]
then
  # Nmap scanner for devices on network range.
  sudo nmap $pn -A --stats-every 10s --append-output -oN $fileName".aggressive" $IP
fi

if if [ "${Ping^^}" == "Y" ] || [ -z "$Ping"]
then
  ping -c $IP
fi
