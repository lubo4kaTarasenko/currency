FROM ruby:2.7.0

WORKDIR /app 
ADD Gemfile /app
ADD Gemfile.lock /app
RUN bundle install -j4
COPY . .