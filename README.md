# 🔐 GlobalProtect OpenConnect Docker

A lightweight, Alpine-based Docker container designed to establish a Palo Alto GlobalProtect VPN connection using OpenConnect. Optimized for Unraid and headless environments.

## 🚀 Quick Start

To run this container on Unraid or any Docker host, you will need to provide your VPN credentials and server details via **Environment Variables**.

```bash
docker run --rm \
  --privileged \
  --net=host \
  -e VPN_SERVER="https://vpn.company.com" \
  -e VPN_USER="CORP\username" \
  -e VPN_PASS="YourSecurePassword123" \
  -e VPN_CERT="pin-sha256:Xsbmmi..." \
  -e VPN_GATEWAY="External_Gateway" \
  lunarstarfurry/globalprotect-openconnect
```

## Docker Hub
https://hub.docker.com/r/lunarstarfurry/globalprotect-openconnect

## 🛠️ Configuration Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `VPN_SERVER` | The HTTPS address of your VPN Portal/Gateway | `https://vpn.company.com` |
| `VPN_USER` | Your VPN username (Use `DOMAIN\user` format if required by your organization) | `CORP\lunarstar` |
| `VPN_PASS` | Your VPN password (store securely using Docker secrets in production) | `YourSecurePassword123` |
| `VPN_CERT` | The SHA256 pin of the server certificate (required for self-signed certificates to prevent MITM attacks) | `pin-sha256:Xsbmmi...` |
| `VPN_GATEWAY` | The specific Auth Group or Gateway name to connect to | `External_Gateway` |

## 📜 Technical Details

- **Base Image**: `amazoncorretto:25-alpine-jdk`
- **VPN Client**: OpenConnect (GlobalProtect Protocol)
