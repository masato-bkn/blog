FROM ruby:2.6.6

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - &&\
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list &&\
    apt-get update && apt-get install -y nodejs yarn --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN mkdir /blog_app
WORKDIR /blog_app
COPY Gemfile /blog_app/Gemfile
COPY Gemfile.lock /blog_app/Gemfile.lock
RUN gem install bundler:2.1.4
RUN bundle install
COPY . /blog_app
