# docker build -t railgun .

FROM ubuntu:latest

ARG ruby=2.5.0
ARG postgresql=9.6
ARG chromedriver=2.35

# TimeZone
ENV TZ 'Europe/Moscow'
RUN echo $TZ > /etc/timezone && \
apt-get update && apt-get install -y tzdata && \
rm /etc/localtime && \
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
dpkg-reconfigure -f noninteractive tzdata && \
apt-get clean

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

# Install Ruby
RUN git clone git://github.com/rbenv/rbenv.git /usr/local/rbenv \
    &&  git clone git://github.com/rbenv/ruby-build.git /usr/local/rbenv/plugins/ruby-build \
    &&  git clone git://github.com/jf/rbenv-gemset.git /usr/local/rbenv/plugins/rbenv-gemset \
    &&  /usr/local/rbenv/plugins/ruby-build/install.sh
ENV PATH /usr/local/rbenv/bin:$PATH
ENV RBENV_ROOT /usr/local/rbenv

RUN echo 'export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile.d/rbenv.sh \
    &&  echo 'export PATH=/usr/local/rbenv/bin:$PATH' >> /etc/profile.d/rbenv.sh \
    &&  echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh

RUN echo 'export RBENV_ROOT=/usr/local/rbenv' >> /root/.bashrc \
    &&  echo 'export PATH=/usr/local/rbenv/bin:$PATH' >> /root/.bashrc \
    &&  echo 'eval "$(rbenv init -)"' >> /root/.bashrc

ENV CONFIGURE_OPTS --disable-install-doc
ENV PATH /usr/local/rbenv/bin:/usr/local/rbenv/shims:$PATH

RUN eval "$(rbenv init -)"; rbenv install $ruby \
    &&  eval "$(rbenv init -)"; rbenv global $ruby \
    &&  eval "$(rbenv init -)"; gem install bundler

# Install Google Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
    && sudo apt-get update -qqy \
    && sudo apt-get -qqy install \
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
RUN dpkg-divert --add --rename --divert /opt/google/chrome/google-chrome.real /opt/google/chrome/google-chrome && \
    echo "#!/bin/bash\nexec /opt/google/chrome/google-chrome.real --disable-setuid-sandbox \"\$@\"" > /opt/google/chrome/google-chrome && \
    chmod 755 /opt/google/chrome/google-chrome

# install PostgreSQL
RUN sudo sh -c "echo 'deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
RUN wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
RUN sudo apt-get update
RUN sudo apt-get install postgresql-common -y
RUN sudo apt-get install postgresql-$postgresql libpq-dev -y
USER postgres
RUN    /etc/init.d/postgresql start &&\
    psql --command "CREATE USER root WITH SUPERUSER PASSWORD 'root';"

USER root

ENV DISPLAY=:99.0
RUN printf '#!/bin/sh\nXvfb :99 -screen 0 1280x1024x24 &\nexec "$@"\n' > /tmp/entrypoint \
    && chmod +x /tmp/entrypoint \
    && sudo mv /tmp/entrypoint /docker-entrypoint.sh

# install railgun
RUN git clone https://github.com/zharikovpro/railgun.git
WORKDIR /railgun

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD service postgresql start && \
    /bin/bash
