#!/bin/sh
find . -type f | grep -v -e './node_modules' -e './.git' -e './build' -e './dist' | wc -l | sed 's/[ ]*//'
