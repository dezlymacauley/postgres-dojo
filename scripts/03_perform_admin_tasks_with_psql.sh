#!/usr/bin/env bash

docker exec -it \
postgres-dojo-instance-01 \
psql -U postgres -d postgres
