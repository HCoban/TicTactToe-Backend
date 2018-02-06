FROM ruby:2.4-alpine

RUN apk update && apk add build-base nodejs postgresql-dev tzdata

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install --binstubs

COPY . .

# RUN rails db:create
# RUN rails db:migrate
# CMD rails s
