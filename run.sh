#!/bin/bash

# "$0" → Refers to the script itself.
# realpath "$0" → Gets the absolute path of the script.
# dirname → Extracts the directory from that path.
ROOT_DIR="$(dirname "$(realpath "$0")")"  # Assuming the scripts are inside a 'scripts' folder
SCRIPTS_DIR="$ROOT_DIR/scripts"
ENV_FILE="$ROOT_DIR/.env"
echo "ROOT_DIR: $ROOT_DIR"
# Ensure the scripts directory exists
if [ ! -d "$SCRIPTS_DIR" ]; then
    echo "❌ Directory '$SCRIPTS_DIR' does not exist."
    exit 1
fi

# List available actions
echo "Choose an action to execute:"
echo "1) Start Docker containers"
echo "2) Stop Docker containers (with optional volume deletion)"
echo "3) View Docker container logs"
echo "4) Exit"

# Read the user choice
read -p "Enter the number of your choice: " choice

# Handle the user input
case $choice in
    1)
        # Start Docker containers (ask for dev/prod mode and build option)
        echo "Do you want to run in dev (d) or prod (p) mode?"
        read -p "Enter mode (d/p): " mode
        
        echo "Do you want to build the images? (y/n)"
        read -p "Enter your choice: " build_choice
        
        # Normalize inputs to full words
        if [[ "$mode" == "d" || "$mode" == "dev" ]]; then
            mode="dev"
        elif [[ "$mode" == "p" || "$mode" == "prod" ]]; then
            mode="prod"
        else
            echo "❌ Invalid mode! Please enter 'd' (dev) or 'p' (prod)."
            exit 1
        fi
        
        if [[ "$build_choice" == "y" || "$build_choice" == "yes" ]]; then
            ./scripts/start.sh "$mode" --build
        elif [[ "$build_choice" == "n" || "$build_choice" == "no" ]]; then
            ./scripts/start.sh "$mode"
        else
            echo "❌ Invalid choice for build option. Please enter 'y' or 'n'."
            exit 1
        fi
        ;;
    2)
        # Stop Docker containers (ask for dev/prod mode and volume deletion)
        echo "Do you want to stop containers in dev (d) or prod (p) mode?"
        read -p "Enter mode (d/p): " mode
        
        echo "Do you want to delete volumes? (y/n)"
        read -p "Enter your choice: " delete_volumes
        
        # Normalize inputs to full words
        if [[ "$mode" == "d" || "$mode" == "dev" ]]; then
            mode="dev"
        elif [[ "$mode" == "p" || "$mode" == "prod" ]]; then
            mode="prod"
        else
            echo "❌ Invalid mode! Please enter 'd' (dev) or 'p' (prod)."
            exit 1
        fi
        
        if [[ "$delete_volumes" == "y" || "$delete_volumes" == "yes" ]]; then
            ./scripts/stop.sh "$mode" --volumes
        elif [[ "$delete_volumes" == "n" || "$delete_volumes" == "no" ]]; then
            ./scripts/stop.sh "$mode"
        else
            echo "❌ Invalid choice for volume deletion. Please enter 'y' or 'n'."
            exit 1
        fi
        ;;
    3)
        # View Docker container logs (ask for dev/prod mode and options for -f flag or number of lines)
        echo "Do you want to view logs for dev (d) or prod (p) mode?"
        read -p "Enter mode (d/p): " mode
        
        echo "Do you want to follow the logs? (y/n)"
        read -p "Enter your choice: " follow_logs
        
        echo "Do you want to specify the number of lines to display?"
        read -p "Enter the number of lines (default is 50): " num_lines
        
        # Default number of lines is 50 if the user does not specify
        if [[ -z "$num_lines" ]]; then
            num_lines=50
        fi
        
        # Normalize inputs to full words
        if [[ "$mode" == "d" || "$mode" == "dev" ]]; then
            mode="dev"
        elif [[ "$mode" == "p" || "$mode" == "prod" ]]; then
            mode="prod"
        else
            echo "❌ Invalid mode! Please enter 'd' (dev) or 'p' (prod)."
            exit 1
        fi
        
        if [[ "$follow_logs" == "y" || "$follow_logs" == "yes" ]]; then
            ./scripts/logs.sh "$mode" -f
        elif [[ "$follow_logs" == "n" || "$follow_logs" == "no" ]]; then
            ./scripts/logs.sh "$mode" --tail "$num_lines"
        else
            echo "❌ Invalid choice for follow logs option. Please enter 'y' or 'n'."
            exit 1
        fi
        ;;
    4)
        # Exit
        echo "Exiting..."
        exit 0
        ;;
    *)
        # Invalid option
        echo "❌ Invalid choice! Please enter a number between 1 and 4."
        exit 1
        ;;
esac
