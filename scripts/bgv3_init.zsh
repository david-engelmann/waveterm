#!/bin/zsh

# Wave connection init for bgv3 dev

cd /Users/david/bg/bgv3 || cd ~

if ! docker info >/dev/null 2>&1; then
  echo "[wave] Docker is not running; please start Docker Desktop."
  exec zsh
fi

if ! docker ps --format '{{.Names}}' | grep -q '^bgv3_app$'; then
  echo "[wave] starting docker compose up -d db redis app..."
  docker compose -f docker-compose.dev.yml up
  sleep 100
fi

echo "[wave] attaching to bgv3_app container..."
exec docker exec -it bgv3_app /bin/bash
