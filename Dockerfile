FROM phusion/baseimage
MAINTAINER Ben.Liu <ben196888@gmail.com>

RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/10gen.list

RUN apt-get update -qq > /dev/null
RUN apt-get install -yqq mongodb-org

RUN mkdir -p /data/db
RUN chown -R mongodb:mongodb /data
RUN echo "bind_ip = 0.0.0.0" >> /etc/mongodb.conf

RUN mkdir /etc/service/mongodb
ADD run /etc/service/mongodb/run
RUN chown root. /etc/service/mongodb/run

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 27017

CMD ["/sbin/my_init"]
