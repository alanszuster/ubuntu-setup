# Network Info

Shows network configuration and connection status.

## Installation

```bash
chmod +x show-network-info.sh
./show-network-info.sh
```

Optional alias:
```bash
echo "alias netinfo='~/path/to/show-network-info.sh'" >> ~/.bashrc
source ~/.bashrc
```

## What it does

- Shows local IP address
- Shows public IP address (requires internet)
- Shows active network interface with MAC
- Shows default gateway
- Shows DNS servers from `/etc/resolv.conf`
- Shows routing table
- Shows WiFi status (SSID and signal strength)
- Shows VPN status (tun/wg/tap interfaces)
- Tests internet connectivity

## Requirements

- `curl` for public IP (optional)
- `wireless-tools` for WiFi info (optional): `sudo apt install wireless-tools`
- Standard tools: `ip`, `hostname`, `grep`, `awk`
