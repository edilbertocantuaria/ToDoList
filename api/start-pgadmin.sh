#!/bin/bash
set -e

PGADMIN_DIR="$(find /opt/pgadmin4/lib -type f -name pgAdmin4.py -printf '%h\n' -quit)"
if [ -z "$PGADMIN_DIR" ]; then
  echo "pgAdmin installation was not found." >&2
  exit 1
fi

exec /opt/pgadmin4/bin/gunicorn \
  --bind 0.0.0.0:5050 \
  --workers=1 \
  --threads=25 \
  --chdir "$PGADMIN_DIR" \
  pgAdmin4:app
