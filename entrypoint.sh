#!/usr/bin/env sh
set -e

RAILS_ENV=production bundle exec rails db:migrate

# Execute the given or default command:
exec "$@"
