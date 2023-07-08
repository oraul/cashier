FROM ruby:3.2.2-alpine3.18

ENV APP_PATH=/usr/src/app

RUN apk update && \
    apk add -f bash \
               build-base

WORKDIR ${APP_PATH}

COPY Gemfile Gemfile.lock ${APP_PATH}

RUN bundle install

COPY . ${APP_PATH}

CMD ["bin/console"]
