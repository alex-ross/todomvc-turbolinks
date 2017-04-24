FROM ruby:2.4-slim

RUN apt-get update && apt-get install -qq -y \
    build-essential \
    libxml2-dev \
    nodejs \
    libpq-dev \
    --fix-missing --no-install-recommends

ENV APP_PATH /var/www/app
RUN mkdir -p $APP_PATH
WORKDIR $APP_PATH

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

COPY . .

CMD puma -C config/puma.rb
