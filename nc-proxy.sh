#!/bin/sh -e

if [ $# != 3 ]
then
    echo "usage: $0 <src-port> <dst-host> <dst-port>"
    exit 0
fi

TMP=`mktemp -d`
PIPE=$TMP/pipe
trap 'rm -rf "$TMP"' EXIT
mkfifo -m 0600 "$PIPE"

nc -k -l -p "$1" <"$PIPE" | nc "$2" "$3" > "$PIPE"