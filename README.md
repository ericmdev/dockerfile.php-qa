## Docker-Compose: Debian - PHP QA Hub

[![Build Status](https://travis-ci.org/ericmdev/php-qa-hub.docker-compose.svg?branch=master)](https://travis-ci.org/ericmdev/php-qa-hub.docker-compose)

**Docker orchestration**  of [Debian](https://www.debian.org/) [PHP](http://php.net/manual/en/book.fpm.php) QA hub for continuous inspection of PHP projects:

- phpdocumentor
- phpcpd
- phploc
- phpmd
- pdepend
- php_codesniffer
- phpunit
- selenium
- sonarqube

*Requirements*
- [Docker](https://www.docker.com/) 

*Docker Images*
- [ericmdev/srv-www](https://hub.docker.com/r/ericmdev/srv-www/)
- [ericmdev/php-qa-tools](https://hub.docker.com/r/ericmdev/php-qa-tools/)
- [ericmdev/selenium](https://hub.docker.com/r/ericmdev/selenium/)
- [sonarqube:5.1](https://hub.docker.com/_/sonarqube/)

### Usage

#### Native Docker

Builds the services in `docker-compose.yml`.

    $ docker-compose build

Create and start the services in `docker-compose.yml`.

    $ docker-compose up -d
    $ docker-compose ps

Now you can dig into the containers:

    $ docker exec -it <name> bash

#### Vagrant

    $ vagrant up

*See `config/vagrant/` for configuration options.

*Plugins*
- [vagrant-docker-compose](https://github.com/leighmcculloch/vagrant-docker-compose)
    - `$ vagrant plugin install vagrant-docker-compose`
