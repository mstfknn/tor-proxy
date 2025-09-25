<p align="center">
  <img src="https://www.torproject.org/static/images/tor-logo/Purple.png" alt="Tor Proxy Logo"/>
</p>

# Tor Proxy with Docker

This project provides a Dockerized Tor proxy server that routes your internet traffic through the Tor network using a SOCKS5 proxy with DNS support.

## Features

- SOCKS5 proxy with DNS resolution through Tor
- Runs inside a Docker container for easy deployment
- No need to install Tor or configure it manually on your host
- Supports both HTTP and HTTPS traffic routing via SOCKS5
- Available on both **Docker Hub** and **GitHub Container Registry (GHCR)**

## Prerequisites

- Docker installed on your system
- Basic knowledge of Docker commands

## Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/mstfknn/tor-proxy.git
   cd tor-proxy
   ```

## Usage

### Pull pre-built images

You can pull images directly from Docker Hub or GHCR:

**Docker Hub**
```sh
docker pull mstfknn/tor-proxy:debian
docker pull mstfknn/tor-proxy:alpine
```

**GitHub Container Registry (GHCR)**
```sh
docker pull ghcr.io/mstfknn/tor-proxy:debian
docker pull ghcr.io/mstfknn/tor-proxy:alpine
```

### Run the container (Debian - default)
```sh
docker run -d --name tor-proxy -p 9150:9150 -p 8853:8853 mstfknn/tor-proxy:debian
```

- Port `9150` → SOCKS5 proxy
- Port `8853` → DNS resolution through Tor

### Run the container (Alpine - minimal)
```sh
docker run -d --name tor-proxy-alpine -p 9150:9150 -p 8853:8853 mstfknn/tor-proxy:alpine
```

### Configure Applications

Set your application's SOCKS5 proxy to `localhost:9150`.
DNS requests will be routed through Tor automatically via port `8853`.

## Configuration

You can customize the Tor configuration by modifying the `torrc` file inside the container or by extending the Docker image.

## Contributing

Contributions are welcome! Feel free to open issues or submit pull requests.

## License

This project is licensed under the MIT License.

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
