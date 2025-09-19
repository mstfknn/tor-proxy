# Tor Proxy with Docker

This project provides a Dockerized Tor proxy server that routes your internet traffic through the Tor network using a SOCKS5 proxy with DNS support.

## Features

- SOCKS5 proxy with DNS resolution through Tor
- Runs inside a Docker container for easy deployment
- No need to install Tor or configure it manually on your host
- Supports both HTTP and HTTPS traffic routing via SOCKS5

## Prerequisites

- Docker installed on your system
- Basic knowledge of Docker commands

## Installation

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/tor-proxy.git
   ```
2. Navigate to the project directory:
   ```
   cd tor-proxy
   ```

## Usage

### Build the Docker image (Debian - default)
```
docker build -t tor-proxy .
```

### Run the container (Debian - default)
```
docker run -d --name tor-proxy -p 9150:9150 -p 8853:8853 tor-proxy
```

- Port `9150` is for the SOCKS5 proxy
- Port `8853` is for DNS resolution through Tor

### Alternative Alpine Build

Alpine is a minimal alternative to the default Debian-based image.

#### Build the Alpine Docker image
```
docker build -t tor-proxy:alpine -f Dockerfile.alpine .
```

#### Run the Alpine container
```
docker run -d --name tor-proxy-alpine -p 9150:9150 -p 8853:8853 tor-proxy:alpine
```

### Configure Applications

Set your application's SOCKS5 proxy to `localhost:9150`. DNS requests will be routed through Tor automatically via port `8853`.

## Configuration

You can customize the Tor configuration by modifying the `torrc` file inside the container or by extending the Docker image.

## Contributing

Contributions are welcome! Feel free to open issues or submit pull requests.

## License

This project is licensed under the MIT License.

## 🔗 Links

- 🐳 [Docker Hub Image](https://hub.docker.com/r/mstfknn/tor-proxy)
