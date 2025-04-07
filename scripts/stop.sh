#!/bin/bash
# This script is used to start the Docker containers for the application.
# It uses Docker Compose to bring up the containers defined in the compose.yml and compose.traefik.yml files.

docker compose -f compose.traefik.yml -f compose.yml -f compose.api-dev.yml down --remove-orphans
