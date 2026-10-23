FROM ruby:3.3

RUN apt-get update -y && apt-get install -y \
  build-essential \
  git \
  libpq-dev \
  nodejs \
  npm \
  python3 \
  python3-dev \
  python3-venv \
  postgresql-client \
  supervisor \
  && rm -rf /var/lib/apt/lists/*

RUN npm install -g yarn

RUN python3 -m venv /opt/pgadmin4 \
  && /opt/pgadmin4/bin/pip install --no-cache-dir --upgrade pip \
  && /opt/pgadmin4/bin/pip install --no-cache-dir pgadmin4 gunicorn

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

RUN PGADMIN_CONFIG="$(find /opt/pgadmin4/lib -type f -path '*/pgadmin4/config.py' -print -quit)" \
  && test -n "$PGADMIN_CONFIG" \
  && cp /app/pgadmin_config.py "$(dirname "$PGADMIN_CONFIG")/config_local.py" \
  && groupadd --system pgadmin \
  && useradd --system --gid pgadmin --home-dir /var/lib/pgadmin --shell /usr/sbin/nologin pgadmin \
  && cp /app/start-container.sh /usr/local/bin/todo-start-container \
  && cp /app/start-pgadmin.sh /usr/local/bin/todo-start-pgadmin \
  && sed -i 's/\r$//' /usr/local/bin/todo-start-container /usr/local/bin/todo-start-pgadmin \
  && chmod +x /usr/local/bin/todo-start-container /usr/local/bin/todo-start-pgadmin \
  && cp /app/supervisord.conf /etc/supervisor/conf.d/todo-list.conf \
  && sed -i 's/\r$//' /etc/supervisor/conf.d/todo-list.conf

RUN mkdir -p /var/lib/pgadmin \
  && chown pgadmin:pgadmin /var/lib/pgadmin

EXPOSE 3000 5050

ENTRYPOINT ["/bin/bash", "/app/entrypoint.sh"]
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]