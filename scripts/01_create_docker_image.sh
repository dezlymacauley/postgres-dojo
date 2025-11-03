#!/usr/bin/env bash

# This will get name of the directory where this script is being run from
SCRIPTS_DIR="$(dirname "${BASH_SOURCE[0]}")"

# This will go one level up `..` and get the absolute path
# to the root of the project directory
PROJECT_ROOT="$(cd "$SCRIPTS_DIR/.." && pwd)"

docker buildx build --load \
-t dezlymacauley/postgres-dojo:0.0.2 \
-f "$PROJECT_ROOT/Dockerfile" \
"$PROJECT_ROOT"
