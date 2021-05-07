FROM ruby:2.7.3

ENV TZ Asia/Tokyo

RUN apt-get install imagemagick libmagickcore-dev libmagickwand-dev
RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - && apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN curl https://deb.nodesource.com/setup_12.x | bash
RUN curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y nodejs yarn postgresql-client

WORKDIR /ec_site_on_rails

ADD Gemfile /ec_site_on_rails/Gemfile
ADD Gemfile.lock /ec_site_on_rails/Gemfile.lock

RUN gem install bundler
RUN bundle install

CMD ["rails", "server", "-b", "0.0.0.0"]

ADD . /ec_site_on_rails

RUN mkdir -p tmp/sockets
