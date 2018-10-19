#!/bin/bash

. /Users/iain/Code/publish/setup.sh

PROJECT=$(basename $1)
MONTH=$(basename $(dirname $1))
YEAR=$(basename $(dirname $(dirname $1)))

image-search -y $YEAR -m $MONTH -p $PROJECT
