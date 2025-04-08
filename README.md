# Express-Auth

This project uses Docker Compose to manage and run multiple services, with configurations for both development and production environments. The `test.sh` script allows you to easily start, stop, and view logs for the Docker containers, with flexibility to customize the environment and behavior through command-line options.

## Prerequisites

Before running the project, make sure you have the following installed:

- Linux
- Docker
- Docker Compose
- Bash: The scripts are written in Bash, so you'll need a Bash environment (typically available on Linux and macOS, or via Git Bash on Windows).

## Project Structure

```bash
.
├── certs/
├── conf/
├── docker/
├── scripts/
├── .env
└── run.sh
```

- `docker/`: Contains the Docker Compose configuration files for different environments.
  - `compose.traefik.yml`: Configuration for Traefik reverse proxy.
  - `compose.yml`: The main Compose configuration for your application.
  - `compose.api-dev.yml`: Additional configuration for development mode (API services, etc.).
    `.env`: The environment file containing configuration variables for the containers.
    `run.sh`: The script used to manage Docker containers (start, stop, logs) and configure them based on the environment.
    `scripts/`: A folder that might contain additional utility scripts.

<br>

## How to use `run.sh`

The `run.sh` script is a simple command-line interface to manage your Docker containers. You can perform actions like starting, stopping, or viewing logs from your services. The script is interactive, allowing you to customize the environment, build options, and other configurations easily.

### Basic Commands

#### Start the Project

To start the project in development (`dev`) mode or production (`prod`) mode, use the following options:

```bash
./run.sh -e <environment> -b -s
```

- `-e`: Specifies the environment (`dev` or `prod`). Default is `prod`.
- `-b`: Builds the images before starting the containers.
- `-s`: Starts the containers.
  Example:

```bash
./run.sh -e dev -b -s  # Start in dev mode and build images
./run.sh -e prod -s    # Start in prod mode without building
```

#### Stop the Project

To stop the project, you can use:

```bash
./run.sh -e <environment> -t
```

- `-e`: Specifies the environment (`dev` or `prod`). Default is `prod`.
- `-t`: Stops the containers.

To delete volumes when stopping, add the -v flag:

```bash
./run.sh -e dev -t -v  # Stop in dev mode and delete volumes
```

#### Show Logs

To view the logs of your running containers:

```bash
./run.sh -e <environment> -l
```

- `-e`: Specifies the environment (`dev` or `prod`). Default is `prod`.
- `-l`: Displays logs.

Example:

```bash
./run.sh -l  # Show logs for the default environment (prod)
```

#### Use a Custom .env File

You can specify a custom .env file to be used with Docker Compose using the --env-file flag:

```bash
./run.sh --env-file <path-to-env-file> -s
```

- `--env-file`: The path to your custom `.env` file.

Example:

```bash
./run.sh --env-file .env.dev -e dev -s  # Start using a custom .env file
```

<br>

## Options Summary

| Option          | Description                                                |
| --------------- | ---------------------------------------------------------- |
| `-e, --env`     | Set the environment (either dev or prod). Default is prod. |
| `-b, --build`   | Build the images before starting the containers.           |
| `-s, --start`   | Start the containers.                                      |
| `-t, --stop`    | Stop the containers.                                       |
| `-v, --volumes` | Delete volumes when stopping the containers.               |
| `-l, --logs`    | Show the logs of the running containers.                   |
| `--env-file`    | Specify a custom .env file.                                |

<br>

## Example Usage

1. **Start the project in `dev` mode with build**:

   ```bash
   ./run.sh -e dev -b -s
   ```

2. **Start the project in `prod` mode without build**:
   ```bash
   ./run.sh -e prod -s
   ```
3. **Stop the project and delete volumes**:

   ```bash
   ./run.sh -e dev -t -v
   ```

4. **Show the logs**:
   ```bash
   ./run.sh -l
   ```
5. Start the project using a custom .env file:

   ```bash
   ./run.sh --env-file .env.dev -e dev -s
   ```

<br>

## Troubleshooting

- **Error: `.env` file not found**

  If you encounter an error about the `.env` file not being found, ensure that the file exists in the root directory. If you're using a custom `.env` file, specify it using the `--env-file` option.

- **Docker permissions**

  Ensure that your user has permission to run Docker commands without sudo. If not, add your user to the Docker group:

  ```bash
  sudo usermod -aG docker $(whoami)
  ```

  After running this command, log out and back in for the changes to take effect.
