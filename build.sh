#!/usr/bin/env bash

export MESSAGE="
# Generated from https://github.com/akerl/keys/
# Served by https://github.com/dock0/pubkeys
# $(date)
"

function build_index() {
    echo "# $(basename $(pwd)) key set" > index.txt
    echo "$MESSAGE" >> index.txt
    find -L . -type f -not -name '*\.*' -exec cat {} \; \
        | awk '{print length, $0}' \
        | sort -n \
        | cut -d " " -f2- \
        | tee -a index.txt
}
export -f build_index

find -L . -mindepth 1 -type d | xargs -n1 -I{} sh -c "cd {} && build_index"

ln -s default/index.txt index.txt
