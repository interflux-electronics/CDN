#!/bin/bash

set -e

echo "-------"
echo "Syncing files from local UP to the CDN"
echo "-------"

# Remove pesky hidden Mac files
# We don't want them in the CDN

(set -x; find . -name '.DS_Store' -type f -delete)

echo "-------"

# Upload only the new files to the CDN
# Delete from the CDN the files that no longer exist

(set -x; s3cmd sync ./public/ s3://cdn-interflux/ --recursive --delete-removed --acl-public --add-header=Cache-Control:max-age=86400 --verbose)

echo "-------"

ssh -i ~/.ssh/bot@server.interflux.com bot@server.interflux.com "cd /var/www/api.interflux.com/builds/latest; bin/rails cdn:sync"

echo "-------"
echo "CDN sync complete!"
echo "-------"
echo ""
