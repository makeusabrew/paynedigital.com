FROM pd/base
MAINTAINER Nick Payne <nick@kurai.co.uk>

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install php5-cli php5-mysql php5-curl wget

RUN wget --no-check-certificate -O /phpunit https://phar.phpunit.de/phpunit.phar
RUN chmod +x /phpunit

# php default timezone
# @see https://gist.github.com/taion809/6850072
RUN perl -pi -e "s#;date.timezone =#date.timezone = Europe/London#g" /etc/php5/cli/php.ini

ADD . /var/www

ENTRYPOINT ["/phpunit", "-c", "/var/www"]
