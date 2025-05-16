#!/bin/bash
set -e

CERT_DIR="/etc/rabbitmq/certs"
OPENSSL_CONF="$CERT_DIR/openssl-wildcard.cnf"
SERVER_CERT="$CERT_DIR/server.crt"
SERVER_KEY="$CERT_DIR/server.key"

# Generate wildcard SSL cert if not present
if [[ ! -f "$SERVER_CERT" || ! -f "$SERVER_KEY" ]]; then
  echo "[entrypoint] Generating wildcard SSL certificate..."
  mkdir -p "$CERT_DIR"
  openssl req -new -x509 -days 365 -nodes -out "$SERVER_CERT" -keyout "$SERVER_KEY" -config "$OPENSSL_CONF" -extensions v3_req
  chown rabbitmq:rabbitmq "$SERVER_CERT" "$SERVER_KEY"
else
  echo "[entrypoint] Using existing SSL certificates."
fi

exec rabbitmq-server
