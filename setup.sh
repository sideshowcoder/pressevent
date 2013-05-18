#!/bin/bash
set -e

if [ ! -f .env ]; then
  cp env.sample .env
fi

if [ ! -f ./config/database.yml ]; then
  cp ./config/database.yml.sample ./config/database.yml
fi

bundle install

createuser --superuser --host=localhost pressevent

rake db:create
rake db:schema:load
rake db:seed
rake db:test:prepare
