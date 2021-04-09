#!/bin/bash

set -e

echo "-------"
echo "Syncing production database with CDN"
echo "-------"

(
  set -x;
  ssh -i ~/.ssh/bot@server.interflux.com bot@server.interflux.com "cd /var/www/api.interflux.com/builds/production/latest; export RAILS_ENV=production; bin/rails cdn:sync"
)

echo "-------"
echo "Syncing local database with CDN"
echo "-------"

(
  set -x
  cd ~/Code/interflux-api-rails-backend/
  bin/rails cdn:sync
)

echo "-------"
echo "Database syncs complete!"
echo "-------"
echo ""
