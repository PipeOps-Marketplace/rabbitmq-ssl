FROM rabbitmq:3.12-management

ARG RABBITMQ_DEFAULT_USER
ARG RABBITMQ_DEFAULT_PASS
ARG RABBITMQ_DEFAULT_VHOST

RUN rabbitmq-plugins enable --offline rabbitmq_mqtt rabbitmq_federation_management rabbitmq_stomp

# Copy configuration and SSL certs
COPY rabbitmq.conf /etc/rabbitmq/rabbitmq.conf
COPY certs/ /etc/rabbitmq/certs/

# Set permissions
RUN chown -R rabbitmq:rabbitmq /etc/rabbitmq/certs

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose AMQP SSL and management HTTP ports
EXPOSE 5671 5672 15672

# Start RabbitMQ with entrypoint
ENTRYPOINT ["/entrypoint.sh"]
