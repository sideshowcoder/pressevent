#!/bin/bash
set -e

echo 'setting up env file...'
cp env.sample .env

echo 'install installing dependecies...'
bundle install

echo 'setting up database...'
createuser --superuser --host=localhost postgres
rake db:create
rake db:schema:load
rake db:seed
rake db:test:prepare

echo 'self test...'
rake minitest:all

echo 'setting up heroku remotes...'
heroku git:remote -a pressevent --remote production
heroku git:remote -a pressevent-staging --remote staging




