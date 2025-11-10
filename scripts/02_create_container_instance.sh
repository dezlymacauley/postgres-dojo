#!/usr/bin/env bash

# Get the script directory
SCRIPTS_DIR="$(dirname "${BASH_SOURCE[0]}")"

# Get the absolute path to the project root
PROJECT_ROOT="$(cd "$SCRIPTS_DIR/.." && pwd)"

#______________________________________________________________________________
# NOTE: It's bad practice to create a volume for the entire container.
#
# Only create a volume for directories that need to be persistent
# This volume will be attached to the the container directory:
# /var/lib/postgresql/data  
# So even if the container instance is deleted, when a new instance is created
# all of the databases created by the user of Postgres Dojo will 
# be automatically available.
# A new volume will only be created if there is no existing volume,
# so you don't need to worry about data being overwritten.

docker volume inspect postgres-dojo-instance-01-saved-databases >/dev/null 2>&1 || \
docker volume create postgres-dojo-instance-01-saved-databases
#______________________________________________________________________________
# This volume will be attached to the the container directory:
# /home/postgres-dojo-user
# So even if the container instance is deleted, when a new instance is created
# all of the files in /home/postgres-dojo-user will be 
# automatically available. The user is also free to save notes,
# edit configuration files and these files and the changes will be saved.
# A new volume will only be created if there is no existing volume,
# so you don't need to worry about data being overwritten.

docker volume inspect postgres-dojo-instance-01-user-home >/dev/null 2>&1 || \
docker volume create postgres-dojo-instance-01-user-home
#______________________________________________________________________________

# Remove container if it exists
docker rm -f postgres-dojo-instance-01 >/dev/null 2>&1 || true

# Run the container with the attached volumes
docker run -d \
--name postgres-dojo-instance-01 \
-e POSTGRES_PASSWORD=mysecretpassword \
-e POSTGRES_USER=postgres \
-e POSTGRES_DB=postgres_dojo \
-p 127.0.0.1:5432:5432 \
-v postgres-dojo-instance-01-saved-databases:/var/lib/postgresql/data \
-v postgres-dojo-instance-01-user-home:/home/postgres-dojo-user \
dezlymacauley/postgres-dojo:0.0.4
