#!/bin/sh

docker run \
  --rm \
  --name monet \
  -p 50000:50000 \
  -e MONET_DATABASE=docker \
  -e MONETDB_PASSWORD=docker \
  -v monet-data:/var/lib/monetdb \
  topaztechnology/monetdb:11.31.13
