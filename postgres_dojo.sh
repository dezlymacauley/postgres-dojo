#!/usr/bin/env bash

docker exec -it \
postgres-dojo-instance-01 \
pgcli -U postgres -d postgres_dojo
