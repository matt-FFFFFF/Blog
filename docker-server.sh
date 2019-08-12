#!/bin/bash

HUGO_VERSION=$(cat HUGO_VERSION)

docker run --rm -it -p 1313:1313 -u 1000:1000 -v /home/matt/source/repos/blog:/src -v /home/matt/source/repos/blog/output:/target klakegg/hugo:$HUGO_VERSION-ext server
