#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"                                                 HUGO_VERSION=$(cat $DIR/HUGO_VERSION)

docker run --rm -it -u 1000:1000 -v /home/matt/source/repos/blog:/src klakegg/hugo:$HUGO_VERSION-ext "new post/$1/index.md"
