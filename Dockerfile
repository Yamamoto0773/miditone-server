# source image
FROM ruby:2.6.4

# install packages
RUN apt-get update -qq && \
	apt-get install -y build-essential libpq-dev nodejs

# create app directory
RUN mkdir /miditone-server
ENV APP_ROOT /miditone-server
WORKDIR $APP_ROOT

# install gems
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

ADD . ${APP_ROOT}
