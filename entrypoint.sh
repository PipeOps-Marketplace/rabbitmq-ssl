#!/bin/bash
set -e

CERT_DIR="/etc/rabbitmq/certs"
OPENSSL_CONF="$CERT_DIR/openssl-wildcard.cnf"
SERVER_CERT="$CERT_DIR/server.crt"
SERVER_KEY="$CERT_DIR/server.key"
CA_CERT="$CERT_DIR/ca.crt"
PROJECT_NAME="${PIPEOPS_PROJECT_NAME}"

# Generate SSL cert for the project/hostname if not present
if [[ ! -f "$SERVER_CERT" || ! -f "$SERVER_KEY" ]]; then
  echo "[entrypoint] Generating SSL certificate for CN=$PROJECT_NAME ..."
  mkdir -p "$CERT_DIR"
  openssl req -new -x509 -days 365 -nodes -out "$SERVER_CERT" -keyout "$SERVER_KEY" -subj "/CN=$PROJECT_NAME" -addext "subjectAltName=DNS:$PROJECT_NAME"
  cp "$SERVER_CERT" "$CA_CERT"
  chown rabbitmq:rabbitmq "$SERVER_CERT" "$SERVER_KEY" "$CA_CERT"
else
  echo "[entrypoint] Using existing SSL certificates."
fi

exec rabbitmq-server
