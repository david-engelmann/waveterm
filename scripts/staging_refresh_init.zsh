#!/bin/zsh

# Wave connection init for staging-refresh

# cd into the staging-refresh repo on the host
cd /Users/david/bg/staging-refresh || cd ~

# Make sure Docker is available
if ! docker info >/dev/null 2>&1; then
  echo "[wave] Docker is not running; please start Docker Desktop."
  exec zsh
fi

# Ensure staging-refresh stack is up (db + app container)
if ! docker ps --format '{{.Names}}' | grep -q '^beatgig-staging-refresh$'; then
  echo "[wave] starting docker compose up -d..."
  docker compose -f docker-compose.yml up
  sleep 100
fi

echo "[wave] attaching to beatgig-staging-refresh container..."
exec docker exec -it beatgig-staging-refresh /bin/bash
