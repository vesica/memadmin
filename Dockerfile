# Base image
FROM quay.io/vesica/php72:latest

ENV MEMADMIN_USERNAME "vesica"
ENV MEMADMIN_PASSWORD "vesica"
ENV MEMCACHED_HOST "memcached"
ENV MEMCACHED_PORT 11211

# Application files
ADD composer.json /var/www/composer.json

RUN cd /var/www && composer install --no-interaction --no-scripts \
  && cp -R /var/www/vendor/clickalicious/phpmemadmin/app /var/www/ \
  && cp -R /var/www/vendor/clickalicious/phpmemadmin/bin /var/www/ \
  && cp -R /var/www//vendor/clickalicious/phpmemadmin/web /var/www/
ADD config.json /var/www/app/.config

COPY updateConfig.sh /usr/local/bin/updateConfig.sh
RUN chmod 755 /usr/local/bin/updateConfig.sh

# Symbolic link for Apache
RUN rm -rf /var/www/html \
  && ln -s /var/www/web /var/www/html

CMD ["/usr/local/bin/updateConfig.sh"]

