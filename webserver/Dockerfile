FROM php:7.0-apache

# Install MySQL extension.
RUN apt-get update && apt-get install -y mysql-client libmysqlclient-dev \
      && docker-php-ext-install mysqli

# Initializaton script.
ADD init.sh /root/init.sh

ENTRYPOINT ["/bin/sh", "/root/init.sh"]
