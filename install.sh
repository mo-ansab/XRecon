#!/bin/bash

echo "------------------------------------"
echo "  Installing requirements for XRecon"
echo "------------------------------------"

# Colors
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Function to check and install Go tools
install_go_tool() {
    if ! command -v $1 &> /dev/null; then
        echo -e "${GREEN}[+] Installing $1...${NC}"
        go install "$2"
    else
        echo -e "${GREEN}[+] $1 is already installed.${NC}"
    fi
}

# Function to install APT tools
install_apt_tool() {
    if ! command -v $1 &> /dev/null; then
        echo -e "${GREEN}[+] Installing $1 using apt...${NC}"
        sudo apt install -y $1
    else
        echo -e "${GREEN}[+] $1 is already installed.${NC}"
    fi
}

# Install Go-based tools
install_go_tool assetfinder github.com/tomnomnom/assetfinder@latest
install_go_tool httpx github.com/projectdiscovery/httpx/cmd/httpx@latest

# Install APT-based tools
install_apt_tool sublist3r
install_apt_tool dirb

echo -e "${GREEN}[✓] All tools installed. You're ready to run XRecon!${NC}"
