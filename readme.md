<p align="center">
  <img src="https://www.torproject.org/static/images/tor-logo/Purple.png" alt="Tor Proxy Logo"/>
</p>

# Tor Proxy with Docker

[![Build](https://github.com/mstfknn/tor-proxy/actions/workflows/docker-build.yml/badge.svg)](https://github.com/mstfknn/tor-proxy/actions/workflows/docker-build.yml)
[![Docker Pulls](https://img.shields.io/docker/pulls/mstfknn/tor-proxy)](https://hub.docker.com/r/mstfknn/tor-proxy)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

This project provides a Dockerized Tor proxy server that routes your internet traffic through the Tor network using a SOCKS5 proxy with DNS support.

> **Disclaimer:** This project is intended for **legitimate and legal use only**, such as privacy protection, censorship circumvention, and security research. Users are solely responsible for ensuring their usage complies with applicable laws and regulations. The maintainers of this project are not responsible for any misuse.

## Features

- SOCKS5 proxy with DNS resolution through Tor
- Runs inside a Docker container for easy deployment
- No need to install Tor or configure it manually on your host
- Supports both HTTP and HTTPS traffic routing via SOCKS5
- Available on both **Docker Hub** and **GitHub Container Registry (GHCR)**
- Multi-architecture support (linux/amd64, linux/arm64)
- Built-in container healthcheck
- Runs as non-root user for improved security
- Configurable via environment variables
- Tor Bridge support (obfs4, meek) for censored networks
- Exit node country selection
- Multi-instance load balancing with HAProxy
- Persistent Tor data for faster reconnection
- Container image signing with cosign
- Trivy vulnerability scanning in CI

## Prerequisites

- Docker installed on your system
- Basic knowledge of Docker commands

## Quick Start

```sh
git clone https://github.com/mstfknn/tor-proxy.git
cd tor-proxy
cp .env.example .env
docker compose up -d
```

Then test it:

```sh
curl --socks5-hostname localhost:9150 https://check.torproject.org/api/ip
```

## Usage

### Pull pre-built images

You can pull images directly from Docker Hub or GHCR:

**Docker Hub**

```sh
docker pull mstfknn/tor-proxy:debian
docker pull mstfknn/tor-proxy:alpine
```

For bridge support (obfs4, meek):

```sh
docker pull mstfknn/tor-proxy:debian-bridge
docker pull mstfknn/tor-proxy:alpine-bridge
```

**GitHub Container Registry (GHCR)**

```sh
docker pull ghcr.io/mstfknn/tor-proxy:debian
docker pull ghcr.io/mstfknn/tor-proxy:alpine
```

### Run the container (Debian - default)

```sh
docker run -d --name tor-proxy -p 9150:9150 -p 8853:5353/udp mstfknn/tor-proxy:debian
```

- Port `9150` → SOCKS5 proxy
- Port `8853` → DNS resolution through Tor

### Run the container (Alpine - minimal)

```sh
docker run -d --name tor-proxy-alpine -p 9150:9150 -p 8853:5353/udp mstfknn/tor-proxy:alpine
```

### Docker Compose

```sh
cp .env.example .env  # customize if needed
docker compose up -d
```

### Configure Applications

Set your application's SOCKS5 proxy to `localhost:9150`.
DNS requests will be routed through Tor automatically via port `8853`.

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `SOCKS_PORT` | `9150` | SOCKS5 proxy port |
| `DNS_PORT` | `5353` | DNS resolution port |
| `ENABLE_LOG` | `false` | Enable Tor logging to stdout (`docker logs`) |
| `EXIT_NODES` | - | Exit node countries (e.g., `{US},{DE}`) |
| `STRICT_NODES` | `0` | Only use specified exit nodes (`1` to enable) |
| `USE_BRIDGE` | `false` | Enable Tor bridge |
| `BRIDGE_TYPE` | - | Bridge type: `obfs4`, `meek`, `snowflake` |
| `BRIDGE_LINES` | - | Bridge addresses (semicolon-separated) |

### Exit Node Country Selection

Route your traffic through specific countries:

```sh
docker run -d --name tor-proxy -p 9150:9150 \
  -e EXIT_NODES="{US},{GB},{DE}" \
  -e STRICT_NODES=1 \
  mstfknn/tor-proxy:debian
```

### Tor Bridge (Censored Networks)

For networks where Tor is blocked, use the `-bridge` tagged images which include `obfs4proxy`:

```sh
docker run -d --name tor-proxy -p 9150:9150 \
  -e USE_BRIDGE=true \
  -e BRIDGE_TYPE=obfs4 \
  -e BRIDGE_LINES="obfs4 1.2.3.4:443 FINGERPRINT cert=... iat-mode=0" \
  mstfknn/tor-proxy:debian-bridge
```

You can get bridge addresses from [https://bridges.torproject.org](https://bridges.torproject.org).

### Persistent Data

Keep Tor state across container restarts for faster reconnection:

```sh
docker run -d --name tor-proxy -p 9150:9150 \
  -v tor-data:/var/lib/tor \
  mstfknn/tor-proxy:debian
```

## Multi-Instance Load Balancing

Run multiple Tor instances behind HAProxy for improved speed and different exit IPs per request:

```sh
docker compose -f docker-compose.multi.yml up -d
```

This starts 3 Tor instances with HAProxy round-robin on port `9150`. Each request exits through a different Tor circuit. No additional image build is required — it uses the pre-built `mstfknn/tor-proxy:debian` image from Docker Hub and the official `haproxy:alpine` image.

```
Client → :9150 → HAProxy → tor-1 (circuit A)
                          → tor-2 (circuit B)
                          → tor-3 (circuit C)
```

## Security

- Container images are signed with [cosign](https://github.com/sigstore/cosign) for supply chain security
- Trivy vulnerability scanning runs on every build
- Tor runs as a non-root user inside the container
- Minimal base images (Debian slim / Alpine) reduce attack surface

## Contributing

Contributions are welcome! Feel free to open issues or submit pull requests.

## License

This project is licensed under the [MIT License](LICENSE).

## 🔗 Links

- 🐳 [Docker Hub Image](https://hub.docker.com/r/mstfknn/tor-proxy)
- 📦 [GHCR Image](https://ghcr.io/mstfknn/tor-proxy)

## Star History

<a href="https://www.star-history.com/#mstfknn/tor-proxy&Date">
 <picture>
   <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=mstfknn/tor-proxy&type=Date&theme=dark" />
   <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=mstfknn/tor-proxy&type=Date" />
   <img alt="Star History Chart" src="https://api.star-history.com/svg?repos=mstfknn/tor-proxy&type=Date" />
 </picture>
</a>
