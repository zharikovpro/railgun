# docker build -t railgun .

FROM ubuntu:latest

LABEL maintainer='alexei.mifrill.strizhak@gmail.com'

ARG ruby=2.5.0
ARG postgresql=9.6
ARG chromedriver=2.35

# TimeZone
ENV TZ 'Europe/Moscow'
RUN echo $TZ > /etc/timezone \
    && apt-get update && apt-get install -y tzdata \
    && rm /etc/localtime \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata \
    && apt-get clean

# install Dependencies
RUN apt-get update && apt-get install -y sudo --no-install-recommends apt-utils && rm -rf /var/lib/apt/lists/*
RUN sed 's/main$/main universe/' -i /etc/apt/sources.list
RUN apt-get update -qq && apt-get install -qqy \
    lsb-release \
    nano \
    git-core  \
    git \
    curl  \
    zlib1g-dev  \
    build-essential \
    libssl-dev \
    libreadline-dev \
    libyaml-dev \
    libxml2-dev \
    libxslt1-dev \
    libcurl4-openssl-dev \
    libffi-dev \
    unzip \
    openjdk-8-jre-headless \
    xvfb \
    libxi6 \
    libgconf-2-4 \
    wget

# Install NodeJS
RUN  curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
RUN  sudo apt-get install -y nodejs

# Install ruby
RUN git clone https://github.com/rbenv/rbenv.git /root/.rbenv
RUN git clone https://github.com/rbenv/ruby-build.git /root/.rbenv/plugins/ruby-build
ENV PATH /root/.rbenv/bin:$PATH
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh # or /etc/profile
RUN echo 'eval "$(rbenv init -)"' >> /root/.bashrc
ENV CONFIGURE_OPTS --disable-install-doc
RUN rbenv install $ruby
RUN rbenv global $ruby
RUN rbenv rehash
RUN echo "gem: --no-ri --no-rdoc" > /root/.gemrc && chmod 644 /root/.gemrc
RUN rbenv exec gem install bundler --conservative
RUN rbenv exec bundle config git.allow_insecure true

# Install Google Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update -qqy \
    && apt-get -qqy install \
    google-chrome-stable \
    && rm /etc/apt/sources.list.d/google-chrome.list \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
    && google-chrome --version

# Install Chrome WebDriver
RUN wget --no-check-certificate https://chromedriver.storage.googleapis.com/$chromedriver/chromedriver_linux64.zip \
    && unzip chromedriver_linux64.zip \
    && rm chromedriver_linux64.zip \
    && mv -f chromedriver /usr/local/share/ \
    && chmod +x /usr/local/share/chromedriver \
    && ln -s /usr/local/share/chromedriver /usr/local/bin/chromedriver \
    && chromedriver -v

# Disable the SUID sandbox so that Chrome can launch without being in a privileged container.
# One unfortunate side effect is that `google-chrome --help` will no longer work.
RUN dpkg-divert --add --rename --divert /opt/google/chrome/google-chrome.real /opt/google/chrome/google-chrome \
    && echo "#!/bin/bash\nexec /opt/google/chrome/google-chrome.real --headless --no-sandbox --disable-gpu --disable-setuid-sandbox \"\$@\"" > /opt/google/chrome/google-chrome \
    && chmod 755 /opt/google/chrome/google-chrome

# install PostgreSQL
RUN sudo sh -c "echo 'deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
RUN wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
RUN sudo apt-get update
RUN sudo apt-get install postgresql-common -y
RUN sudo apt-get install postgresql-$postgresql libpq-dev -y
USER postgres
RUN /etc/init.d/postgresql start \
    && psql --command "CREATE USER root WITH SUPERUSER PASSWORD 'root';"

USER root
RUN git clone https://github.com/zharikovpro/railgun.git /root/railgun
WORKDIR /root/railgun
RUN rbenv exec bundle install \
    && /etc/init.d/postgresql start \
    && rbenv exec bundle exec rails db:create \
    && rbenv exec bundle exec rails db:structure:load \
    && rbenv exec bundle exec rails db:seed

CMD service postgresql start \
    && /bin/bash
