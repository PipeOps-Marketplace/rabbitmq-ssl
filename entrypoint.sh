#!/bin/bash
set -e

CERT_DIR="/etc/rabbitmq/certs"
SERVER_KEY="$CERT_DIR/server.key"
SERVER_CSR="$CERT_DIR/server.csr"
SERVER_CERT="$CERT_DIR/server.crt"
CA_KEY="$CERT_DIR/ca.key"
CA_CERT="$CERT_DIR/ca.crt"
CA_SERIAL="$CERT_DIR/ca.srl"
PROJECT_NAME="${PIPEOPS_PROJECT_NAME}"

# Generate CA and server certs if not present
if [[ ! -f "$SERVER_CERT" || ! -f "$SERVER_KEY" || ! -f "$CA_CERT" || ! -f "$CA_KEY" ]]; then
  echo "[entrypoint] Generating CA and server certificates for CN=$PROJECT_NAME ..."
  mkdir -p "$CERT_DIR"
  # Generate CA key and cert
  openssl req -new -x509 -days "${SSL_CERT_DAYS:-820}" -nodes -out "$CA_CERT" -keyout "$CA_KEY" -subj "/CN=RabbitMQ-CA"
  # Generate server key and CSR
  openssl req -new -nodes -out "$SERVER_CSR" -keyout "$SERVER_KEY" -subj "/CN=$PROJECT_NAME" -addext "subjectAltName=DNS:$PROJECT_NAME"
  # Sign server cert with CA
  openssl x509 -req -in "$SERVER_CSR" -CA "$CA_CERT" -CAkey "$CA_KEY" -CAcreateserial -out "$SERVER_CERT" -days "${SSL_CERT_DAYS:-820}" -extensions v3_req -extfile <(printf "[v3_req]\nsubjectAltName=DNS:$PROJECT_NAME")
  chown rabbitmq:rabbitmq "$SERVER_CERT" "$SERVER_KEY" "$CA_CERT" "$CA_KEY"
else
  echo "[entrypoint] Using existing SSL certificates."
fi

exec rabbitmq-server
