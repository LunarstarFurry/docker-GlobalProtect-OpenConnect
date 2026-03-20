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
RUN sed -i 's/providers = provider_sect/providers = provider_sect\nssl_conf = ssl_sect\n\n[ssl_sect]\nsystem_default = system_default_sect\n\n[system_default_sect]\nOptions = UnsafeLegacyRenegotiation/' /etc/ssl/openssl.cnf
COPY setup.sh /setup.sh
RUN chmod +x /setup.sh

ENTRYPOINT ["/setup.sh"]
