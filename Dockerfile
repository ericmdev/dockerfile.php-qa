# Debian: PHP-QA
#
# VERSION 0.0.1

#
# Pull the base image.
#
FROM re6exp/debian-jessie-oracle-jdk-8

#
# Set author.
#
MAINTAINER Eric Mugerwa <dev@ericmugerwa.com>

# Set environment variables.
ENV FILES docker/files/
ENV NGINX_VERSION 1.9.9-1~jessie

# Install Wget Git Nano.
#
# 	- wget
# 	- git
# 	- nano
RUN apt-get update && \
    apt-get install -y wget git nano

# Install NGINX.
# 
# 	- openssl
# 	- ca-certificates
# 	- nginx
RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62
RUN echo "deb http://nginx.org/packages/mainline/debian/ jessie nginx" >> /etc/apt/sources.list

RUN apt-get update && \
    apt-get install -y openssl ca-certificates nginx=${NGINX_VERSION}

# Remove default configuration files.
RUN rm -rf /etc/nginx/nginx.conf
RUN rm -rf /etc/nginx/conf.d/*

# Add managed nginx configuration files.
ADD ${FILES}/etc/nginx/nginx.conf /etc/nginx/
ADD ${FILES}/etc/nginx/conf.d/php-qa-app.conf /etc/nginx/conf.d/
ADD ${FILES}/etc/nginx/fastcgi_params /etc/nginx/
ADD ${FILES}/etc/nginx/conf.d/php-upstream.conf /etc/nginx/conf.d/upstream.conf

# Remove default directories.
RUN rm -rf /var/www/*
RUN rm -rf /srv/www/*

# Forward request and error logs to docker log collector.
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

# Install X virtual framebuffer.
#
# 	- Xvfb
#
RUN apt-get update && \
	apt-get install -y xvfb

# Install Firefox.
#
RUN echo "deb http://packages.linuxmint.com debian import" >> /etc/apt/sources.list

RUN apt-key update && \
	apt-get update && \
	apt-get install -y --force-yes firefox

# Download Selenium standalone server.
RUN wget http://selenium.googlecode.com/files/selenium-server-standalone-2.35.0.jar -P /opt

# Install PHP 5.
#
# 	- php5-dev
#	- php5-common
#	- php5-pear
# 	- php5-cli
# 	- php5-fpm
# 	- php5-mcrypt
# 	- php5-mysql
# 	- php5-apcu
# 	- php5-gd
# 	- php5-imagick
# 	- php5-curl
# 	- php5-intl
RUN apt-get update && \
    apt-get install -y php5-dev php5-common php5-cli php5-fpm php5-mcrypt php5-mysql php5-apcu php5-gd php5-imagick php5-curl php5-intl

# Add managed php ini files.
ADD ${FILES}/etc/php5/fpm/conf.d/php-qa-app.ini /etc/php5/fpm/conf.d/
ADD ${FILES}/etc/php5/fpm/conf.d/php-qa-app.ini /etc/php5/cli/conf.d/
ADD ${FILES}/etc/php5/fpm/pool.d/php-qa-app.pool.conf /etc/php5/fpm/pool.d/

# Install Curl
RUN apt-get update && \
	apt-get install curl

# Install PHP Composer.
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer --version

# Install PHP Composer dependecies.
#
# - phpunit
# - phpunit-selenium
RUN composer global require phpunit/phpunit && \
	composer global require phpunit/phpunit-selenium

# Install PHP Composer dependecies
#
# - phpdocumentor
# - phpcpd
# - phploc
# - phpmd
# - php_codesniffer
RUN composer global require phpdocumentor/phpdocumentor && \
	composer global require sebastian/phpcpd && \
	composer global require phploc/phploc && \
	composer global require phpmd/phpmd && \
	composer global require squizlabs/php_codesniffer

# composer global require phpunit/dbunit
# composer global require phing/phing

# Install Supervisor.
# 
RUN apt-get update && \
	apt-get install -y supervisor

# Add managed supervisor configuration files.
ADD ${FILES}/etc/supervisor/conf.d/supervisord.conf /etc/supervisor/conf.d/supervisord.conf 

# Define mountable directories.
VOLUME ["/srv/www", "/etc/nginx", "/var/log/nginx/", "/var/cache/nginx"]

# Listen on http https ports.
EXPOSE 80 443

# Configure executable.
ENTRYPOINT ["/usr/bin/supervisord"]

# Define default command.
CMD []