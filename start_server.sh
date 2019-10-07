#!/usr/bin/env bash

docker-compose down
[ -e tmp/pids/server.pid ] && rm tmp/pids/server.pid
rm -fr public/packs/*
docker-compose up rails sidekiq webpacker
