#!/bin/bash

set -e

export DRIVE=~/Google\ Drive\ File\ Stream/Shared\ drives/Photos/Products
export REPO=~/Code/cdn.interflux.com
export ICC=~/Code/cdn.interflux.com/src/colour-profiles/sRGB_v4_ICC_preference.icc

init(){
  echo "-------"
  echo "Convert all PNG to JPG and WEBP"
  echo "-------"
  echo "DRIVE: $DRIVE"
  echo "REPO: $REPO"
  echo "ICC: $ICC"
  echo "-------"

  find "$DRIVE" -type f -and -name "*.png" -exec bash -c 'process "$@"' bash {} \;

  echo "-------"
  echo "Done!"
  echo "-------"
}

process(){
  png1=$1

  product=$(basename "$(dirname "$(dirname "$png1")")")
  file=$(basename "$(echo "$png1" | cut -f1 -d"@")")
  w1=$(identify -format '%w' "$1")
  h1=$(identify -format '%h' "$1")
  ratio=$(echo "scale=6; $w1/$h1" | bc -l) # Return ratio up to 6 decimals
  widths=(
    2400
    2200
    2000
    1800
    1600
    1400
    1200
    1000
    800
    600
    400
    200
    100
    50
  )

  echo "process    | $png1"
  echo "process    | $product"
  echo "process    | $file"
  echo "process    | ${w1}x${h1} $ratio"

  lint
  png
  webp
  jpg

  echo "-------"
}

lint(){
  local dir=$(dirname "$png1")

  # Ignore PNGs stored in Sketch folders
  if [[ $dir == *Sketch ]]
  then
    echo "lint       | SKIP: Is within Sketch folder"
    echo "-------"
    exit 1
  fi;

  # Only accept PNGs that live within folder called PNG
  if [[ ! $dir == *PNG ]]
  then
    echo "lint       | TODO: Place the PNG inside a folder called PNG"
    echo "-------"
    exit 1
  fi;

  # Only accept PNGs that end with @lossless.png
  if [[ ! $png1 == *@lossless.png ]]
  then
    echo "lint       | TODO: End file name with '@lossless.png'"
    echo "-------"
    exit 1
  fi;

  echo "lint       | OK"
}

png(){
  local w2=$((2400))
  local h2=$(echo "scale=0; 2400/$ratio" | bc -l)
  local size="${w2}x${h2}"

  png2="$REPO/src/public/images/products/$product/$file@$size.png"

  if [ ! -f "$png2" ];
  then
    echo "png        | $size"
    mkdir -p $(dirname "$png2")
    convert "$png1" -profile "$ICC" -resize $size "$png2"
  else
    echo "png        | $size (skip)"
  fi;
}

webp(){
  for width in ${widths[*]}
  do
    local w2=$(($width))
    local h2=$(echo "scale=0; $width/$ratio" | bc -l)
    local size="${w2}x${h2}"
    local webp1="$REPO/src/public/images/products/$product/$file@$size.webp"

    if [ ! -f "$webp1" ];
    then
      echo "webp       | $size"
      cwebp -quiet -q 90 -resize $size 0 "$png2" -o "$webp1";
    else
      echo "webp       | $size (skip)"
    fi;
  done
}

jpg(){
  for width in ${widths[*]}
  do
    local w2=$(($width))
    local h2=$(echo "scale=0; $width/$ratio" | bc -l)
    local size="${w2}x${h2}"
    local jpg1="$REPO/src/public/images/products/$product/$file@$size.jpg"

    if [ ! -f "$jpg1" ];
    then
      echo "jpg        | $size"
      convert "$png2" -resize $size -quality 90 -interlace JPEG "$jpg1"
    else
      echo "jpg        | $size (skip)"
    fi;
  done
}

export -f process
export -f lint
export -f png
export -f webp
export -f jpg

init
