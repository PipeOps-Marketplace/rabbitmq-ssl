# RabbitMQ on PipeOps

This template deploys an instance of [RabbitMQ](https://www.rabbitmq.com/) on PipeOps with SSL enabled for secure messaging.

## Features

- One-click deploy of RabbitMQ with SSL (AMQP over 5671, management UI over 15672)
- Pre-configured SSL certificates (see `certs/` directory)
- Secure RabbitMQ management UI
- Customizable configuration via `rabbitmq.conf`

## Usage

1. **Deploy to PipeOps**: Click the deploy button above (if available) or use your preferred deployment method.

2. **SSL Certificates**: If you do not provide your own, self-signed SSL certificates will be generated automatically on container startup and placed in the `certs/` directory. For custom certificates, place your SSL certificates in the `certs/` directory before building the image.

3. **Configuration**: Edit `rabbitmq.conf` to adjust listeners, SSL options, and other settings as needed. The default configuration enables SSL for AMQP.

4. **Build & Run**:

   ```sh
   docker build -t rabbitmq-ssl --build-arg PIPEOPS_PROJECT_NAME=your-project-name .
   docker run -d -p 5671:5671 -p 15672:15672 --name rabbitmq-ssl rabbitmq-ssl
   # To persist RabbitMQ data:
   # docker run -d -p 5671:5671 -p 15672:15672 \
   #   -v /your/host/path/rabbitmq-data:/var/lib/rabbitmq \
   #   --name rabbitmq-ssl rabbitmq-ssl
   ```

5. **Access Management UI**: Visit `http://localhost:15672` in your browser.

## Configuration

- See [`rabbitmq.conf`](./rabbitmq.conf) for all available options.
- See the [RabbitMQ Configuration Guide](https://www.rabbitmq.com/configure.html#config-file) for more details.

## SSL Certificates

- By default, self-signed certificates are generated automatically if none are present in the `certs/` directory.
- **For production:** Use a certificate signed by a trusted Certificate Authority (CA) such as Let's Encrypt. Place your CA certificate (`ca.crt`), server certificate (`server.crt`), and private key (`server.key`) in the `certs/` directory before building the image. This will allow clients to trust the RabbitMQ server automatically.
- For manual self-signed cert generation, see [`certs/README.md`](./certs/README.md).
- **Important:** If you use self-signed certificates, your client must trust the generated CA certificate (`certs/ca.crt`). Download this file from the container or the `certs/` directory and configure your client to use it as a trusted CA.

## Links

- [RabbitMQ](https://github.com/rabbitmq/rabbitmq-server)
- [RabbitMQ Configuration](https://www.rabbitmq.com/configure.html#config-file)

---

**Quickstart Go Consumer/Producer**: For a ready-to-use Go example that connects to RabbitMQ over SSL, see [`QUICKSTART-GO.md`](./QUICKSTART-GO.md) in this repository. This guide is based on [pipeops-dev/rabbitmq-test](https://github.com/pipeops-dev/rabbitmq-test) and demonstrates how to connect, publish, and consume messages securely using Go.

---

**Note**:

- AMQP (queue) port 5671 is secured with SSL.
- The management UI runs on port 15672 without SSL (HTTP only).
- Only the AMQP port (5671) uses SSL. The management UI is available over HTTP (port 15672).
- The SSL certificate's Common Name (CN) and Subject Alternative Name (SAN) will match the value of the `PIPEOPS_PROJECT_NAME` build argument, if provided. This ensures SSL validation works for your chosen project/hostname.