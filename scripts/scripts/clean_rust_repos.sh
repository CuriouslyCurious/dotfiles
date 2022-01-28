#!/usr/bin/env bash
paths=$(find . -name Cargo.toml -type f -printf "%h\n")
echo $paths
for path in $paths; do
    (cd $path; cargo clean -v)
done
