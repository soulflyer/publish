#!/bin/bash
while getopts "ns:?h" flag
do
    echo "$flag" $OPTIND $OPTARG
    case $flag in
        "?" | "h" )
        cat <<EOF
test ?  (or h or help)
    this message
EOF
        ;;
        "s" )
            SESSION=$OPTARG
        ;;
    esac
done
shift $((OPTIND-1))
echo "$*"
