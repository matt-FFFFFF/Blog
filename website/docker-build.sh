#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
HUGO_VERSION=$(cat $DIR/HUGO_VERSION)

docker run --rm -it -u $UID:$UID -v $DIR:/src -v $DIR/build:/target klakegg/hugo:$HUGO_VERSION-ext
