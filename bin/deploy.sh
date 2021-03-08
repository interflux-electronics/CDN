#!/bin/bash

set -e

echo "-------"
echo "Deploying Interflux CDN"
echo "-------"

(set -x; git checkout production -f)

echo "-------"

(set -x; git pull origin master)

echo "-------"

(set -x; git push)

echo "-------"
# Remove pesky hidden Mac files
# We don't want them in the CDN

(set -x; find . -name '.DS_Store' -type f -delete)

echo "-------"
# Upload only the new files to the CDN
# Delete from the CDN the files that no longer exist

(set -x; s3cmd sync src/public/ s3://cdn-interflux/ --recursive --delete-removed --acl-public --add-header=Cache-Control:max-age=86400 --verbose)

echo "-------"
echo "CDN sync complete!"
echo "-------"

(set -x; git checkout master)

echo "-------"
echo "Done!"
echo "-------"
echo ""
