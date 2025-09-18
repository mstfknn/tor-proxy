FROM debian:bookworm-slim

# Tor kurulumu
RUN apt-get update && apt-get install -y tor && \
    rm -rf /var/lib/apt/lists/*

COPY torrc /etc/tor/torrc

EXPOSE 9150
EXPOSE 53/udp

CMD ["sh", "-c", "tor -f /etc/tor/torrc > /dev/null 2>&1"]