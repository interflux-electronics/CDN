#!/bin/bash

set -e

echo "-------"
echo "Purging Interflux CDN cache"
echo "-------"

API_KEY=$(grep API_KEY .env | cut -d '=' -f2)
CDN_UUID=$(grep CDN_UUID .env | cut -d '=' -f2)

# echo $API_KEY
# echo $CDN_UUID

if [[ -z $API_KEY || -z $CDN_UUID ]]; then
  echo 'one or more variables are undefined'
  exit 1
fi

# List all CDNs for API token
echo "curl -X GET -H \"Content-Type: application/json\" -H \"Authorization: Bearer $API_KEY\" \"https://api.digitalocean.com/v2/cdn/endpoints\" | underscore print --outfmt pretty"
curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer $API_KEY" "https://api.digitalocean.com/v2/cdn/endpoints" | underscore print --outfmt pretty

echo "-------"
# Purge cache given CDN UUID
echo "curl -X DELETE -H \"Content-Type: application/json\" -H \"Authorization: Bearer $API_KEY\" -d '{\"files\": [\"*\"]}' \"https://api.digitalocean.com/v2/cdn/endpoints/$CDN_UUID/cache\" | underscore print --outfmt pretty"
curl -X DELETE -H "Content-Type: application/json" -H "Authorization: Bearer $API_KEY" -d '{"files": ["*"]}' "https://api.digitalocean.com/v2/cdn/endpoints/$CDN_UUID/cache"
echo "-------"
echo "Complete"
echo "-------"
