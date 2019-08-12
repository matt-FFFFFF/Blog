#!/bin/bash

HUGO_VERSION=$(cat HUGO_VERSION)

docker run --rm -it -u 1000:1000 -v /home/matt/source/repos/blog:/src -v /home/matt/source/repos/blog/output:/target klakegg/hugo:$HUGO_VERSION-ext
