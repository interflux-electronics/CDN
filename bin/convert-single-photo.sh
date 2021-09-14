#!/bin/bash

set -e

export PHOTO=$1
export ICC=~/Code/cdn.interflux.com/src/colour-profiles/sRGB_v4_ICC_preference.icc

init(){
  echo "-------"
  echo "Convert single photo"
  echo "-------"
  echo "PHOTO: $PHOTO"
  echo "ICC: $ICC"
  echo "-------"

  process
  # find "$DRIVE" -type f -and -name "*.png" -exec bash -c 'process "$@"' bash {} \;

  echo "-------"
  echo "Done!"
  echo "-------"
}

process(){
  DIR="$(dirname "$PHOTO")"
  FILE=$(basename "$(echo "$PHOTO" | cut -f1 -d"@")")
  w1=$(identify -format '%w' "$PHOTO")
  h1=$(identify -format '%h' "$PHOTO")
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

  echo "process    | $PHOTO"
  echo "process    | $DIR"
  echo "process    | $FILE"
  echo "process    | ${w1}x${h1} $ratio"

  lint
  # png
  webp $w1
  jpg $w1

  echo "-------"
}

lint(){
  # Only accept PNGs and JPGs which end with @original
  if [[ ! $PHOTO == *@original.jpg && ! $PHOTO == *@original.png ]];
  then
    echo "lint       | TODO: File must end with @original.png or @original.png"
    echo "-------"
    exit 1
  fi;

  echo "lint       | OK"
}

# png(){
#   local w2=$((2400))
#   local h2=$(echo "scale=0; 2400/$ratio" | bc -l)
#   local size="${w2}x${h2}"
#
#   png2="$REPO/src/public/images/products/$product/$file@$size.png"
#
#   if [ ! -f "$png2" ];
#   then
#     echo "png        | $size"
#     mkdir -p $(dirname "$png2")
#     convert "$png1" -profile "$ICC" -resize $size "$png2"
#   else
#     echo "png        | $size (skip)"
#   fi;
# }

webp(){
  for width in ${widths[*]}
  do
    local w1=$1
    local w2=$(($width))
    local h2=$(echo "scale=0; $width/$ratio" | bc -l)
    local size="${w2}x${h2}"
    local webp1="$DIR/$FILE@$size.webp"

    if [[ ! -f "$webp1" && "$w1" -gt "$w2" ]];
    then
      echo "webp       | $size"
      cwebp -quiet -q 90 -resize $size 0 "$PHOTO" -o "$webp1";
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
    local jpg1="$DIR/$FILE@$size.jpg"

    if [[ ! -f "$jpg1" && "$w1" -gt "$w2" ]];
    then
      echo "jpg        | $size"
      convert "$PHOTO" -resize $size -quality 90 -interlace JPEG "$jpg1"
    else
      echo "jpg        | $size (skip)"
    fi;
  done
}

export -f process
export -f lint
# export -f png
export -f webp
export -f jpg

init
