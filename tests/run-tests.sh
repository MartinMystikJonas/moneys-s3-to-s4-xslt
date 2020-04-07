#!/bin/sh

dir=$(cd `dirname $0` && pwd)

bash "$dir/../vendor/bin/tester" -C . $@
