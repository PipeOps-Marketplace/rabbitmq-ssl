# RabbitMQ on PipeOps

This template deploys an instance of [RabbitMQ](https://www.rabbitmq.com/) on PipeOps with SSL enabled for secure messaging.

## Features

- One-click deploy of RabbitMQ with SSL (AMQP over 5671, management UI over 15671)
- Pre-configured SSL certificates (see `certs/` directory)
- Secure RabbitMQ management UI
- Customizable configuration via `rabbitmq.conf`

## Usage

1. **Deploy to PipeOps**: Click the deploy button above (if available) or use your preferred deployment method.

2. **SSL Certificates**: If you do not provide your own, self-signed SSL certificates will be generated automatically on container startup and placed in the `certs/` directory. For custom certificates, place your SSL certificates in the `certs/` directory before building the image.

3. **Configuration**: Edit `rabbitmq.conf` to adjust listeners, SSL options, and other settings as needed. The default configuration enables SSL for both AMQP and the management UI.

4. **Build & Run**:

   ```sh
   docker build -t rabbitmq-ssl .
   docker run -d -p 5671:5671 -p 15671:15671 --name rabbitmq-ssl rabbitmq-ssl
   ```

5. **Access Management UI**: Visit `https://localhost:15671` in your browser (accept the self-signed certificate if prompted).

## Configuration

- See [`rabbitmq.conf`](./rabbitmq.conf) for all available options.
- See the [RabbitMQ Configuration Guide](https://www.rabbitmq.com/configure.html#config-file) for more details.

## SSL Certificates

- By default, self-signed certificates are generated automatically if none are present in the `certs/` directory.
- To use your own certificates, place your CA, server certificate, and key in the `certs/` directory before building the image.
- For manual self-signed cert generation, see [`certs/README.md`](./certs/README.md).

## Links

- [RabbitMQ](https://github.com/rabbitmq/rabbitmq-server)
- [RabbitMQ Configuration](https://www.rabbitmq.com/configure.html#config-file)

---

*Note: The quickstart NodeJS consumer/producer apps referenced in the original template are not included in this repository. You can add your own apps or scripts as needed to connect to RabbitMQ over SSL.*