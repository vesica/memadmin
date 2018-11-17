# Base image
FROM vesica/php72:latest

ENV MEMCACHED_USERNAME "vesica"
ENV MEMCACHED_PASSWORD "vesica"
ENV MEMCACHED_HOST "memcached"
ENV PORT 11211

# Application files
ADD composer.json /var/www/composer.json

RUN cd /var/www && composer install --no-interaction --no-scripts \
  && cp -R /var/www/vendor/clickalicious/phpmemadmin/app /var/www/ \
  && cp -R /var/www/vendor/clickalicious/phpmemadmin/bin /var/www/ \
  && cp -R /var/www//vendor/clickalicious/phpmemadmin/web /var/www/
ADD config.json /var/www/app/.config

RUN sed -i 's/##MEMCACHED_USERNAME##/$MEMCACHED_USERNAME/g' /var/www/app/.config
RUN sed -i 's/##MEMCACHED_PASSWORD##/$MEMCACHED_PASSWORD/g' /var/www/app/.config
RUN sed -i 's/##MEMCACHED_HOST##/$MEMCACHED_HOST/g' /var/www/app/.config
RUN sed -i 's/##MEMCACHED_PORT##/$MEMCACHED_PORT/g' /var/www/app/.config


# Symbolic link for Apache
RUN rm -rf /var/www/html \
  && ln -s /var/www/web /var/www/html

