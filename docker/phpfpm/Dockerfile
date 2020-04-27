FROM php:7.3.12-fpm-alpine3.10

RUN apk add --no-cache \
    libpng libpng-dev libjpeg-turbo-dev freetype-dev \
    zlib-dev libzip-dev \
    libmcrypt-dev libintl icu icu-dev libxml2-dev \
    libxslt-dev \
    php7-bcmath php7-sockets \
    && docker-php-ext-configure gd  \
        --with-jpeg-dir=/usr/include/ --with-freetype-dir=/usr/include \
    && docker-php-ext-install \
        gd pdo_mysql intl \
        xsl bcmath  soap \
    && docker-php-ext-configure zip --with-libzip \
    && docker-php-ext-install zip

RUN docker-php-ext-install sockets

RUN apk update \
    && apk add --virtual build-dependencies \
        build-base \
        gcc

RUN curl -sS https://getcomposer.org/installer | \
  php -- --install-dir=/usr/local/bin --filename=composer


#Installing xdebug
RUN apk add --no-cache $PHPIZE_DEPS \
	&& pecl install xdebug-2.7.0 \
	&& docker-php-ext-enable xdebug \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    #    && echo "xdebug.profiler_enable=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
    #    && echo "xdebug.profiler_append=On" >> /usr/local/etc/php/conf.d/xdebug.ini \
    #    && echo "xdebug.profiler_output_dir=\"/src/www/var/log/\"" >> /usr/local/etc/php/conf.d/xdebug.ini \
    #    && echo "xdebug.profiler_output_name=\"cachegrind.out.%R-%t-%s\"" >> /usr/local/etc/php/conf.d/xdebug.ini \
#    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_connect_back=0" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.idekey=\"PHPSTORM\"" >> /usr/local/etc/php/conf.d/xdebug.ini



ADD crontab /crontab.www-data
RUN crontab -u www-data /crontab.www-data; \
  chmod +x /start.sh; \
  touch /var/log/syslog; \
  touch /var/log/cron.log;


# Install mailhog.
RUN curl -fSL "https://github.com/mailhog/MailHog/releases/download/v1.0.0/MailHog_linux_amd64" -o /usr/local/bin/mailhog \
    && chmod +x /usr/local/bin/mailhog

COPY ./mailhog.ini /usr/local/etc/php/conf.d/mailhog.ini

COPY ./php.ini /usr/local/etc/php/conf.d/php.ini

RUN sed -i -e '/pm.max_children =/ s/= .*/= 10/' /usr/local/etc/php-fpm.d/www.conf

CMD ["php-fpm"]