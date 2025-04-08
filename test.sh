#!/bin/bash

# Set default environment and action
ENV="prod"
BUILD=false
DELETE_VOLUMES=false
SHOW_LOGS=false
ENV_FILE=".env"

# Usage function to display help text
usage() {
    echo "Usage: $0 [options]"
    echo "Interactively start, stop, or show logs of your Docker containers."
    echo ""
    echo "Options:"
    echo "  -e, --env        Set the environment (dev or prod). Default is 'prod'."
    echo "  -b, --build      Build the images before starting containers."
    echo "  -s, --start      Start the containers."
    echo "  -t, --stop       Stop the containers."
    echo "  -l, --logs       Show the logs."
    echo "  -v, --volumes    Delete volumes when stopping the containers."
    echo "  --env-file       Specify a custom .env file (default is '.env')."
    echo ""
    echo "Examples:"
    echo "  ./run.sh -e dev -b -s             # Start in dev mode, with build"
    echo "  ./run.sh -e prod -t               # Stop in prod mode"
    echo "  ./run.sh --env-file .env.dev -s   # Start with a custom .env file"
    echo "  ./run.sh -l                       # Show the logs"
    echo "  ./run.sh -e dev -t -v             # Stop dev containers and delete volumes"
    exit 1
}

# Parse command-line arguments
while [[ "$#" -gt 0 ]]; do
    case "$1" in
        -e|--env)
            ENV="$2"
            shift 2
            ;;
        -b|--build)
            BUILD=true
            shift
            ;;
        -s|--start)
            ACTION="start"
            shift
            ;;
        -t|--stop)
            ACTION="stop"
            shift
            ;;
        -l|--logs)
            SHOW_LOGS=true
            shift
            ;;
        -v|--volumes)
            DELETE_VOLUMES=true
            shift
            ;;
        --env-file)
            ENV_FILE="$2"
            shift 2
            ;;
        -h|--help)
            usage
            ;;
        *)
            echo "Unknown option: $1"
            usage
            ;;
    esac
done

# Check if an action is specified
if [ -z "$ACTION" ]; then
    echo "❌ You must specify an action: start, stop, or logs."
    usage
fi

# Set Compose files based on the environment
if [ "$ENV" == "dev" ]; then
    COMPOSE_FILES="-f docker/compose.traefik.yml -f docker/compose.yml -f docker/compose.api-dev.yml"
else
    COMPOSE_FILES="-f docker/compose.traefik.yml -f docker/compose.yml"
fi

# Function to start the project (with or without build)
start_project() {
    if [ "$BUILD" = true ]; then
        CMD="docker compose --env-file $ENV_FILE $COMPOSE_FILES up -d --build"
        echo "🚀 Starting and building Docker containers with: $CMD"
    else
        CMD="docker compose --env-file $ENV_FILE $COMPOSE_FILES up -d"
        echo "🚀 Starting Docker containers with: $CMD"
    fi
    $CMD
    if [ $? -ne 0 ]; then
        echo "❌ Failed to start Docker containers."
        exit 1
    fi
    echo "✅ Docker containers started successfully."
}

# Function to stop the project (with or without volumes deletion)
stop_project() {
    if [ "$DELETE_VOLUMES" = true ]; then
        CMD="docker compose --env-file $ENV_FILE $COMPOSE_FILES down -v"
        echo "❌ Stopping Docker containers and deleting volumes with: $CMD"
    else
        CMD="docker compose --env-file $ENV_FILE $COMPOSE_FILES down"
        echo "❌ Stopping Docker containers with: $CMD"
    fi
    $CMD
    if [ $? -ne 0 ]; then
        echo "❌ Failed to stop Docker containers."
        exit 1
    fi
    echo "✅ Docker containers stopped successfully."
}

# Function to show logs
show_logs() {
    CMD="docker compose --env-file $ENV_FILE $COMPOSE_FILES logs -f"
    echo "📜 Showing Docker logs with: $CMD"
    $CMD
}

# Main logic based on the action specified
case "$ACTION" in
    start)
        start_project
        ;;
    stop)
        stop_project
        ;;
    logs)
        show_logs
        ;;
    *)
        echo "❌ Invalid action: $ACTION"
        exit 1
        ;;
esac
