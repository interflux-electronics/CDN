#!/bin/bash

# This script takes one PNG and converts it to a JPG and WEBP of the same size and name.

set -e

export ORIGINAL=$1
export ICC=~/Code/interflux-cdn/src/colour-profiles/sRGB_v4_ICC_preference.icc

init(){
  echo "-------"
  echo "Convert single photo"
  echo "-------"
  echo "ORIGINAL: $ORIGINAL"
  echo "-------"

  process

  echo "-------"
  echo "Done!"
  echo "-------"
}

process(){
  DIR="$(dirname "$ORIGINAL")"
  FILE=$(basename "$(echo "$ORIGINAL" | cut -f1 -d"@")")

  export w=$(identify -format '%w' "$ORIGINAL")
  export h=$(identify -format '%h' "$ORIGINAL")
  export size="${w}x${h}"

  echo "process    | $ORIGINAL"
  echo "process    | $DIR"
  echo "process    | $FILE"
  echo "process    | ${w}x${h}"

  reset
  jpg
  webp
  base
}

reset(){
  echo "reset      | deleting..."
  rm -rf "$DIR/$FILE@$size.webp"
  rm -rf "$DIR/$FILE@temp.webp"
  rm -rf "$DIR/$FILE@$size.jpg"
}

jpg(){
  local output="$DIR/$FILE@$size.jpg"

  if [[ ! -f "$output" ]];
  then
    echo "jpg        | $size"
    convert "$ORIGINAL" -resize $size -quality 90 -interlace JPEG "$output"
  else
    echo "jpg        | $size (skip)"
  fi;
}

webp(){
  local output="$DIR/$FILE@$size.webp"
  local temp="$DIR/$FILE@temp.webp"

  if [[ ! -f "$output" ]];
  then
    echo "webp       | $size"

    # For large photos, best compression and colour profile loss is hard to see.
    cwebp -quiet -q 90 -m 6 -resize $size 0 "$ORIGINAL" -o "$output";

    # For images where there has clearly been a colour loss.
    # cwebp -quiet -near_lossless 60 -resize $size 0 "$ORIGINAL" -o "$output";
  else
    echo "webp       | $size (skip)"
  fi;
}

base(){
  local w2=$(echo "scale=0; $w/20" | bc -l)
  local h2=$(echo "scale=0; $h/20" | bc -l)
  local size2="${w2}x${h2}"
  local temp="$DIR/$FILE@$size2.webp"
  local output="$DIR/$FILE@$size.base64"

  echo "base64     | $size2"
  rm -rf $output
  cwebp -quiet -q 90 -resize $size2 0 "$ORIGINAL" -o "$temp";
  base64 "$temp" > "$output"
  rm $temp;
}

export -f process
export -f reset
export -f jpg
export -f webp
export -f base

init
