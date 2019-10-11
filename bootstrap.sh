#!/usr/bin/env bash

echo 'Copying config files...'
cp config/database.yml.template config/database.yml
cp config/application.yml.template config/application.yml

echo 'Build application...'
docker-compose pull rails

echo 'Provisioning database...'
docker-compose run rails bundle exec rails db:setup
