#!/bin/bash
# this script creates all the missing small versions
for filename in `~/bin/check-images -s /Users/iain/Pictures/Published/small`
do
    ~/Code/publish/small.sh ~/Pictures/Published/fullsize/$filename/*.jpg
    #~/Code/publish/small.sh "~/Pictures/Published/fullsize/$filename/*.jpg"
done
