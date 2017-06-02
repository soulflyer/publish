#!/bin/bash

# Leave the / off the end
export PUBLISHED_DIR=~/Pictures/Published

FULLSIZE_DIR=$PUBLISHED_DIR/fullsize
export FULLSIZE_DIR=$(stat -f %N $FULLSIZE_DIR)
LARGE_DIR=$PUBLISHED_DIR/large
export LARGE_DIR=$(stat -f %N $LARGE_DIR)
MEDIUM_DIR=$PUBLISHED_DIR/medium
export MEDIUM_DIR=$(stat -f %N $MEDIUM_DIR)
THUMB_DIR=$PUBLISHED_DIR/thumbs
export THUMB_DIR=$(stat -f %N $THUMB_DIR)
# LAST_RUN_FILE=$PUBLISHED_DIR/.publish-last-run
LAST_RUN_FILE=$FULLSIZE_DIR/digikam4.db
FIND_MIN_DEPTH=4
