## Dockerfile: Debian - PHP-QA

[![Build Status](https://travis-ci.org/ericmdev/dockerfile.php-qa.svg?branch=master)](https://travis-ci.org/ericmdev/dockerfile.php-qa)

**Dockerfile** of [Debian](https://www.debian.org/) [PHP](http://php.net/manual/en/book.fpm.php) QA tools.

- CA Certificates
- Curl
- Firefox
- Git
- Java
- Nano
- NGINX
- OpenSSL
- PHP 5.6
- PHP Composer
    + phpunit
    + phpunit-selenium
    + phpdocumentor
    + phpcpd
    + phploc
    + phpmd
    + php_codesniffer
- Selenium
- Supervisor
- Wget
- X virtual framebuffer

*Requirements*
- [Docker](https://www.docker.com/) 

*Base Docker Image*
- [re6exp/debian-jessie-oracle-jdk-8](https://github.com/re6exp/debian-jessie-oracle-jdk-8)

*Processes*
- nginx 
- php-fpm (5.6.14)
- java
- selenium
- firefox

*Docker Pull Command*
- `docker pull ericmdev/php-qa`

### Development

    $ docker build -t php-qa-image -f ./Dockerfile .

Creates the image `php-qa-image`.

### Usage

    $ docker run -d --name=php-qa-container -p 8080:80 php-qa-image

Runs the container `php-qa-container`.