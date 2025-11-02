#!/usr/bin/env bash

# Get the script directory
SCRIPTS_DIR="$(dirname "${BASH_SOURCE[0]}")"

# Get the absolute path to the project root
PROJECT_ROOT="$(cd "$SCRIPTS_DIR/.." && pwd)"

#______________________________________________________________________________

# NOTE: It's bad practice to create a volume for the entire container.
# Only create a volume for directories that need to be persistent

# Create the Postgres database volume if it doesn't exist
docker volume inspect postgres-dojo-instance-01-db-data >/dev/null 2>&1 || \
docker volume create postgres-dojo-instance-01-db-data

# Create a volume for config files if it doesn't exist
docker volume inspect postgres-dojo-instance-01-dojo-configs >/dev/null 2>&1 || \
docker volume create postgres-dojo-instance-01-dojo-configs

#______________________________________________________________________________

# Remove container if it exists
docker rm -f postgres-dojo-instance-01 >/dev/null 2>&1 || true

# Run the container
docker run -d \
--name postgres-dojo-instance-01 \
-e POSTGRES_PASSWORD=mysecretpassword \
-e POSTGRES_USER=postgres \
-e POSTGRES_DB=postgres \
-p 127.0.0.1:5432:5432 \
-v postgres-dojo-instance-01-db-data:/var/lib/postgresql \
-v postgres-dojo-instance-01-dojo-configs:/dojo-configs \
dezlymacauley/postgres-dojo:0.0.1
