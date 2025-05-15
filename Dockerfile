FROM rabbitmq:3.12-management

# Copy configuration and SSL certs
COPY rabbitmq.conf /etc/rabbitmq/rabbitmq.conf
COPY certs/ /etc/rabbitmq/certs/

# Set permissions
RUN chown -R rabbitmq:rabbitmq /etc/rabbitmq/certs

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose SSL ports
EXPOSE 5671 15671

# Start RabbitMQ with entrypoint
ENTRYPOINT ["/entrypoint.sh"]
