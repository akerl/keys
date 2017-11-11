#!/usr/bin/env bash

export MESSAGE="
# Generated from https://github.com/akerl/keys/
# $(date)
"

export BUILD_DIR=_build
rm -rf "$BUILD_DIR"
mkdir "$BUILD_DIR"

function build_index() {
    set_name="$(basename $(pwd))"
    set_dir="../${BUILD_DIR}/${set_name}"
    set_index="${set_dir}/index.txt"
    mkdir -p "$set_dir"
    echo "# ${set_name} key set" > $set_index
    echo "$MESSAGE" >> $set_index
    find -L . -type f -not -name '*\.*' -exec cat {} \; \
        | awk '{print length, $0}' \
        | sort -n \
        | cut -d " " -f2- \
        | tee -a $set_index
}
export -f build_index

find -L . -mindepth 1 -maxdepth 1 -type d ! -path './.git' ! -path './_build' \
    | xargs -n1 -I{} sh -c "cd {} && build_index"

ln -s "default/index.txt" "$BUILD_DIR/index.txt"
