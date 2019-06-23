FROM ruby:2.6-alpine

RUN apk add --update build-base tzdata sqlite-dev
RUN gem install rails -v '5.2.3'

WORKDIR /app
ADD Gemfile* /app/
RUN bundle install

ADD . .
CMD ["bundle", "exec", "puma"]
