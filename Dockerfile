FROM ruby:2.7.1-alpine

RUN apk update && apk upgrade

RUN apk add --update \
  build-base \
  libxml2-dev \
  libxslt-dev \
  postgresql-dev \
  nodejs \
  tzdata \
  yarn \
  && rm -rf /var/cache/apk/*

RUN gem install bundler

ENV APP_HOME /cooking
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install --without development:test --path vendor/bundle --binstubs vendor/bundle/bin -j4 --deployment

ADD . $APP_HOME

RUN bundle exec rake RAILS_ENV=production DATABASE_URL=postgresql:does_not_exist assets:precompile

EXPOSE 8080

ENTRYPOINT ["./entrypoint.sh"]
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "8080", "-e", "production"]
