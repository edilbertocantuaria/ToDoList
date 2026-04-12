FROM ruby:3.3

RUN apt-get update -y && apt-get install -y \
  build-essential \
  git \
  libpq-dev \
  nodejs \
  npm \
  postgresql-client \
  && rm -rf /var/lib/apt/lists/*

RUN npm install -g yarn

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

RUN chmod +x /app/entrypoint.sh

EXPOSE 3000

ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]