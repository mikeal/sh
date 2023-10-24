#!/bin/sh



# boots.sh - Bootstrap file loader￼

BOOTS_USAGE='boots.sh URL'
BOOTS_DESC='URL will be retrieved once, cached indefinitely, and printed to stdout.'

help() {
    echo $BOOTS_USAGE
    echo $BOOTS_DESC
    echo "Usage:"
    echo "  -h, -help    Show help"
    echo "  -loader      Prints loader script"
    echo "All caching takes place in a .boots directory local to the script loader."
    exit 1
}

if [ -z "$1" ]; then
  help
fi

set -eu

if [ "$1" == "-help" ] || [ "$1" == "-h" ]; then
  help
fi


URL="$1"

read -r -d '' LOADER << EOF
case "$0" in
  */*)
    SCRIPT_DIR="${0%/*}"
    ;;
  *)
    SCRIPT_DIR="."
    ;;
esac
BOOTS_DIR="$SCRIPT_DIR/.boots"

mkdir -p $BOOTS_DIR
curl -s https:// > $BOOTS_DIR/boots.sh

EOF

if [ $1 == "-loader" ]; then
  echo "$LOADER"
  exit 0
fi

