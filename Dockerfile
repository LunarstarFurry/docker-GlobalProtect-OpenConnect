FROM amazoncorretto:25-alpine-jdk
LABEL org.opencontainers.image.authors="Haiyo.Lunarstar!"

RUN apk add --no-cache \
    bash \
    bash-completion \
    ca-certificates \
    curl \
    wget \
    openconnect \
    vpnc \
    iproute2 \
    && update-ca-certificates

COPY setup.sh /setup.sh
RUN chmod +x /setup.sh

ENTRYPOINT ["/setup.sh"]
