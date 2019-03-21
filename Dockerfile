FROM ruby:2-alpine

RUN apk add --no-cache --virtual build-dependencies build-base && \
    gem install bundler --no-document

WORKDIR /app

COPY Gemfile /app/
COPY Gemfile.lock /app/

RUN bundle install && \
    apk del build-dependencies build-base && \
    rm -r ~/.bundle/ /usr/local/bundle/cache

ENV EXPOSED_SERVICE_PORT=8077
EXPOSE ${EXPOSED_SERVICE_PORT}

ENV consumer=Foo
ENV provider=Bar

VOLUME /app/pacts

CMD bundle exec pact-mock-service --host 0.0.0.0 --port ${EXPOSED_SERVICE_PORT} --pact-dir ./pacts --consumer ${consumer} --provider ${provider}
