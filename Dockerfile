FROM almalinux:minimal

RUN mkdir /app

# Rails app lives here
WORKDIR /app
ENv NODE_OPTIONS --openssl-legacy-provider
# Set production environmen

# Install packages needed to build gems
RUN microdnf -y install ruby ruby-devel make gcc gcc-c++ nodejs
#RUN microdnf module enable nodejs:20
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
RUN chown -R application_user:application_user /usr/share/gems/
RUN chown -R application_user:application_user /usr/bin/
RUN chown -R application_user:application_user /usr/lib64/gems/ruby/
RUN chmod +w /usr/bin/
RUN chmod +w /usr/share/gems/
RUN chmod +w /usr/lib64/gems/ruby/
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
