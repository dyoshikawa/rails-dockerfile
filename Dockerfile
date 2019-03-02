FROM ruby:2.5-alpine
MAINTAINER dyoshikawa

RUN apk upgrade --no-cache
RUN apk add --update --no-cache git bash
RUN apk add --no-cache \
    postgresql-client \
    nodejs \
    tzdata && \
    apk add --update --no-cache --virtual=build-dependencies \
    build-base \
    curl-dev \
    linux-headers \
    libxml2-dev \
    libxslt-dev \
    postgresql-dev \
    mysql-dev \
    ruby-dev \
    yaml-dev \
    zlib-dev
RUN gem install bundler
RUN gem install rails -v 5.0.6

RUN apk add shadow sudo
RUN groupadd -g 1000 dyoshikawa
RUN useradd -u 1000 -g 1000 dyoshikawa
RUN adduser dyoshikawa wheel \
    && sed -e 's;^# \(%wheel.*NOPASSWD.*\);\1;g' -i /etc/sudoers
RUN mkdir /home/dyoshikawa && chown 1000:1000 -R /home/dyoshikawa
RUN mkdir /work && chown 1000:1000 -R /work
WORKDIR /work
USER dyoshikawa

ENTRYPOINT []
CMD ['bash']
