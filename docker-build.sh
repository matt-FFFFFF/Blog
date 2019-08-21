#!/bin/bash

UID=$(id -u)
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
HUGO_VERSION=$(cat $DIR/HUGO_VERSION)

docker run --rm -it -u $UID:$UID -v /home/matt/source/repos/blog:/src -v /home/matt/source/repos/blog/output:/target klakegg/hugo:$HUGO_VERSION-ext