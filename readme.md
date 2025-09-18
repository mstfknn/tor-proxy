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

### Build the Docker image
```
docker build -t tor-proxy .
```

### Run the container
```
docker run -d --name tor-proxy -p 9050:9050 -p 9053:9053 tor-proxy
```

- Port `9050` is for the SOCKS5 proxy
- Port `9053` is for DNS resolution through Tor

### Configure Applications

Set your application's SOCKS5 proxy to `localhost:9050`. DNS requests will be routed through Tor automatically via port `9053`.

## Configuration

You can customize the Tor configuration by modifying the `torrc` file inside the container or by extending the Docker image.

## Contributing

Contributions are welcome! Feel free to open issues or submit pull requests.

## License

This project is licensed under the MIT License.
