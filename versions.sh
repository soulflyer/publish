#!/bin/bash

. ./setup.sh

echo "Fullsize dir is  $FULLSIZE_DIR"
TESTFILE="/Users/iain/Pictures/Published/fullsize/2017/05/11-testproj/IMG.jpg"
#TESTFILE=$(stat -f "%N" $TESTFILE)
FULLSIZEDIR=$(stat -f %N $FULLSIZEDIR)
echo $TESTFILE | sed s~$FULLSIZE_DIR~~
