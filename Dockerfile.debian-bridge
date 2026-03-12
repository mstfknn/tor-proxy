FROM debian:stable-slim

# Tor, bridge desteği ve healthcheck için kurulum
RUN apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y --no-install-recommends tor obfs4proxy netcat-openbsd && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Entrypoint script
COPY --chmod=755 docker-entrypoint.sh /usr/local/bin/

EXPOSE 9150
EXPOSE 5353/udp

HEALTHCHECK --interval=60s --timeout=15s --start-period=30s --retries=3 \
  CMD nc -z 127.0.0.1 9150 || exit 1

USER debian-tor
ENTRYPOINT ["docker-entrypoint.sh"]
