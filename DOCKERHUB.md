<p align="center">
  <img src="https://www.torproject.org/static/images/tor-logo/Purple.png" alt="Tor Proxy Logo"/>
</p>

# tor-proxy

A lightweight, privacy-focused proxy server using Tor network.

> **Disclaimer:** This project is intended for **legitimate and legal use only**, such as privacy protection, censorship circumvention, and security research. Users are solely responsible for ensuring their usage complies with applicable laws and regulations.

## Quick Start

```bash
docker pull mstfknn/tor-proxy
docker run -d -p 9150:9150 -p 8853:5353/udp mstfknn/tor-proxy
```

## Features

- Routes traffic through the Tor network for anonymity
- Lightweight and easy to deploy
- SOCKS5 proxy on port **9150**
- DNS over Tor on port **5353** (mapped to host **8853**)
- Configurable via environment variables
- Tor Bridge support (obfs4, meek)
- Exit node country selection
- Built-in healthcheck
- Runs as non-root user
- Signed container images (cosign)

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `SOCKS_PORT` | `9150` | SOCKS5 proxy port |
| `DNS_PORT` | `5353` | DNS resolution port |
| `ENABLE_LOG` | `false` | Enable Tor logging to stdout |
| `EXIT_NODES` | - | Exit node countries (e.g., `{US},{DE}`) |
| `STRICT_NODES` | `0` | Only use specified exit nodes (`1` to enable) |
| `USE_BRIDGE` | `false` | Enable Tor bridge |
| `BRIDGE_TYPE` | - | Bridge type: `obfs4`, `meek`, `snowflake` |
| `BRIDGE_LINES` | - | Bridge addresses (semicolon-separated) |

## Usage Examples

### Basic
```bash
docker run -d -p 9150:9150 mstfknn/tor-proxy:debian
```

### With country selection
```bash
docker run -d -p 9150:9150 \
  -e EXIT_NODES="{US},{GB}" \
  -e STRICT_NODES=1 \
  mstfknn/tor-proxy:debian
```

### With bridge (censored networks)
```bash
docker run -d -p 9150:9150 \
  -e USE_BRIDGE=true \
  -e BRIDGE_TYPE=obfs4 \
  -e BRIDGE_LINES="obfs4 1.2.3.4:443 FINGERPRINT cert=... iat-mode=0" \
  mstfknn/tor-proxy:debian
```

### With persistent data
```bash
docker run -d -p 9150:9150 \
  -v tor-data:/var/lib/tor \
  mstfknn/tor-proxy:debian
```

## Multi-Instance Load Balancing

Run multiple Tor instances behind HAProxy for different exit IPs per request:

```bash
docker compose -f docker-compose.multi.yml up -d
```

```
Client → :9150 → HAProxy → tor-1 (circuit A)
                          → tor-2 (circuit B)
                          → tor-3 (circuit C)
```

No additional image build is required — it uses the pre-built `mstfknn/tor-proxy:debian` image and the official `haproxy:alpine` image. See [GitHub repo](https://github.com/mstfknn/tor-proxy) for `docker-compose.multi.yml` and `haproxy.cfg`.

## Testing

Configure your application to use the SOCKS5 proxy at `localhost:9150` and verify your IP:

```bash
curl --socks5-hostname localhost:9150 https://check.torproject.org/api/ip
```

## Alpine Variant

For a smaller image:

```bash
docker pull mstfknn/tor-proxy:alpine
docker run -d -p 9150:9150 -p 8853:5353/udp mstfknn/tor-proxy:alpine
```

## GitHub

[https://github.com/mstfknn/tor-proxy](https://github.com/mstfknn/tor-proxy)
