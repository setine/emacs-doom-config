#!/bin/bash

set -e

if [ -z "$1" ]; then
    echo "Usage: $0 file.odt"
    exit 1
fi

tmp_dir="$(mktemp -d -t ci-XXXXXXXXXX)"
odt_file="$(realpath "$1")"

echo "## Removing bookmarks"
unzip -d "$tmp_dir" "$1" content.xml
pushd "$tmp_dir"
perl -pi -e 's/<text:bookmark[^>]*>//g' content.xml
zip -r "$odt_file" content.xml
popd
rm -r "$tmp_dir"
echo "## Done"
