#!/usr/bin/env bash

export VCS_REF=$(git rev-parse --short HEAD)
export BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
export VERSION="production"

cp config/database.yml.template config/database.yml
cp config/application.yml.template config/application.yml

docker-compose -f docker-compose.production.yml pull rails
docker-compose -f docker-compose.production.yml build rails
docker-compose -f docker-compose.production.yml push rails
