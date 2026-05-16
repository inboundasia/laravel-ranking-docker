# Purpose

Laravel Environment for Ranking

## Build

Build and publish multi-platform images:

docker buildx build . \
    --platform linux/amd64,linux/arm64 \
    -t inboundasia/laravel-ranking:8.4 \
    -t inboundasia/laravel-ranking:latest \
    --push

## Publish

The build command publishes both `8.4` and `latest` multi-platform images.
Run it on a native amd64 host or CI runner when possible, because building
`linux/amd64` from Apple Silicon requires emulation and can be very slow.

GitHub Actions can also publish the multi-platform images. Run the `Docker`
workflow manually, or push changes to `master` that touch `Dockerfile`,
`add-ssh-private-key`, or `.github/workflows/docker.yml`.

Verify the published platforms:

docker buildx imagetools inspect inboundasia/laravel-ranking:8.4

## Run with Bash

docker run -it inboundasia/laravel-ranking /bin/bash