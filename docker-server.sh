#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
HUGO_VERSION=$(cat $DIR/HUGO_VERSION)

docker run --rm -it -p 1313:1313 -u 1000:1000 -v $DIR:/src klakegg/hugo:$HUGO_VERSION-ext server
