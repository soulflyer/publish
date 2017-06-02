#!/bin/bash

. ./setup.sh

# find all the fullsize pics created or modified since the modification
# date on $LAST_RUN_FILE
find $FULLSIZE_DIR -mindepth $FIND_MIN_DEPTH\
     -newer $LAST_RUN_FILE\
     -type f\
     -name "*.jpg"
