#!/bin/sh
set -e

TORRC="/tmp/torrc"

# Default values
SOCKS_PORT="${SOCKS_PORT:-9150}"
DNS_PORT="${DNS_PORT:-5353}"

# Generate torrc
cat > "$TORRC" <<EOF
SocksPort 0.0.0.0:${SOCKS_PORT}
DNSPort 0.0.0.0:${DNS_PORT}
DataDirectory /var/lib/tor
EOF

# Logging
if [ "${ENABLE_LOG}" = "true" ]; then
  echo "Log notice stdout" >> "$TORRC"
else
  echo "Log notice file /dev/null" >> "$TORRC"
fi

# Exit nodes (country selection)
if [ -n "${EXIT_NODES}" ]; then
  echo "ExitNodes ${EXIT_NODES}" >> "$TORRC"
  echo "StrictNodes ${STRICT_NODES:-0}" >> "$TORRC"
fi

# Bridge support
if [ "${USE_BRIDGE}" = "true" ]; then
  echo "UseBridges 1" >> "$TORRC"

  case "${BRIDGE_TYPE}" in
    obfs4)
      echo "ClientTransportPlugin obfs4 exec /usr/bin/obfs4proxy" >> "$TORRC"
      ;;
    meek)
      echo "ClientTransportPlugin meek_lite exec /usr/bin/obfs4proxy" >> "$TORRC"
      ;;
    snowflake)
      echo "ClientTransportPlugin snowflake exec /usr/bin/snowflake-client" >> "$TORRC"
      ;;
  esac

  # Add bridge lines (semicolon or newline separated)
  if [ -n "${BRIDGE_LINES}" ]; then
    echo "${BRIDGE_LINES}" | tr ';' '\n' | while IFS= read -r line; do
      line=$(echo "$line" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
      [ -n "$line" ] && echo "Bridge ${line}" >> "$TORRC"
    done
  fi
fi

exec tor -f "$TORRC"
