#!/bin/bash

. ./setup.sh

TESTFILE=$1

#echo $TESTFILE | sed s~$FULLSIZE_DIR~~ | sed s~^/~~
SUBPATH=${TESTFILE##$FULLSIZE_DIR/}
#DIRNAME=$(dirname $SUBPATH)
#FILENAME=$(basename $SUBPATH)

MEDIUM=$MEDIUM_DIR/$SUBPATH
LARGE=$LARGE_DIR/$SUBPATH
FULLSIZE=$FULLSIZE_DIR/$SUBPATH
SMALL=$SMALL_DIR/$SUBPATH
THUMB=$THUMB_DIR/$SUBPATH

if [ ! -d $(dirname $MEDIUM) ]
then
    mkdir -p $(dirname $MEDIUM)
    mkdir -p $(dirname $LARGE)
    mkdir -p $(dirname $SMALL)
    mkdir -p $(dirname $THUMB)
fi

if [ "$FULLSIZE" -nt "$MEDIUM" ]
then
    echo "Versions of $SUBPATH are out of date"
    convert $FULLSIZE -resize 1024x1024 $MEDIUM
    ~/bin/add-watermark $MEDIUM
    convert $FULLSIZE -resize 2048x2048 $LARGE
    ~/bin/add-watermark $LARGE
    convert $FULLSIZE -resize 512x512 $SMALL
    ~/bin/add-watermark $SMALL
    convert $FULLSIZE -resize 160x160 $THUMB
else
    echo "$SUBPATH is up to date"
fi
