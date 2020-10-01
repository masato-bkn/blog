FROM ruby:2.6.6-alpine

ENV ROOT="/blog_app"
ENV LANG=C.UTF-8
ENV TZ=Asia/Tokyo

WORKDIR ${ROOT}

RUN apk add --no-cache alpine-sdk \
    mariadb-connector-c-dev \
    build-base \
    bash \
    tzdata \
    nodejs \
    yarn

COPY Gemfile* ${ROOT}/

RUN gem install bundler:2.1.4
RUN bundle install

CMD ["rails", "server", "-b", "0.0.0.0"]
