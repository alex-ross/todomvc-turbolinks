FROM ruby:2.4-slim

RUN apt-get update && apt-get install -qq -y \
    # Ensure we can build gems with C extensions
    build-essential \
    # Add build dependencies for nokogiri
    libxml2-dev \
    # NodeJS is needed to compile Rails assets
    nodejs \
    # pg gems needs some libraries as well
    libpq-dev \
    # And don't install more than what we need, but fix missing packages
    --fix-missing --no-install-recommends

# Set application path
ENV APP_PATH /var/www/app
RUN mkdir -p $APP_PATH
WORKDIR $APP_PATH

# Install gems
# Ensure they are only reinstalled when gemfiles changes
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

# Copy the rest of the application
COPY . .

RUN rake RAILS_ENV=production \
    DATABASE_URL=postgresql://user:pass@db/name \
    SECRET_TOKEN=foo \
    assets:precompile

# Run the puma server as a default
CMD puma -C config/puma.rb

