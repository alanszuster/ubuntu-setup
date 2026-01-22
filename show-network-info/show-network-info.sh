#!/bin/bash

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}Network Info${NC}"
echo "----------------------------"

# Local IP
echo -e "${YELLOW}Local IP:${NC}"
hostname -I | awk '{print $1}'

# Public IP
echo -e "\n${YELLOW}Public IP:${NC}"
curl -s ifconfig.me || echo "n/a"

# Interface
echo -e "\n${YELLOW}Interface:${NC}"
INTERFACE=$(ip route | grep default | awk '{print $5}' | head -n1)
echo $INTERFACE
ip addr show "$INTERFACE" 2>/dev/null | grep "link/ether" | awk '{print "MAC: " $2}'

# Gateway
echo -e "\n${YELLOW}Gateway:${NC}"
ip route | grep default | awk '{print $3}' | head -n1

# DNS
echo -e "\n${YELLOW}DNS Servers:${NC}"
grep "^nameserver" /etc/resolv.conf | awk '{print $2}'

# Routing
echo -e "\n${YELLOW}Routing Table:${NC}"
ip route show | head -n 5

# WiFi Info
echo -e "\n${YELLOW}WiFi:${NC}"
if command -v iwconfig &> /dev/null; then
    WIFI_INTERFACE=$(iwconfig 2>/dev/null | grep -o '^[a-zA-Z0-9]*' | head -n1)
    if [ -n "$WIFI_INTERFACE" ]; then
        SSID=$(iwconfig $WIFI_INTERFACE 2>/dev/null | grep ESSID | awk -F'"' '{print $2}')
        if [ -n "$SSID" ]; then
            echo "SSID: $SSID"
            SIGNAL=$(iwconfig $WIFI_INTERFACE 2>/dev/null | grep "Signal level" | awk '{print $4}' | cut -d'=' -f2)
            [ -n "$SIGNAL" ] && echo "Signal: $SIGNAL"
        else
            echo "Not connected"
        fi
    else
        echo "No WiFi interface"
    fi
else
    echo "iwconfig not installed"
fi

# VPN Status
echo -e "\n${YELLOW}VPN:${NC}"
VPN_INTERFACES=$(ip link show | grep -E 'tun|wg|tap' | awk -F': ' '{print $2}' | cut -d'@' -f1)
if [ -n "$VPN_INTERFACES" ]; then
    echo "$VPN_INTERFACES" | while read vpn; do
        echo -e "${GREEN}✓${NC} $vpn active"
    done
else
    echo "Not connected"
fi

# Connection test
echo -e "\n${YELLOW}Connection:${NC}"
if ping -c 1 8.8.8.8 &> /dev/null; then
    echo -e "${GREEN}✓${NC} Online"
else
    echo -e "${YELLOW}✗${NC} Offline"
fi
