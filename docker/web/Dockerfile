FROM pd/base

MAINTAINER Nick Payne <nick@kurai.co.uk>

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install apache2 libapache2-mod-php5 php5-mysql

# php default timezone
# @see https://gist.github.com/taion809/6850072
RUN perl -pi -e "s#;date.timezone =#date.timezone = Europe/London#g" /etc/php5/apache2/php.ini

# any custom apache modules
RUN a2enmod rewrite

ADD . /var/www

ADD ./docker/web/apache.conf /etc/apache2/sites-enabled/000-default

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2

ENTRYPOINT ["/usr/sbin/apache2", "-D", "FOREGROUND"]
