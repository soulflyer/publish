#!/bin/bash
# Opens a photo project in finder and aperture. Given an integer parameter
# will look for the project in /tmp/missing.txt.
# If there is no parameter or this file is missing it will build the file,
# then open the project.

nth=1

if [ $1 ]
then
    nth=$1
else
    echo "rebuilding list of projects"
    check-images -s /Users/iain/Pictures/Published/large > /tmp/missing.txt
fi

if [ ! -f "/tmp/missing.txt" ]
then
    echo "project list missing, rebuilding"
    check-images -s /Users/iain/Pictures/Published/large > /tmp/missing.txt
fi

if [ -s "/tmp/missing.txt" ]
   then
   open-project $(tail -r /tmp/missing.txt | sed -e"$nth"p -n)
else
    echo "All projects are ok"
fi
