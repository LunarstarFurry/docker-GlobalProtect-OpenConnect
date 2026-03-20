#!/bin/bash

if [ ! -c /dev/net/tun ]; then
    mkdir -p /dev/net/tun
    mknod /dev/net/tun c 10 200
    chmod 600 /dev/net/tun
fi

CERT_FLAG=""
if [ -n "$VPN_CERT" ]; then
    CERT_FLAG="--servercert $VPN_CERT"
fi

echo "Connecting to GlobalProtect at $VPN_SERVER..."

exec echo "$VPN_PASS" | openconnect \
    --protocol=gp \
    --user="$VPN_USER" \
    --passwd-on-stdin \
    --script=/usr/share/vpnc/vpnc-script \
    --non-inter \
    $CERT_FLAG \
    "$VPN_SERVER"
