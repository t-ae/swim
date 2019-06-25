#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cmd="swift test $@"
echo "$cmd"
docker run --rm -w /workspace -v $DIR:/workspace swift:5.0 bash -c "$cmd"
