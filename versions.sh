#!/bin/bash

# TODO Add option to check DB and only create versions of images that are rated
# above a certain value.


. /Users/iain/Code/publish/setup.sh

function make-directories {
    local SUBPATH=$1
    local MEDIUM=$MEDIUM_DIR/$SUBPATH
    local LARGE=$LARGE_DIR/$SUBPATH
    local FULLSIZE=$FULLSIZE_DIR/$SUBPATH
    local SMALL=$SMALL_DIR/$SUBPATH
    local THUMB=$THUMB_DIR/$SUBPATH

    if [ ! -d $MEDIUM ]
    then
        echo "making $MEDIUM"
        mkdir -p $MEDIUM
    fi
    if [ ! -d $THUMB ]
    then
        echo "making $THUMB"
        mkdir -p $THUMB
    fi
    if [ ! -d $SMALL ]
    then
        echo "Making $SMALL"
        mkdir -p $SMALL
    fi
    if [ ! -d $LARGE ]
    then
        echo "Making $LARGE"
        mkdir -p $LARGE
    fi
}

function convert-pic {
    local SUBPATH=$1
    local MEDIUM=$MEDIUM_DIR/$SUBPATH
    local LARGE=$LARGE_DIR/$SUBPATH
    local FULLSIZE=$FULLSIZE_DIR/$SUBPATH
    local SMALL=$SMALL_DIR/$SUBPATH
    local THUMB=$THUMB_DIR/$SUBPATH

    # echo "SUBPATH is $SUBPATH"
    if [[ "$SUBPATH" == *.jpg ]]
    then
        if [ "$FULLSIZE" -nt "$MEDIUM" ]
        then
            echo "Versions of $SUBPATH are out of date"
            convert $FULLSIZE -resize 1024x1024 $MEDIUM
            ~/bin/add-watermark $MEDIUM
            convert $FULLSIZE -resize 2048x2048 $LARGE
            ~/bin/add-watermark $LARGE
            convert $FULLSIZE -resize 512x512 $SMALL
            ~/bin/add-watermark $SMALL
            convert $FULLSIZE -resize 160x160 $THUMB
        else
            echo "$SUBPATH is up to date"
        fi
    else
        echo "$SUBPATH is not a jpeg"
    fi
}

NO_META="FALSE"
DIRECTORY=""
while getopts 'xhd:' OPTION
do
    case $OPTION in
        x) NO_META="TRUE"
           ;;
        d) DIRECTORY=$OPTARG
           ;;
        h) CAT <<EOF
Use versions -x to suppress write to db.

EOF
           exit 2
           ;;
    esac
done

echo "NO_META is " $NO_META
shift $((OPTIND-1))

# Process a directory of pics if one is specified.
if [ $DIRECTORY ]
then
    echo "Processing contents of directory $DIRECTORY"

    make-directories $DIRECTORY
    # Looks like we are removing the first part of the path then replacing it
    # but $DIRECTORY may or may not already have the FULLSIZE_DIR prefix
    SUBPATH=${DIRECTORY##FULLSIZE_DIR}
    FULLSIZE=$FULLSIZE_DIR/$SUBPATH

    if [ $NO_META == "FALSE" ]
    then
        ~/bin/save-meta $FULLSIZE
    fi

    PICS=$(ls $FULLSIZE)
    for pic in $PICS
    do
        convert-pic $SUBPATH/$pic
    done
fi

# Process files specified on the command line
while (( $# ))
do
    TESTFILE=$1
    SUBPATH=${TESTFILE##$FULLSIZE_DIR/}
    convert-pic $SUBPATH
    make-directories $(dirname $SUBPATH)

    if [ $NO_META = "FALSE" ]
         then
            ~/bin/save-meta $FULLSIZE_DIR/$SUBPATH
         else
             echo "$SUBPATH not added to db"
         fi
    shift
done
