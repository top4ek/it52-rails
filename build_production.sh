#!/usr/bin/env bash
export VCS_REF=$(git rev-parse --short HEAD)
export BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
export VERSION="production"

docker-compose -f docker-compose.production.yml pull rails
docker-compose -f docker-compose.production.yml build rails
docker-compose -f docker-compose.production.yml push rails
