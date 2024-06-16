FROM almalinux:minimal

RUN mkdir /app
RUN mkdir /tmp_build

# Rails app lives here
WORKDIR /tmp_build
ENV NODE_OPTIONS --openssl-legacy-provider
# Set production environmen

# Install packages needed to build gems
RUN microdnf -y install tar make gcc gcc-c++ zlib-devel openssl-devel readline-devel libffi-devel nodejs
#RUN microdnf module enable nodejs:20

RUN curl -O https://cache.ruby-lang.org/pub/ruby/3.1/ruby-3.1.6.tar.gz

RUN tar zxvf ruby-3.1.6.tar.gz

RUN cd /tmp_build/ruby-3.1.6 && ./configure && make && make install

WORKDIR /app

RUN rm -rf /tmp_build
RUN gem install bundler
RUN npm install --global yarn
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

ARG USERNAME=application_user
ARG GROUPNAME=application_user
ARG UID=1357
ARG GID=1357
RUN groupadd -g $GID $GROUPNAME && \
    useradd -m -s /bin/bash -u $UID -g $GID $USERNAME
COPY . /app
RUN chown -R application_user:application_user /app/
RUN chown -R application_user:application_user /usr/local/lib
RUN chown -R application_user:application_user /usr/local/bin/
RUN chmod +w /usr/local/bin/
RUN chmod +w /usr/local/lib
RUN chmod +w /app/

USER $USERNAME

RUN bundle install --path vendor/bundle
RUN npx update-browserslist-db@latest
RUN bundle exec rails db:migrate
#RUN npm install --global yarn
#RUN bundle exec rails webpacker:install
#RUN bundle exec rails webpacker:compile
RUN bundle exec rails assets:precompile
CMD ["bundle","exec","rails", "server", "-b", "0.0.0.0"]
