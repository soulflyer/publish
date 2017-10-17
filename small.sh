#!/bin/bash

. /Users/iain/Code/publish/setup.sh

while (( $# ))
do

TESTFILE=$1

#echo $TESTFILE | sed s~$FULLSIZE_DIR~~ | sed s~^/~~
SUBPATH=${TESTFILE##$FULLSIZE_DIR/}
#DIRNAME=$(dirname $SUBPATH)
#FILENAME=$(basename $SUBPATH)

FULLSIZE=$FULLSIZE_DIR/$SUBPATH
SMALL=$SMALL_DIR/$SUBPATH

if [ ! -d $(dirname $SMALL) ]
then
    mkdir -p $(dirname $SMALL)
fi

if [ "$FULLSIZE" -nt "$SMALL" ]
then
    echo "Versions of $SUBPATH are out of date"
    convert $FULLSIZE -resize 512x512 $SMALL
    ~/bin/add-watermark $SMALL
else
    echo "$SUBPATH is up to date"
fi
shift
done
