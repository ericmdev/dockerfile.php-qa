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
- Selenium 2.49.1
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

### Selenium

*Create Xvfb display:*

    # Get the path to Xvfb.
    whereis Xvfb
    # Now create a screen.
    /usr/bin/Xvfb :1 -screen 0 1024x768x24 &
    # Export display.
    export DISPLAY=:1

*Start Selenium server:*

    java -jar /opt/selenium-server-standalone-2.49.1.jar -port 4444

*Shutdown Selenium server:*

    http://localhost:4444/selenium-server/driver/?cmd=shutDownSeleniumServer

Expected output:

    INFO - Launching a standalone Selenium Server
    INFO - Java: Oracle Corporation 25.40-b25
    INFO - OS: Linux 4.1.13-boot2docker amd64
    INFO - v2.49.1, with Core v2.49.1. Built from revision 7203e46
    INFO - Driver provider org.openqa.selenium.ie.InternetExplorerDriver registration is skipped:
    registration capabilities Capabilities [{ensureCleanSession=true, browserName=internet explorer, version=, platform=WINDOWS}] does not match the current platform LINUX
    INFO - Driver provider org.openqa.selenium.edge.EdgeDriver registration is skipped:
    registration capabilities Capabilities [{browserName=MicrosoftEdge, version=, platform=WINDOWS}] does not match the current platform LINUX
    INFO - Driver class not found: com.opera.core.systems.OperaDriver
    INFO - Driver provider com.opera.core.systems.OperaDriver is not registered
    INFO - Driver provider org.openqa.selenium.safari.SafariDriver registration is skipped:
    registration capabilities Capabilities [{browserName=safari, version=, platform=MAC}] does not match the current platform LINUX
    INFO - RemoteWebDriver instances should connect to: http://127.0.0.1:4444/wd/hub
    INFO - Selenium Server is up and running

### PHPUnit Functional Tests

For the example application.

    cd /ex-app/
    phpunit --configuration phpunit.xml --testsuite "Functional Test Suite"
