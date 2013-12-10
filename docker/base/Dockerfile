FROM ubuntu:12.10

MAINTAINER Nick Payne <nick@kurai.co.uk>

# Make sure we're all up to date with package sources
RUN apt-get -y update

# stop ubuntu services whinging about upstart stuff
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -s /bin/true /sbin/initctl
