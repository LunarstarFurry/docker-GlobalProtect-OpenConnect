#!/bin/bash

if [ ! -c /dev/net/tun ]; then
    mkdir -p /dev/net/tun
    mknod /dev/net/tun c 10 200
    chmod 600 /dev/net/tun
fi

CERT_FLAG=""
[ -n "$VPN_CERT" ] && CERT_FLAG="--servercert $VPN_CERT"

GATEWAY_FLAG=""
[ -n "$VPN_GATEWAY" ] && GATEWAY_FLAG="--authgroup $VPN_GATEWAY"

echo "Connecting to GlobalProtect at $VPN_SERVER..."

echo "$VPN_PASS" | openconnect \
    --protocol=gp \
    --os=win \
    --useragent="GlobalProtect/5.2.0-8" \
    --user="$VPN_USER" \
    --passwd-on-stdin \
    --allow-insecure-crypto \
    $CERT_FLAG \
    $GATEWAY_FLAG \
    "$VPN_SERVER" &

if [ -n "$CUSTOM_ROUTES" ]; then
    echo "Waiting for tunnel to initialize for custom routing..."
    for i in {1..30}; do
        if [ -d /sys/class/net/tun0 ]; then
            echo "Tunnel found! Applying surgical routes..."
            ip route del 10.0.0.0/8 dev tun0 2>/dev/null
            ip route del 172.16.0.0/12 dev tun0 2>/dev/null
            ip route del 192.168.0.0/16 dev tun0 2>/dev/null
            
            # Apply your specific Unraid variables (Format: IP:DEV,IP:DEV)
            IFS=',' read -ra ADDR_LIST <<< "$CUSTOM_ROUTES"
            for entry in "${ADDR_LIST[@]}"; do
                ROUTE=$(echo $entry | cut -d: -f1)
                DEV=$(echo $entry | cut -d: -f2)
                ip route add "$ROUTE" dev "$DEV" 2>/dev/null
                echo "Fixed: $ROUTE via $DEV"
            done
            break
        fi
        sleep 1
    done
fi
wait
