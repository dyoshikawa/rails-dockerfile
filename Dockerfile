FROM ruby:2.5-alpine

# install bash
RUN apk add -U bash

# install bundler
RUN gem install bundler

# install rails
RUN apk add libxml2-dev libxslt-dev libstdc++ tzdata mariadb-client-libs nodejs ca-certificates \
            build-base mariadb-dev ruby-dev sqlite sqlite-dev postgresql-dev
RUN gem install rails -v 5.2 --no-rdoc --no-ri

# create rails project
RUN rails new app -d postgresql --bundle-skip
WORKDIR /app
RUN bundle install --jobs=4 --path=vendor

CMD ["rails", "s", "-b", "0.0.0.0"]
