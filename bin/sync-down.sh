#!/bin/bash

set -e

echo "-------"
echo "Syncing files from the CDN DOWN to local"
echo "-------"

# Download only the new files to the CDN.
# Delete locally the files which no longer exist on the CDN.

(set -x; s3cmd sync s3://cdn-interflux/ ./public/ --recursive --delete-removed --verbose)

echo "-------"
echo "CDN sync complete!"
echo "-------"
echo ""
