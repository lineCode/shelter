#!/bin/sh

if [ "$1" = "backend" ]
then
  sleep 5
  bundle install
  exec bundle exec sidekiq
else
  sleep 3
  bundle install

  bundle exec rake db:create db:migrate db:seed

  if [ "$RAILS_ENV" = "production" ]; then
    bundle exec rake assets:precompile
  fi

  exec rails s -p 3000 -b 0.0.0.0
fi
