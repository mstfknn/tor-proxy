FROM debian:stable-slim

# Tor kurulumu
RUN apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y --no-install-recommends tor && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Tor config
COPY torrc /etc/tor/torrc

EXPOSE 9150
EXPOSE 53/udp

# Logları tamamen /dev/null'a göm
CMD ["sh", "-c", "tor -f /etc/tor/torrc > /dev/null 2>&1"]