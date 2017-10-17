#!/bin/bash

. /Users/iain/Code/publish/setup.sh

while (( $# ))
do

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
    echo "making MEDIUM"
    mkdir -p $(dirname $MEDIUM)
fi
if [ ! -d $(dirname $THUMB) ]
then
    echo "making THUMB"
    mkdir -p $(dirname $THUMB)
fi
if [ ! -d $(dirname $SMALL) ]
then
    echo "Making SMALL"
    mkdir -p $(dirname $SMALL)
fi
if [ ! -d $(dirname $LARGE) ]
then
    echo "Making LARGE"
    mkdir -p $(dirname $LARGE)
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
shift
done
