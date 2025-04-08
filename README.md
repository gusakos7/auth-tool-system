# Express-Auth

This project uses Docker to manage and run a set of containers for both development and production environments. The repository provides an easy-to-use script system to manage Docker containers, including starting, stopping, building images, deleting volumes, and viewing logs.

## Prerequisites

Before running the project, make sure you have the following installed:

- Linux
- Docker
- Docker Compose
- Bash: The scripts are written in Bash, so you'll need a Bash environment (typically available on Linux and macOS, or via Git Bash on Windows).

## Project Structure

```bash
/
├── run.sh             # Main script for interacting with the project
└── scripts/
    ├── start.sh       # Starts the containers (with an option to build)
    ├── stop.sh        # Stops the containers (with an option to delete volumes)
    ├── logs.sh        # Views the logs of the containers
    └── compose.*.yml  # Docker Compose files for different environments (e.g., dev and prod)
```

## Available Actions

You can use the `run.sh` script to interact with the Docker containers. The available actions are:

1. **Start Docker containers**: Start containers in either development or production mode.
2. **Stop Docker containers**: Stop containers and optionally delete volumes.
3. **View Docker container logs**: View logs from the containers with options to follow the logs or specify the number of lines to show.
4. **Exit**: Exit the script.

## Running the Project

### 1. Start the Docker Containers

To start the containers, run:

```bash
./run.sh
```

The script will prompt you to choose between **development (d)** or **production (p)** mode. It will also ask if you want to build the images or just start the containers without rebuilding them.

- **Dev Mode**: Choose `d` or `dev` for development mode.
- **Prod Mode**: Choose `p` or `prod` for production mode.
- **Build Option**: Choose `y` or `yes` to build the images before starting the containers, or `n` or `no` to skip the build.

### 2. Stop the Docker Containers

To stop the containers, run:

```bash
./run.sh
```

The script will prompt you to choose between **development (d)** or **production (p)** mode. It will also ask if you want to delete volumes during the stop process.

- Dev Mode: Choose `d` or `dev` for development mode.
- Prod Mode: Choose `p` or `prod` for production mode.
- Delete Volumes: Choose `y` or `yes` to delete volumes when stopping the containers, or `n` or `no` to keep them.

### 3. View Docker Container Logs

To view the logs from the containers, run:

```bash
./run.sh
```

The script will prompt you to choose between **development (d)** or **production (p)** mode. It will then ask if you want to follow the logs (show logs in real-time) or specify the number of lines to display.

- Dev Mode: Choose `d` or `dev` for development mode.
- Prod Mode: Choose `p` or `prod` for production mode.
- Follow Logs: Choose `y` or `yes` to follow the logs, or `n` or `no` to show a specific number of lines.
- Specify Lines: If you choose not to follow logs, you will be prompted to specify the number of lines to display (defaults to 50).

### 4. Exit the Script

If you are done, you can exit the script by choosing option 4 from the menu.

## How the Scripts Work

The project uses the following scripts to manage Docker containers:

- start.sh: This script is used to start the Docker containers. It accepts the environment (`dev` or `prod`) and an optional `--build` argument to rebuild the images before starting the containers.

  Example:

  ```bash
  ./scripts/start.sh dev --build
  ```

- stop.sh: This script stops the Docker containers. It also accepts an optional `--volumes` argument to delete volumes when stopping the containers.

  Example:

  ```bash
  ./scripts/stop.sh prod --volumes
  ```

- logs.sh: This script displays the logs from the Docker containers. You can specify whether to follow the logs (`-f` flag) or specify the number of lines to display.
  Example:

  ```bash
  ./scripts/logs.sh dev -f
  ```

## Environment Configuration

The project uses multiple Docker Compose files to manage different environments. The `compose.dev.yml` file is used for the development environment, while the `compose.prod.yml` file is used for production.

The main compose.yml file contains the common configuration shared between the two environments.

### Adding New Compose Files

You can add additional `compose.<env>.yml` files for other environments (e.g., `staging`, `t`es`t`ing) and then modify the scripts accordingly if needed.

## Troubleshooting

- If you encounter an error stating that `docker compose` is not found, make sure you have Docker Compose installed and that it's available in your `PATH`. For Docker Compose v2, you can use `docker compose` instead of `docker-compose`.
- If the containers fail to start, check the logs for more details about what went wrong. Use the `logs.sh` script to view container logs for troubleshooting.

## Contributing

Feel free to fork the repository and submit pull requests. Ensure to follow the contribution guidelines and best practices for Docker and Bash scripting.

### Additional Notes

This `README.md` provides an overview of how to set up and manage the project using the scripts. The script system is flexible, allowing you to easily extend and customize it based on your specific needs.
