#!/bin/bash

CONVERT_PATH="/opt/local/bin/convert"
THUMB_SIZE="160x160"
SMALL_SIZE="512x512"
MEDIUM_SIZE="1024x1024"
LARGE_SIZE="2048x2048"
PHOTODIR="/Users/iain/Pictures/Published"

#Source folder defaults to current dir unless there is a parameter
#FILE_FOLDER="."
OUTPUT_FOLDER="/tmp"
TIME=50
LONG_TIME=200

while getopts 'f:o:t:d:D:p:' OPTION
do
    case $OPTION in
        f)  FILE_FOLDER=$OPTARG
            ;;
        o)  OUTPUT_FOLDER=$OPTARG
            ;;
        t)  THUMB_OUTPUT=$OPTARG
            ;;
        d)  TIME=$OPTARG
            ;;
        D)  LONG_TIME=$OPTARG
            ;;
        p)  PROJECT=$OPTARG
            ;;
        ?) echo "no help"
            exit 2
            ;;
    esac
done

shift $((OPTIND-1))

if [[ -d $FILE_FOLDER ]]
then
    echo "Making all files in $FILE_FOLDER into a gif"
    FILE_LIST=`ls $FILE_FOLDER`
else
    echo "Dir not found: $FILE_FOLDER"
    FILE_LIST=$@
fi
echo "file_list: " $FILE_LIST
COUNT=`echo $FILE_LIST | wc -w`
if [[ $COUNT -eq 0 ]]
then
    echo "No files found"
    exit 2
fi

if ! [[ $PROJECT == "" ]]
then
    THUMB_OUTPUT=$PHOTODIR/thumbs/$PROJECT
    SMALL_OUTPUT=$PHOTODIR/small/$PROJECT
    MEDIUM_OUTPUT=$PHOTODIR/medium/$PROJECT
    LARGE_OUTPUT=$PHOTODIR/large/$PROJECT
    OUTPUT_FOLDER=$PHOTODIR/fullsize/$PROJECT
fi

if ! [[ -e $OUTPUT_FOLDER ]]
then
    echo "Making output folder"
    mkdir -p $OUTPUT_FOLDER
fi
echo "Outputting to $OUTPUT_FOLDER"

COMMAND_STRING="$CONVERT_PATH -loop 0 "
i=0
for FILE_NAME in $FILE_LIST
do
    if [ $i == 0 ]
    then
        FILE_ROOT=`basename -s ".jpg" $FILE_NAME`
    fi
    i=`expr $i + 1`
    if [ $i == $COUNT ]
    then
        TIME=200
    fi
    COMMAND_STRING="$COMMAND_STRING -delay $TIME $FILE_FOLDER/$FILE_NAME"
done

COMMAND_STRING="$COMMAND_STRING $OUTPUT_FOLDER/$FILE_ROOT.gif"
#echo $COMMAND_STRING
eval $COMMAND_STRING

#Convert the fullsize gif to a thumbnail
if [ $THUMB_OUTPUT ]
then
    echo "output thumb  to " $THUMB_OUTPUT
    eval "$CONVERT_PATH -resize $THUMB_SIZE $OUTPUT_FOLDER/$FILE_ROOT.gif $THUMB_OUTPUT/$FILE_ROOT.gif"
fi

if [ $SMALL_OUTPUT ]
then
    echo "output small  to " $SMALL_OUTPUT
    eval "$CONVERT_PATH -resize $SMALL_SIZE $OUTPUT_FOLDER/$FILE_ROOT.gif $SMALL_OUTPUT/$FILE_ROOT.gif"
fi
if [ $MEDIUM_OUTPUT ]
then
    echo "output medium to " $MEDIUM_OUTPUT
    eval "$CONVERT_PATH -resize $MEDIUM_SIZE $OUTPUT_FOLDER/$FILE_ROOT.gif $MEDIUM_OUTPUT/$FILE_ROOT.gif"
fi
if [ $LARGE_OUTPUT ]
then
    echo "output large  to " $LARGE_OUTPUT
    eval "$CONVERT_PATH -resize $LARGE_SIZE $OUTPUT_FOLDER/$FILE_ROOT.gif $LARGE_OUTPUT/$FILE_ROOT.gif"
fi
