FROM ubuntu:14.04

MAINTAINER kaihui.wang <hpuwang@gmail.com>

RUN echo "deb http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse"> /etc/apt/sources.list
RUN echo "deb http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse"> /etc/apt/sources.list
RUN echo "deb http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse"> /etc/apt/sources.list
RUN echo "deb http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse"> /etc/apt/sources.list
RUN echo "deb http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse"> /etc/apt/sources.list
RUN echo "deb-src http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse"> /etc/apt/sources.list
RUN echo "deb-src http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse"> /etc/apt/sources.list
RUN echo "deb-src http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse"> /etc/apt/sources.list
RUN echo "deb-src http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse"> /etc/apt/sources.list
RUN echo "deb-src http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse"> /etc/apt/sources.list

RUN apt-get update

RUN apt-get -y install \
php7.0 \
php7.0-dev \
php7.0-curl \
php7.0-fpm \
php7.0-gd \
php7.0-apcu \
php7.0-posix \
php7.0-mbstring \
nginx \
mysql-server-5.6 \
redis-server \
wget \

RUN cd /tmp \
&& mkdir d \
&& cd d \
&& wget https://github.com/swoole/swoole-src/archive/v2.0.6.tar.gz \
&& tar zxvf v2.0.6.tar.gz \
&& cd swoole-src-2.0.6 \
&& phpize \
./configure --with-php-config=$(which php-config)  --enable-coroutine \
&& make && make install \
&& echo "extension=swoole.so" > /etc/php/7.0/cli/conf.d/swoole.ini \

RUN apt clean && apt autoclean && rm -rf /tmp/d

EXPOSE 8888

RUN mkdir -p /data/www

WORKDIR /data/www/