#!/bin/bash
# this script creates all the missing versions
for filename in `~/bin/check-images -s /Users/iain/Pictures/Published/medium`
do
    ~/Code/publish/versions-no-save-meta.sh ~/Pictures/Published/fullsize/$filename/*.jpg
    #~/Code/publish/small.sh "~/Pictures/Published/fullsize/$filename/*.jpg"
done
