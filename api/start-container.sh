#!/bin/bash
set -e

rm -f /app/tmp/pids/server.pid

PGADMIN_DIR="$(find /opt/pgadmin4/lib -type f -name pgAdmin4.py -printf '%h\n' -quit)"
if [ -z "$PGADMIN_DIR" ]; then
  echo "pgAdmin installation was not found." >&2
  exit 1
fi

mkdir -p /var/lib/pgadmin
chown pgadmin:pgadmin /var/lib/pgadmin

if [ ! -f /var/lib/pgadmin/pgadmin4.db ]; then
  runuser -u pgadmin -- env \
    PGADMIN_SETUP_EMAIL="$PGADMIN_DEFAULT_EMAIL" \
    PGADMIN_SETUP_PASSWORD="$PGADMIN_DEFAULT_PASSWORD" \
    /opt/pgadmin4/bin/python "$PGADMIN_DIR/setup.py" setup-db
fi

bundle exec rails db:prepare
exec /usr/bin/supervisord -n -c /etc/supervisor/conf.d/todo-list.conf
