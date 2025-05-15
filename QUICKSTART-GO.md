# Quickstart: Go RabbitMQ SSL Consumer/Producer

This quickstart demonstrates how to connect to your RabbitMQ instance (with SSL enabled) using a Go application. It is based on the [pipeops-dev/rabbitmq-test](https://github.com/pipeops-dev/rabbitmq-test) project.

## Prerequisites

- Go 1.18+
- The `amqp091-go` package (`go get github.com/rabbitmq/amqp091-go`)
- Access to your RabbitMQ server with SSL enabled (see this repo's main README for setup)
- The CA certificate used by your RabbitMQ server (for local testing, see `certs/ca.crt`)

## Example Usage

1. **Clone the Example**

```sh
git clone https://github.com/pipeops-dev/rabbitmq-test.git
cd rabbitmq-test
```

2. **Set the RabbitMQ URL**

Set the `RABBITMQ_URL` environment variable to use the `amqps://` protocol and point to your RabbitMQ server. For example:

```sh
export RABBITMQ_URL="amqps://guest:guest@<addon-name>:5671/"
```

1. **Run the Example**

```sh
go run main.go
```

The app will:
- Connect to RabbitMQ over SSL
- Periodically publish messages to a queue
- Consume and print messages from the queue

## Reference

- [pipeops-dev/rabbitmq-test](https://github.com/pipeops-dev/rabbitmq-test)
- [RabbitMQ Go Client](https://pkg.go.dev/github.com/rabbitmq/amqp091-go)
