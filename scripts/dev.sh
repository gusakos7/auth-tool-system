#!/bin/bash

display_options() {
    echo "Choose: "
    echo "1) make"
    echo "2) kill"
    echo "3) logs"
    echo "4) delete volumes"
    echo "5) initialize"
}

handle_choice() {
    case $1 in
        1)
            docker compose -f compose.dev.yml up --build --remove-orphans -d
        ;;
        2)
            docker compose -f compose.dev.yml down
        ;;
        3)
            docker compose -f compose.dev.yml --profile setup logs -f
        ;;
        4)
            docker compose -f compose.dev.yml --profile setup down -v 
        ;;
        5)
            docker compose -f compose.dev.yml --profile setup  up --build --remove-orphans -d
        ;;
        *)
            echo "Invalid choice, please select 1, 2, 3 or 4"
            exit 1
        ;;
    esac
}

display_options

read -p "Enter your choice [1, 2, 3 or 4]: " option

handle_choice $option
