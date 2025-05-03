# Basic Commands

## Dev mode

### Initialization

docker compose --env-file .env -f docker/compose.traefik.yml -f docker/compose.yml -f docker/compose.api-dev.yml --profile setup up -d --build

### Stop after initialization

docker compose --env-file .env -f docker/compose.traefik.yml -f docker/compose.yml -f docker/compose.api-dev.yml --profile setup down

### Start

docker compose --env-file .env -f docker/compose.traefik.yml -f docker/compose.yml -f docker/compose.api-dev.yml up -d --build

### Stop

docker compose --env-file .env -f docker/compose.traefik.yml -f docker/compose.yml -f docker/compose.api-dev.yml down

### Stop and Delete Volumes

docker compose --env-file .env -f docker/compose.traefik.yml -f docker/compose.yml -f docker/compose.api-dev.yml down -v

### Logs

docker compose --env-file .env -f docker/compose.traefik.yml -f docker/compose.yml -f docker/compose.api-dev.yml logs -f

## Prod mode

### Initialization

docker compose --env-file .env -f docker/compose.traefik.yml -f docker/compose.yml --profile setup up -d --build

### Stop after initialization

docker compose --env-file .env -f docker/compose.traefik.yml -f docker/compose.yml --profile setup down

### Start

docker compose --env-file .env -f docker/compose.traefik.yml -f docker/compose.yml up -d --build

### Stop

docker compose --env-file .env -f docker/compose.traefik.yml -f docker/compose.yml down

### Stop and Delete Volumes

docker compose --env-file .env -f docker/compose.traefik.yml -f docker/compose.yml down -v

### Logs

docker compose --env-file .env -f docker/compose.traefik.yml -f docker/compose.yml logs -f
