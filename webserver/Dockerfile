FROM php:7.0-apache

# Install MySQL extension.
RUN apt-get update \
  && apt-get install -y libpng12-dev libjpeg-dev \
  && rm -rf /var/lib/apt/lists/* \
  && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
  && docker-php-ext-install gd mysqli

# Initializaton script.
ADD init.sh /root/init.sh

ENTRYPOINT ["/bin/sh", "/root/init.sh"]
