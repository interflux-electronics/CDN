#!/bin/bash

set -e

src=src/public
dest=../api.interflux.com/db/seeds/data/cdn_files.yml

echo "-------"
echo "Index all CDN files to a Rails seed file"
echo "Source: ${src}"
echo "Destination: ${dest}"
echo "-------"
echo "find . -name '.DS_Store' -type f -delete"
find . -name '.DS_Store' -type f -delete
echo "-------"

# With `find` we list all the files in src/public
# With `sed` we prepend each line with a dash
# list=$(find $src -type f | sed 's/^/- /')
# And remove src/public/ as well:
list=$(find $src -type f | sed 's/^src\/public\//- /')

# Write to the seed file
echo "${list}" > $dest

# Print for sanity check
echo "${list}"

echo "-------"
echo "cd ../api.interflux.com/"
cd ../api.interflux.com/
echo "-------"
echo "git add db/seeds/data/cdn_files.yml"
git add db/seeds/data/cdn_files.yml
echo "-------"
echo "git commit -m \"Update CDN seed file\""
git commit -m "Update CDN seed file"
echo "-------"
echo "git push"
git push
echo "-------"
echo "Done!"
echo "-------"
