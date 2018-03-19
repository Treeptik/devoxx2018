#!/bin/bash

PUBLIC_IP=`/sbin/ifconfig eth0 | grep "inet ad" | cut -f2 -d: | awk '{print $1}'`
echo "IP PUBLIC : " $PUBLIC_IP

# Configure environment
cp -f .env.template .env
PATTERN="s/#IP#/$PUBLIC_IP/"
sed -i $PATTERN .env

cp -f traefik.toml.template traefik.toml
PATTERN="s/#IP#/$PUBLIC_IP/"
sed -i $PATTERN traefik.toml

# Start Docker Stack
docker network create skynet
docker-compose up -d
