FROM amazoncorretto:25-alpine-jdk
LABEL org.opencontainers.image.authors="Haiyo.Lunarstar!"

RUN apk upgrade --no-cache \
    && apk --no-cache add bash bash-completion bash-doc ca-certificates curl wget \
	  && update-ca-certificates
RUN apk add --no-cache \
    openconnect \
    vpnc \
    bash \
    iproute2 \
    ca-certificates

# We use the standard vpnc-script included in the apk
ENTRYPOINT ["openconnect", "--protocol=gp"]
