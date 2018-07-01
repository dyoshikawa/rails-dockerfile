FROM ruby:2.5
MAINTAINER dyoshikawa

RUN apt update -y
RUN apt install git
RUN apt install -y libxml2 \
                   libxml2-dev \
                   libssl-dev \
                   libreadline-dev \
                   zlib1g-dev \
                   ruby-railties \
                   nodejs \
                   gcc \
                   make \
                   zlib1g-dev \
                   sqlite3 \
                   default-libmysqlclient-dev
RUN gem update bundler
RUN gem install rails -v 5.2
RUN gem install rubocop
RUN rails new /myproject
WORKDIR /myproject

CMD rails s -b 0
