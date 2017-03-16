FROM ubuntu:14.04

MAINTAINER kaihui.wang <hpuwang@gmail.com>

RUN echo "deb http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse"> /etc/apt/sources.list
RUN echo "deb http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse">> /etc/apt/sources.list
RUN echo "deb http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse">> /etc/apt/sources.list
RUN echo "deb http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse">> /etc/apt/sources.list
RUN echo "deb http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse">> /etc/apt/sources.list
RUN echo "deb-src http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse">> /etc/apt/sources.list
RUN echo "deb-src http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse">> /etc/apt/sources.list
RUN echo "deb-src http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse">> /etc/apt/sources.list
RUN echo "deb-src http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse">> /etc/apt/sources.list
RUN echo "deb-src http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse">> /etc/apt/sources.list

RUN apt-get update
RUN apt-get --yes --force-yes install python-software-properties software-properties-common
RUN add-apt-repository -y ppa:ondrej/php
RUN apt-get update

RUN apt-get --yes --force-yes install \
php7.1 \
php7.1-dev \
php7.1-curl \
php7.1-fpm \
php7.1-gd \
php7.1-apcu \
php7.1-posix \
php7.1-mbstring \
nginx \
mysql-server \
mysql-client \
redis-server \
wget \
curl


RUN service mysql start
RUN service nginx start
RUN service redis-server start

RUN cd /tmp \
&& mkdir d \
&& cd d \
&& curl -sS https://getcomposer.org/installer | php
&& mv composer.phar /usr/local/bin/composer
&& wget https://github.com/swoole/swoole-src/archive/v2.0.6.tar.gz \
&& tar zxvf v2.0.6.tar.gz \
&& cd swoole-src-2.0.6 \
&& phpize \
&& ./configure --with-php-config=$(which php-config)  --enable-coroutine \
&& make \
&& make install \
&& echo "extension=swoole.so" > /etc/php/7.1/cli/conf.d/swoole.ini

RUN rm -rf /tmp/d

EXPOSE 8888

RUN mkdir -p /data/www

WORKDIR /data/www


ENTRYPOINT php /data/www/trensy server:restart