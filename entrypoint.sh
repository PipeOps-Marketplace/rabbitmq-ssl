#!/bin/bash
set -e

CERT_DIR="/etc/rabbitmq/certs"
CA_CERT="$CERT_DIR/ca.crt"
SERVER_CERT="$CERT_DIR/server.crt"
SERVER_KEY="$CERT_DIR/server.key"

# Generate self-signed certs if not present
if [[ ! -f "$CA_CERT" || ! -f "$SERVER_CERT" || ! -f "$SERVER_KEY" ]]; then
  echo "[entrypoint] Generating self-signed SSL certificates..."
  mkdir -p "$CERT_DIR"
  openssl req -x509 -newkey rsa:4096 -keyout "$SERVER_KEY" -out "$SERVER_CERT" -days 365 -nodes -subj "/CN=localhost"
  cp "$SERVER_CERT" "$CA_CERT"
  chown rabbitmq:rabbitmq "$CA_CERT" "$SERVER_CERT" "$SERVER_KEY"
else
  echo "[entrypoint] Using existing SSL certificates."
fi

exec rabbitmq-server
