# tor-proxy

A lightweight, privacy-focused proxy server using Tor network.

## Quick Start

```bash
docker pull mstfknn/tor-proxy
docker run -d -p 9150:9150 -p 8853:8853 mstfknn/tor-proxy
```

## Features

- Routes traffic through the Tor network for anonymity.
- Lightweight and easy to deploy.
- Exposes standard SOCKS5 proxy port **9150**.
- Exposes DNS over Tor on port **8853** (TCP/UDP).
- DNS over Tor is supported.
- Configurable via environment variables.

## Testing

To test the proxy, configure your application to use the SOCKS5 proxy at `localhost:9150` and verify your IP address is different from your original IP by visiting a service like https://check.torproject.org.

For DNS over Tor, point your DNS resolver to `localhost:8853` (TCP/UDP).

## GitHub

[https://github.com/mstfknn](https://github.com/mstfknn)

---

## Alpine-based Image

For a smaller image, use the Alpine-based variant:

```bash
docker pull mstfknn/tor-proxy:alpine
docker run -d -p 9150:9150 -p 8853:8853 mstfknn/tor-proxy:alpine
```
