FROM fedora:33

# PHP 7.4/PHP custom ini/upgrades
RUN dnf -y install https://rpms.remirepo.net/fedora/remi-release-33.rpm
RUN dnf -y module install php:remi-7.4/common
RUN dnf -y install php php-fpm php-common procps findutils net-tools
RUN dnf -y install php-bcmath php-ctype php-curl php-opcache php-pecl-apcu php-cli php-pear \
    php-dom php-hash php-iconv php-intl php-pdo php-imap php-json php-gd php-mbstring php-mcrypt php-xml \
    php-openssl php-pdo_mysql php-simplexml php-soap php-xsl php-zip php-libxml php-sockets php-xdebug unzip
COPY /docker/php/custom.ini /etc/php.d/local-overrides.ini

# Supervisor
RUN dnf -y install supervisor
COPY /docker/common/supervisord.conf /etc/supervisord.conf

# Install composer and copy auth
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
COPY auth.json /root/.config/composer/auth.json

# NGINX and configuration (Most of this should work as is)
#RUN sudo dnf -y install nginx
#RUN touch /var/log/nginx/error.log /var/log/nginx/error.log
#COPY /docker/nginx/conf.d/nginx.conf /etc/nginx/
#COPY /docker/nginx/conf.d/default.conf /etc/nginx/conf.d/
#RUN sudo mkdir /etc/nginx/sites-available
#COPY /docker/nginx/conf.d/nginx_vhost.conf /etc/nginx/sites-avilable/magento
#RUN ln -s /etc/nginx/sites-available/magento /etc/nginx/sites-enabled
#RUN sudo systemctl enable nginx

# Apache configuration
COPY /docker/apache/httpd.conf /etc/httpd/conf/httpd.conf
COPY /docker/apache/magento2.conf /etc/httpd/conf.d/magento2.conf


# Copy Magento 2 setup and install scripts
COPY appsetup/*.sh /usr/bin/
RUN chmod +x /usr/bin/m2install.sh /usr/bin/m2setup.sh

RUN mkdir -p /run/php-fpm && chown -R apache:apache /run/php-fpm

CMD ["/usr/bin/supervisord", "-n"]
