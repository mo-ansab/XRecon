#!/bin/bash

# Colors
green="\e[32m"
red="\e[31m"
blue="\e[34m"
yellow="\e[33m"
reset="\e[0m"

# Banner
banner() {
echo -e "${yellow}"
cat << "EOF"
==========================================================

   __     __ ______                                    
    \\   //  ||   ||  ______  _____    _____  ______   
     \\ //   ||___||  ||____| ||   \  ||   ||  ||   \  
     // \\   ||  \\   ||      ||      ||   ||  ||   ||   
   _//   \\_ ||   \\_  \\___|  \\___| ||___||  ||   || 
                                                       
                                       by Ansab Sheikh 
===========================================================
EOF
echo -e "${reset}"
}

# Help menu
usage() {
    banner
    echo -e "${blue}Usage:${reset}"
    echo "  ./XRecon.sh -d example.com [-o output-folder]"
    echo ""
    echo -e "${blue}Options:${reset}"
    echo "  -d    Target domain (required)"
    echo "  -o    Output folder (default: recon-[domain])"
    echo "  -h    Show this help message"
    exit 1
}

# Parse args
while getopts ":d:o:h" opt; do
  case $opt in
    d) domain="$OPTARG" ;;
    o) output_dir="$OPTARG" ;;
    h) usage ;;
    \?) echo -e "${red}[!] Invalid option: -$OPTARG${reset}" >&2; usage ;;
    :) echo -e "${red}[!] Option -$OPTARG requires an argument.${reset}" >&2; usage ;;
  esac
done

# Check for required domain input
if [ -z "$domain" ]; then
    echo -e "${red}[!] Domain is required.${reset}"
    usage
fi

# Set output dir if not provided
if [ -z "$output_dir" ]; then
    output_dir="recon-$domain"
fi

# Start
banner
mkdir -p "$output_dir"

echo -e "${blue}[*] Target: $domain${reset}"
echo -e "${blue}[*] Output: $output_dir/${reset}"

# 1. Subdomain discovery
echo -e "${blue}[*] Running subfinder...${reset}"
subfinder -d "$domain" -silent > "$output_dir/subdomains.txt"
echo -e "${green}[+] Subdomains found: $(wc -l < "$output_dir/subdomains.txt")${reset}"

# 2. Alive check
echo -e "${blue}[*] Running httpx to check alive subdomains...${reset}"
httpx -silent -l "$output_dir/subdomains.txt" > "$output_dir/alive.txt"
echo -e "${green}[+] Alive subdomains: $(wc -l < "$output_dir/alive.txt")${reset}"

# Done
echo -e "${green}[✔] Scan complete. Results saved in $output_dir/${reset}"
