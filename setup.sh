#!/bin/bash

# 1. Ensure TUN device exists
if [ ! -c /dev/net/tun ]; then
    mkdir -p /dev/net/tun
    mknod /dev/net/tun c 10 200
    chmod 600 /dev/net/tun
fi

# 2. Handle the Certificate Pin variable
CERT_FLAG=""
if [ -n "$VPN_CERT" ]; then
    CERT_FLAG="--servercert $VPN_CERT"
fi

# 3. Handle the Gateway selection (The "Auth Group")
GATEWAY_FLAG=""
if [ -n "$VPN_GATEWAY" ]; then
    GATEWAY_FLAG="--authgroup $VPN_GATEWAY"
fi

echo "Connecting to GlobalProtect at $VPN_SERVER..."

# 4. Execute the connection
# Added $GATEWAY_FLAG to satisfy the "Please select GlobalProtect gateway" prompt
exec echo "$VPN_PASS" | openconnect \
    --protocol=gp \
    --user="$VPN_USER" \
    --passwd-on-stdin \
    --allow-insecure-crypto \
    $CERT_FLAG \
    $GATEWAY_FLAG \
    "$VPN_SERVER"
