FROM ruby:2.5-alpine

# install bash
RUN apk add -U bash

# install bundler
RUN gem install bundler

# install rails
RUN apk add libxml2-dev libxslt-dev libstdc++ tzdata mariadb-client-libs nodejs ca-certificates \
            build-base mariadb-dev ruby-dev sqlite sqlite-dev postgresql-dev
RUN gem install rails --no-rdoc --no-ri

# create rails project
RUN rails new app -d postgresql --bundle-skip
WORKDIR /app
RUN bundle install --jobs=4 --path=vendor
RUN sed -i -e "23i \  username: postgres" config/database.yml && \
    sed -i -e "24i \  password: password" config/database.yml && \
    sed -i -e "25i \  host: db" config/database.yml && \
    sed -i -e "26i \  port: 5432" config/database.yml

CMD ["rails", "s", "-b", "0.0.0.0"]
