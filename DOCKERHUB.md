# tor-proxy

A lightweight, privacy-focused proxy server using Tor network.

## Quick Start

```bash
docker pull mstfknn/tor-proxy
docker run -d -p 9050:9050 mstfknn/tor-proxy
```

## Features

- Routes traffic through the Tor network for anonymity.
- Lightweight and easy to deploy.
- Exposes standard SOCKS5 proxy port 9050.
- Configurable via environment variables.

## Testing

To test the proxy, configure your application to use the SOCKS5 proxy at `localhost:9050` and verify your IP address is different from your original IP by visiting a service like https://check.torproject.org.

## GitHub

Find the source code and contribute at: [https://github.com/mstfknn/tor-proxy](https://github.com/mstfknn/tor-proxy)
