#!/usr/bin/env bash

#______________________________________________________________________________

# SECTION: Database Connection Settings

CONTAINER_NAME="postgres-dojo-instance-01"
POSTGRES_USER="postgres"
DATABASE_NAME="postgres_dojo"

#______________________________________________________________________________

# Start the Docker instance.
# Nothing will happen if the instance has already been started
docker start $CONTAINER_NAME

# Enter the container using pgcli
docker exec -it \
$CONTAINER_NAME \
pgcli -U $POSTGRES_USER -d $DATABASE_NAME 

#______________________________________________________________________________
