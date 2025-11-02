# Purpose

Laravel Environment for Ranking

## Build

docker build . -t inboundasia/laravel-ranking

## Publish

docker tag inboundasia/laravel-ranking:latest inboundasia/laravel-ranking:8.3

docker push inboundasia/laravel-ranking:8.3
docker push inboundasia/laravel-ranking

## Run with Bash

docker run -it inboundasia/laravel-ranking /bin/bash