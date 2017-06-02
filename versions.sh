#!/bin/bash

. ./setup.sh

TESTFILE=$1

#echo $TESTFILE | sed s~$FULLSIZE_DIR~~ | sed s~^/~~
SUBPATH=${TESTFILE##$FULLSIZE_DIR/}
DIRNAME=$(dirname $SUBPATH)
FILENAME=$(basename $SUBPATH)
echo "Sub directory is $DIRNAME"
echo "File is $FILENAME"
