FROM pd/base

MAINTAINER Nick Payne <nick@kurai.co.uk>

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-server mysql-client

ADD ./docker/mysql/configure.sh /configure-mysql.sh
RUN /bin/bash /configure-mysql.sh

EXPOSE 3306

ENTRYPOINT ["/usr/bin/mysqld_safe", "--skip-syslog", "--bind-address=0.0.0.0"]
