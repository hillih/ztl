FROM ruby:2.3

RUN echo 'deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main' 9.5 > /etc/apt/sources.list.d/pgdg.list; \
   wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

RUN apt-get update && apt-get install -y \
    build-essential locales \
    # for postgres
    libpq-dev postgresql-client \
    # for a JS runtime
    nodejs-legacy npm \
&& rm -rf /var/lib/apt/lists/*

RUN localedef -i pl_PL -c -f UTF-8 -A /usr/share/locale/locale.alias pl_PL.UTF-8
ENV LANG pl_PL.utf8

ENV APP_HOME /usr/src/app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile* $APP_HOME/

ARG APP_ENV=development

RUN /bin/bash -c "gem install bundler && \
    if [ \"$APP_ENV\" = \"development\" ]; \
    then bundle install --jobs 20 --retry 5; \
    else bundle install --jobs 20 --retry 5 --without development test; \
    fi"
