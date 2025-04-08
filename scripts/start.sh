#!/bin/bash

# "$0" → Refers to the script itself.
# realpath "$0" → Gets the absolute path of the script.
# dirname → Extracts the directory from that path.
SCRIPTS_DIR="$(dirname "$(realpath "$0")")"

# Ensure the scripts directory exists
if [ ! -d "$SCRIPTS_DIR" ]; then
  echo "❌ Directory '$SCRIPTS_DIR' does not exist."
  exit 1
fi

# Parse the command-line argument for environment mode (dev or prod)
if [ "$1" == "dev" ]; then
    COMPOSE_FILES="-f compose.traefik.yml -f compose.yml -f compose.api-dev.yml"
elif [ "$1" == "prod" ]; then
    COMPOSE_FILES="-f compose.traefik.yml -f compose.yml"
else
    echo "❌ Invalid environment specified. Usage: ./start.sh {dev|prod} [--build]"
    exit 1
fi

# Check if 'docker compose' command exists
if command -v docker compose &> /dev/null; then
    DOCKER_CMD="docker compose"
elif command -v compose &> /dev/null; then
    DOCKER_CMD="compose"
else
    echo "❌ Docker Compose is not installed. Please install it to proceed."    
    exit 1
fi

# Check if '--build' argument is passed
# $@ is a special variable in bash that contains all the arguments passed to the script
# " $@ ": This is the string representation of all the script arguments, with spaces before and after ($@), to ensure that matching works even if there are multiple arguments.
# =~: This is a regular expression matching operator in bash. It checks if the string on the left (in this case, "$@" containing the arguments) matches the pattern on the right (in this case, " --build ").
if [[ " $@ " =~ " --build " ]]; then
    CMD="$DOCKER_CMD $COMPOSE_FILES up -d --build"
    echo "🚀 Starting and building Docker containers with command: $CMD"
else
    CMD="$DOCKER_CMD $COMPOSE_FILES up -d"
    echo "🚀 Starting Docker containers with command: $CMD"
fi

$CMD

# Check if the command was successful
if [ $? -ne 0 ]; then
    echo "❌ Failed to start Docker containers."
    exit 1
fi

echo "✅ Docker containers started successfully."
