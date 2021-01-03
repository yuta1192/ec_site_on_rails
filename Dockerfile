FROM ruby:2.5.1

RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

WORKDIR /ec_site_on_rails

ADD Gemfile /ec_site_on_rails/Gemfile
ADD Gemfile.lock /ec_site_on_rails/Gemfile.lock

RUN gem install bundler
RUN bundle install

ADD . /ec_site_on_rails