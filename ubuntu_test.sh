#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
docker run --rm -v $DIR:/workspace swift:5.0 bash -c "cd /workspace && swift test"