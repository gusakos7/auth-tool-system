#!/bin/bash

# "$0" → Refers to the script itself.
# realpath "$0" → Gets the absolute path of the script.
# dirname → Extracts the directory from that path.
SCRIPTS_DIR="$(dirname "$(realpath "$0")")"
DOCKER_DIR="$SCRIPTS_DIR/../docker"
ROOT_DIR="$(dirname "$SCRIPTS_DIR")"
ENV_FILE="$ROOT_DIR/.env"

# Ensure the scripts directory exists
if [ ! -d "$SCRIPTS_DIR" ]; then
  echo "❌ Directory '$SCRIPTS_DIR' does not exist."
  exit 1
fi

# Parse the command-line argument for environment mode (dev or prod)
if [ "$1" == "dev" ]; then
    COMPOSE_FILES="-f $DOCKER_DIR/compose.traefik.yml -f $DOCKER_DIR/compose.yml -f $DOCKER_DIR/compose.api-dev.yml"
elif [ "$1" == "prod" ]; then
    COMPOSE_FILES="-f $DOCKER_DIR/compose.traefik.yml -f $DOCKER_DIR/compose.yml"
else
    echo "❌ Invalid environment specified. Usage: ./logs.sh {dev|prod} [--lines N]"
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

# Default logs command
CMD="$DOCKER_CMD --env-file $ENV_FILE $COMPOSE_FILES logs"

# If '--lines N' is passed, fetch the last N lines of logs
LINES=0
for arg in "$@"; do
  if [[ "$arg" == "--lines" ]]; then
    LINES=$(($LINES+1))
    continue
  fi
  if [[ $LINES -gt 0 ]]; then
    CMD="$CMD --tail=$LINES"
    break
  fi
done

echo "🚀 Running command: $CMD"

$CMD

# Check if the command was successful
if [ $? -ne 0 ]; then
    echo "❌ Failed to fetch Docker container logs."
    exit 1
fi

echo "✅ Successfully fetching Docker container logs."
